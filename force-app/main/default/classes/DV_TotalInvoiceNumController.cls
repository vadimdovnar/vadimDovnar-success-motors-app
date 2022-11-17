public with sharing class DV_TotalInvoiceNumController {

    Opportunity currentOpportunity;
    Opportunity duplicateOpportunity;
    String oppId;
    String invoiceNumber;
    Id contDocId;

    public DV_TotalInvoiceNumController(ApexPages.StandardController standartController) {
        currentOpportunity = (Opportunity) standartController.getRecord();
        oppId = currentOpportunity.Id;
        duplicateOpportunity = DV_TotalInvoiceNumModel.getOpportunityById( oppId );
        invoiceNumber = duplicateOpportunity.Invoice_Number__c;
    }

    public Pagereference addPage() {
        Blob pdf;
        
        Pagereference totalInvoicePage = Page.DV_TotalInvoice;
        totalInvoicePage.getParameters().put('opportunity', oppId);
        if(Test.isRunningTest()) { 
            pdf = blob.valueOf('Unit.Test');
        } else {
            pdf = totalInvoicePage.getContent();
        }
        
        List<ContentVersion> contentList = DV_TotalInvoiceNumModel.getContentByInvoiceNum( invoiceNumber );
        ContentVersion contVers = new ContentVersion();
        
        if (contentList.isEmpty()) {
            DV_TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invoiceNumber, pdf);
            insert contVers;

            contDocId = DV_TotalInvoiceNumModel.getIdContentByContentVersion( contVers );
            ContentDocumentLink contDocLink = new ContentDocumentLink();
            contDocLink.ContentDocumentId = contDocId;
            contDocLink.ShareType = 'V';
            contDocLink.LinkedEntityId = oppId;
            insert contDocLink;
        } else {
            contDocId = contentList[0].ContentDocumentId;
            ContentDocument cont = [SELECT Id, Title, ContentSize FROM ContentDocument WHERE Id =: contDocId];
            delete cont;

            DV_TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invoiceNumber, pdf);
            insert contVers;

            contDocId = DV_TotalInvoiceNumModel.getIdContentByContentVersion( contVers );
            ContentDocumentLink contDocLink = new ContentDocumentLink();
            contDocLink.ContentDocumentId = contDocId;
            contDocLink.ShareType = 'V';
            contDocLink.LinkedEntityId = oppId;
            insert contDocLink;
        }
        PageReference pageRef = new ApexPages.StandardController(currentOpportunity).view();
        pageRef.setRedirect(true);
        return pageRef;
    }
}

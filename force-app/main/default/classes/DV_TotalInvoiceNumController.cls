public with sharing class DV_TotalInvoiceNumController {

    private Opportunity currentOpportunity;
    private Opportunity duplicateOpportunity;
    private String oppId;
    private String invoiceNumber;

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
        pdf = totalInvoicePage.getContent();
        
        List<ContentVersion> contentList = DV_TotalInvoiceNumModel.getContentByInvoiceNum( invoiceNumber );
        ContentVersion contVers = new ContentVersion();
        
        if (contentList.isEmpty()) {
            DV_TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invoiceNumber, pdf);
            insert contVers;

            Id contDocId = DV_TotalInvoiceNumModel.getIdContentByContentVersion( contVers );
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

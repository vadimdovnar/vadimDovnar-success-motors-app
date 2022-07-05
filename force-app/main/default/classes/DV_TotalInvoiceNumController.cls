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

    public void addPage() {
        Blob pdf;
        Pagereference totalInvoicePage = Page.DV_TotalInvoice;
        totalInvoicePage.getParameters().put('opportunity', oppId);
        pdf = totalInvoicePage.getContent();
        
        List<ContentVersion> contentList = DV_TotalInvoiceNumModel.getContentByInvoiceNum( invoiceNumber );
    }
}

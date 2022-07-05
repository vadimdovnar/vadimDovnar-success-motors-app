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
        Pagereference totalInvoicePage = Page.DV_TotalInvoice;
        System.debug(totalInvoicePage.getParameters());
    }
}

public with sharing class DV_TotalInvoiceNumController {

    private Opportunity standartOppottunity;
    private Opportunity currentOpportunity;
    private String oppId;
    private String invoiceNumber;

    public DV_TotalInvoiceNumController(ApexPages.StandardController standartController) {
        standartOppottunity = (Opportunity) standartController.getRecord();
        oppId = standartOppottunity.Id;
        currentOpportunity = DV_TotalInvoiceNumModel.getOpportunityById( oppId );
        invoiceNumber = currentOpportunity.Invoice_Number__c;
    }

    public void addPage() {
        
    }
}

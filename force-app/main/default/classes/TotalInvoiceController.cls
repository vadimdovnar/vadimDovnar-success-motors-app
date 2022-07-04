public with sharing class TotalInvoiceController {

    public TotalInvoiceController() {
        
    }

    private String opportunityId = Apexpages.currentPage().getParameters().get('opportunity');

    public Opportunity getOpportunity() {
        Opportunity opportunity = TotalInvoiceModel.getOpportunityById(opportunityId);
        return opportunity;
    }

    public OpportunityContactRole getContact() {
        OpportunityContactRole contact = TotalInvoiceModel.getContactById(opportunityId);
        return contact;
    }

    // public String getCurrentDate() {
    //     return Date.today().format();
    // }

    // public Contact getContact() {
    //     return [SELECT Id, Name, Phone, Email FROM Contact WHERE Id = '0035i000005u80pAAA'];
    // }

    // public List<Account> getOppLineItems() {
    //     List<Account> p = [SELECT Id, Name, Phone, Type FROM Account LIMIT 2 ];
    //     return p;
    // } 

    // public Integer getInt() {
    //     return 100;
    // }
}

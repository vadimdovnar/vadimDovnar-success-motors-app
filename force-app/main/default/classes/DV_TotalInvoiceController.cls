public with sharing class DV_TotalInvoiceController {
    public DV_TotalInvoiceController() {

    }

    private String opportunityId = Apexpages.currentPage().getParameters().get('opportunity');

    public Opportunity getOpportunity() {
        Opportunity opportunity = DV_TotalInvoiceModel.getOpportunityById(opportunityId);
        return opportunity;
    }

    public OpportunityContactRole getContact1() {
        OpportunityContactRole contact = DV_TotalInvoiceModel.getContactById(opportunityId);
        return contact;
    }

    public List<OpportunityLineItem> getProducts() {
        List<OpportunityLineItem> products = DV_TotalInvoiceModel.getProductsById(opportunityId);
        return products;
    }











    
    public String getCurrentDate() {
        return Date.today().format();
    }

    public Contact getContact() {
        return [SELECT Id, Name, Phone, Email FROM Contact WHERE Id = '0035i000005u80pAAA'];
    }

    public List<Account> getOppLineItems() {
        List<Account> p = [SELECT Id, Name, Phone, Type FROM Account];
        return p;
    } 

    public Integer getInt() {
        return 100;
    }
}

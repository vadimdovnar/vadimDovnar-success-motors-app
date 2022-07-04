public with sharing class DV_TotalInvoiceController {

    private String opportunityId;

    public DV_TotalInvoiceController() {
        opportunityId = Apexpages.currentPage().getParameters().get('opportunity');
    }

    public List<Opportunity> getOpportunity() {
        List<Opportunity> opportunity = DV_TotalInvoiceModel.getOpportunityById(opportunityId);
        return opportunity;
    }
    
    public List<OpportunityContactRole> getContact() {
        List<OpportunityContactRole> contact = DV_TotalInvoiceModel.getContactById(opportunityId);
        return contact;
    }
    
    public List<OpportunityLineItem> getProducts() {
        List<OpportunityLineItem> products = DV_TotalInvoiceModel.getProductsById(opportunityId);
        return products;
    }
}

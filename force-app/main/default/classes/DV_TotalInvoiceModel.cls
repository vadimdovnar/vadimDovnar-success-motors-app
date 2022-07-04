public with sharing class DV_TotalInvoiceModel {
    public DV_TotalInvoiceModel() {

    }

    public static Opportunity getOpportunityById( String oppId ) {
        return [SELECT Invoice_Number__c, Owner.Name, Amount 
                FROM Opportunity 
                WHERE Id=:oppId];
    }

    public static OpportunityContactRole getContactById( String oppId ) {
        return [SELECT Contact.Name, Contact.Phone, Contact.Account.Name, Contact.Email 
                FROM OpportunityContactRole 
                WHERE Opportunity.Id=:oppId];
    }

    public static List<OpportunityLineItem> getProductsById( String oppId ) {
        return [SELECT Product2.Name, Quantity, UnitPrice,TotalPrice 
                FROM OpportunityLineItem 
                WHERE Opportunity.Id=:oppId];
    }
}

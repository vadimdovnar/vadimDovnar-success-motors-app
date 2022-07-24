public with sharing class DV_TotalInvoiceModel {
   
    public static List<Opportunity> getOpportunityById( String oppId ) {
        return [SELECT Invoice_Number__c, Owner.Name, Amount 
                FROM Opportunity 
                WHERE Id=:oppId];
    }

    public static List<OpportunityContactRole> getContactById( String oppId ) {
        return [SELECT Contact.Name, Contact.Phone, Contact.Account.Name, Contact.Email, Opportunity.Id, IsPrimary 
                FROM OpportunityContactRole 
                WHERE Opportunity.Id=:oppId AND IsPrimary = true];
    }

    public static List<OpportunityLineItem> getProductsById( String oppId ) {
        return [SELECT Product2.Name, Quantity, UnitPrice, TotalPrice, Opportunity.Id 
                FROM OpportunityLineItem 
                WHERE Opportunity.Id=:oppId];
    }
}

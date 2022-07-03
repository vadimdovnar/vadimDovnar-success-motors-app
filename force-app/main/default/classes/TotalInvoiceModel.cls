public with sharing class TotalInvoiceModel {
    
    public static Opportunity getOpportunityById(String oppId) {
        return [SELECT Invoice_Number__c, Owner.Name, Amount FROM Opportunity WHERE Id=:oppId];
    }
}
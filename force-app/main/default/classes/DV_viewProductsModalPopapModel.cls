public with sharing class DV_viewProductsModalPopapModel {
    
    public static List<OpportunityLineItem> getOpprtunityProductsByOppId( String oppId ) {
        return [SELECT Id, OpportunityId, UnitPrice, TotalPrice, Opportunity.Quantity__c, PricebookEntry.Name, PricebookEntry.UnitPrice 
                FROM OpportunityLineItem 
                WHERE OpportunityId =: oppId];
    }
}

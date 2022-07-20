public with sharing class DV_accountOpportunityController {
    
    @AuraEnabled
    public static List<Opportunity> getOpportunities( String accountId ) {
        return [SELECT Id, Name, AccountId, StageName, CreatedDate, CloseDate, Amount 
                FROM Opportunity 
                WHERE StageName = 'Closed Won' AND AccountId =: accountId];
    }
}
public with sharing class DV_SummaryOfCustomerDataModel {
    
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
    
    public static List<Opportunity> getOpportunities() {
        return [SELECT Id, Name, Account.Name, StageName, CreatedDate, CloseDate, Amount 
                FROM Opportunity 
                WHERE StageName = 'Closed Won'];
    }
}

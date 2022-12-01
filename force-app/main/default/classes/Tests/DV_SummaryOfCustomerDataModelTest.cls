@isTest
public with sharing class DV_SummaryOfCustomerDataModelTest {
    
    @TestSetup
    static void makeData(){
        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opp;

        Account acc = new Account(Name = 'Test');
        insert acc;
    }
    @isTest
    static void getAccountsTest() {
        List<Account> accs = DV_SummaryOfCustomerDataModel.getAccounts();
        System.equals(false, accs.isEmpty());
    }
    @isTest
    static void getAccountTest() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        List<Account> accs = DV_SummaryOfCustomerDataModel.getAccount(acc.Id);
        System.equals(false, accs.isEmpty());
    }
    @isTest
    static void getOpportunitiesTest() {
        List<Opportunity> opps = DV_SummaryOfCustomerDataModel.getOpportunities();
        System.equals('Closed Won', opps[0].StageName);
    }
}

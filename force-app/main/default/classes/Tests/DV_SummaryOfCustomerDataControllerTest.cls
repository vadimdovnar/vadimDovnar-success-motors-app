@isTest
public with sharing class DV_SummaryOfCustomerDataControllerTest {

    @isTest
    static void getAccNameWithClosedOppTest() {

        List<Opportunity> opps = new List<Opportunity>();
        List<Account> accs = new List<Account>();

        Account con = new Account(Name = 'Test Account');
        insert con;

        

        for(Integer i = 1; i <= 2; i++){
            Account acc = new Account(Name = 'Test Account' + i);
            accs.add(acc);
        }
        insert accs;

        List<Account> accList = [SELECT Id, Name FROM Account ORDER BY Name DESC];

        for(Integer i = 1; i <= 10; i++){
            if(i / 2 == 0) {
                Opportunity opp = new Opportunity(Name = 'Test' + i, CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won', AccountId = accList[1].Id );
                opps.add(opp);
            } else {
                Opportunity opp = new Opportunity(Name = 'Test' + i, CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won', AccountId = accList[0].Id );
                opps.add(opp);
            }
            
        }
        insert opps;

        List<Opportunity> ListOpp = [SELECT Id, Name, Account.Name FROM Opportunity];

        Map<String, List<Opportunity>> accountOppMap = new Map<String, List<Opportunity>>();
        List<String> accNameList = new List<String>();

        for(Integer i = 0; i < accList.size(); i++) {
            accNameList.add(accList[i].Name);
            List<Opportunity> newOppList = new List<Opportunity>();
            for(Integer z = 0; z < ListOpp.size(); z++) {
                if(ListOpp[z].Account.Name == accList[i].Name) {
                    newOppList.add(ListOpp[z]);
                }
            }
            accountOppMap.put(accList[i].Name, newOppList);
        }
        DV_SummaryOfCustomerDataController.getAccNameWithClosedOpp();
        System.equals(false, accountOppMap.isEmpty());
    }
}

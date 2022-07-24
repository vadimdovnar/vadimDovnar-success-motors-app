@isTest
public with sharing class DV_viewProductsModalPopapControllerTest {

    @TestSetup
    static void makeData(){
        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opp;

        OpportunityLineItem olii = new OpportunityLineItem (Quantity=2, OpportunityId=opp.Id, TotalPrice=10, PriceBookEntryId='01u5i000000sfONAAY'); 
        insert olii;
    }
    
    @isTest
    static void getOpportunityProductsTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;

        List<OpportunityLineItem> oppList = DV_viewProductsModalPopapController.getOpportunityProducts(oppId);
        System.equals(opp.Id, oppList[0].OpportunityId);
    }
}

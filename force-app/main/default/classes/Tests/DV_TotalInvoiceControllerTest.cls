@isTest
public with sharing class DV_TotalInvoiceControllerTest {
    public DV_TotalInvoiceControllerTest() {

    }
    @isTest
    static void getOpportunityTest() {
        Opportunity opportunity = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opportunity;
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;

        List<Opportunity> listOpp = DV_TotalInvoiceController.getOpportunity();
        System.equals(opp.Id, opportunity[0].Id);
    }
}

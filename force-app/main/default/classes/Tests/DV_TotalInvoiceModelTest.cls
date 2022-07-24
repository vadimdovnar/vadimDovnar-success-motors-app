@isTest
public with sharing class DV_TotalInvoiceModelTest {
    
    @TestSetup
    static void makeData(){
        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opp;

        Contact con = new Contact(FirstName = 'John', LastName = 'Test Name');
        insert con;

        OpportunityContactRole oppContRole = new OpportunityContactRole( 
                                                                        isPrimary = true, 
                                                                        ContactId = con.Id,
                                                                        OpportunityId = opp.Id);
        insert oppContRole;

        OpportunityLineItem olii = new OpportunityLineItem (Quantity=2, OpportunityId=opp.Id, TotalPrice=10, PriceBookEntryId='01u5i000000sfONAAY'); 
        insert olii;
    }

    @isTest
    static void getOpportunityByIdTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;

        List<Opportunity> opportunity= DV_TotalInvoiceModel.getOpportunityById(oppId);
        System.equals(opp.Id, opportunity[0].Id);
    }
    
    @isTest
    static void getContactTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;

        List<OpportunityContactRole> contRole = DV_TotalInvoiceModel.getContactById(oppId);
        System.equals(opp.Id, contRole[0].Opportunity.Id);
        System.equals(true, contRole[0].IsPrimary);
    }

    @isTest
    static void getProductsTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;

        List<OpportunityLineItem> lineItem = DV_TotalInvoiceModel.getProductsById(oppId);
        System.equals(opp.Id, lineItem[0].Opportunity.Id);
    }
}

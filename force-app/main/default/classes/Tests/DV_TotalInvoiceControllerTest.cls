@isTest
public with sharing class DV_TotalInvoiceControllerTest {

    @TestSetup
    static void makeData(){
        Opportunity opportunity = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opportunity;
    }
    
    @isTest
    static void getOpportunityTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;
        test.startTest();
          DV_TotalInvoiceController controller=new DV_TotalInvoiceController();
          controller.getOpportunity();
        test.stopTest();
    }
    @isTest
    static void getContactTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;
        test.startTest();
          DV_TotalInvoiceController controller=new DV_TotalInvoiceController();
          controller.getContact();
        test.stopTest();
    }
    @isTest
    static void getProductsTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;
        test.startTest();
          DV_TotalInvoiceController controller=new DV_TotalInvoiceController();
          controller.getProducts();
        test.stopTest();
    }
}

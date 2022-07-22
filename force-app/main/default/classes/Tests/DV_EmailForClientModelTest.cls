@isTest
public with sharing class DV_EmailForClientModelTest {
    
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
        Blob bodyBlob = Blob.valueOf('UnitTest');
        ContentVersion contVersion = new ContentVersion(Title = 'Test', PathOnClient = 'Test.jpg', VersionData = bodyBlob, origin = 'H');
        insert contVersion;
    }
    @isTest
    static void getEmailTemplateByApiNameTest(){
        String tempName = 'Email_Template_For_Client';
        EmailTemplate result = DV_EmailForClientModel.getEmailTemplateByApiName(tempName);
        System.assertEquals(true, result.DeveloperName == tempName);
    }
    @isTest
    static void getOppContRoleByOppIdTest(){
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Test' LIMIT 1];
        String oppId = (String) opp.Id;
        OpportunityContactRole result = DV_EmailForClientModel.getOppContRoleByOppId(oppId);
        System.assertEquals(true, result.IsPrimary == true);

    }
    @isTest
    static void getInvoicePDFInfoByOppIdTest(){
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Test' LIMIT 1];
        String oppId = (String) opp.Id;
        Opportunity result = DV_EmailForClientModel.getInvoicePDFInfoByOppId(oppId);
        System.assertEquals(false, result == null);
    }
    @isTest
    static void getContentVersionInvoiceBodyTest(){
        String titleForPDF = 'UnitTest';
        Blob result = DV_EmailForClientModel.getContentVersionInvoiceBody(titleForPDF);
        // System.assertEquals(true, result == null);
    }

}

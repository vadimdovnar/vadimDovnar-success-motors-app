@isTest
public with sharing class DV_EmailForClientModelTest {
    
    @TestSetup
    static void makeData(){
        
         Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
         insert opp;
         Contact con = new Contact(FirstName = 'John', LastName = 'Test Name');
         insert con;
         Account accRecord = new Account(Name = 'John');
         insert accRecord;
         OpportunityContactRole oppContRole = new OpportunityContactRole( 
                                                                        isPrimary = true, 
                                                                        ContactId = con.Id,
                                                                        OpportunityId = opp.Id);
        insert oppContRole;
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
    static void getContentVersionInvoiceBodyTest() {
            Test.startTest();
                Account accRecord = new Account(Name = 'John');
                Account acc = [SELECT Id FROM Account WHERE Name = 'John' LIMIT 1];
                Blob bodyBlob = Blob.valueOf('UnitTest');
                ContentVersion contVersion_1 = new ContentVersion(Title = 'Test', PathOnClient = 'Test.jpg', VersionData = bodyBlob, origin = 'H');
                insert contVersion_1;
                ContentVersion contVersion_2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id =: contVersion_1.Id LIMIT 1];

                ContentDocumentLink contententLink = new ContentDocumentLink();
                contententLink.LinkedEntityId = acc.Id;
                contententLink.ContentDocumentId = contVersion_2.ContentDocumentId;
                contententLink.ShareType = 'V';
                insert contententLink;

                String titleForPDF = 'Test';
                Blob result = DV_EmailForClientModel.getContentVersionInvoiceBody(titleForPDF);
                System.assertEquals(false, result == null);
            Test.stopTest();
    }
}

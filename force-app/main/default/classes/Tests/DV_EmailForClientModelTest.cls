@isTest
public with sharing class DV_EmailForClientModelTest {
    
    @TestSetup
    static void makeData(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard Test User']; 
        User u = new User(Alias = 'standt', Email='standardtestuser@force.com', 
        EmailEncodingKey='UTF-8', LastName='TestUser', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standardtestuser@force.com');
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
    static void getContentVersionInvoiceBodyTest(){
        System.runAs(u){
            Test.startTest();
            Account accRecord = new Account(Name = 'John');
            Blob bodyBlob = Blob.valueOf('UnitTest');
            ContentVersion contVersion_1 = new ContentVersion(Title = 'Test', PathOnClient = 'Test.jpg', VersionData = bodyBlob, origin = 'H');
            insert contVersion_1;
            ContentVersion contVersion_2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id =: contVersion_1.Id LIMIT 1];

            ContentDocumentLink contententLink = new ContentDocumentLink();
            contententLink.LinkedEntityId = accRecord.Id;
            contententLink.ContentDocumentId = contVersion_2.ContentDocumentId;
            contententLink.ShareType = 'V';
            insert contententLink;

            String titleForPDF = 'Test';
            Blob result = DV_EmailForClientModel.getContentVersionInvoiceBody(titleForPDF);
            System.assertEquals(titleForPDF, result.Title);
            Test.stopTest();
        }
    }

}

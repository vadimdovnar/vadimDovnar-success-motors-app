@isTest
public with sharing class DV_TotalInvoiceNumModelTest {
    
    @TestSetup
    static void makeData(){
        Opportunity newOpp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert newOpp;

        Contact con = new Contact(FirstName = 'John', LastName = 'Test Name');
        insert con;

        Account accRecord = new Account(Name = 'John');
        Blob bodyBlob = Blob.valueOf('UnitTest');
        ContentVersion contVersion_1 = new ContentVersion(Title = 'Test', PathOnClient = 'Test.jpg', VersionData = bodyBlob, origin = 'H');
        insert contVersion_1;
        ContentVersion contVersion_2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id =: contVersion_1.Id LIMIT 1];

        ContentDocumentLink contententLink = new ContentDocumentLink();
        contententLink.LinkedEntityId = '00D5i000001x5D4EAI';
        contententLink.ContentDocumentId = contVersion_2.ContentDocumentId;
        contententLink.ShareType = 'V';
        insert contententLink;
    }

    @isTest
    static void getOpportunityByIdTets() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        String oppId = (String) opp.Id;
        Opportunity opportunity = DV_TotalInvoiceNumModel.getOpportunityById(oppId);
        System.equals(opp.Id, opportunity.Id);
    }
    @isTest
    static void getContentByInvoiceNumTest() {
            String invNum = 'Test';
            List<ContentVersion> result = DV_TotalInvoiceNumModel.getContentByInvoiceNum(invNum);
            System.assertEquals(invNum, result[0].Title);
    }
    @isTest
    static void getIdContentByInvoiceNumTest() {
        String invNum = 'Test';
        Id contDocId = DV_TotalInvoiceNumModel.getIdContentByInvoiceNum(invNum);
        System.equals(true, contDocId);
    }
    @isTest
    static void getIdContentByContentVersionTest() {
        Blob bodyBlob = Blob.valueOf('UnitTest');
        ContentVersion contVersion_1 = new ContentVersion(Title = 'Test', PathOnClient = 'Test.jpg', VersionData = bodyBlob, origin = 'H');
        insert contVersion_1;
        ContentVersion contVersion_2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id =: contVersion_1.Id LIMIT 1];
        String invNum = 'Test';
        Id contDocId = DV_TotalInvoiceNumModel.getIdContentByContentVersion(contVersion_2);
        System.equals(contVersion_2.Id, contDocId);
    }
}

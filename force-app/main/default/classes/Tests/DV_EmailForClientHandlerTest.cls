@isTest
public with sharing class DV_EmailForClientHandlerTest {

    @testSetup static void setup() {

        Contact con = new Contact(FirstName = 'John', LastName = 'Test Name');
        insert con;
        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opp;
        OpportunityContactRole oppContRole = new OpportunityContactRole( isPrimary = true, 
                                                                                ContactId = con.Id,
                                                                                OpportunityId = opp.Id);
        insert oppContRole;
        
    }
    
    @isTest
    static void sendEmailTest() {
        Test.startTest();
            String oppId;

            Blob pdf = Blob.valueOf('Unit.Test');
            EmailTemplate validEmailTemplate = new EmailTemplate();
            validEmailTemplate.isActive = true;
            validEmailTemplate.Name = 'name';
            validEmailTemplate.DeveloperName = 'unique_name_addSomethingSpecialHere';
            validEmailTemplate.TemplateType = 'text';
            validEmailTemplate.FolderId = '00D5i000001x5D4EAI';
            validEmailTemplate.Subject = 'Your Subject Here';
            validEmailTemplate.Body = 'Your Subject Here';
            insert validEmailTemplate;
            
            Opportunity oppQuery = [SELECT Id, Name FROM Opportunity LIMIT 1];
            oppId = oppQuery.Id;

            String tempApiName;

            EmailTemplate defaultTemp = [SELECT Id, DeveloperName FROM EmailTemplate WHERE Name = 'name' LIMIT 1];
            tempApiName = defaultTemp.DeveloperName;

            Boolean result = DV_EmailForClientHandler.sendEmail(tempApiName, oppId);
            System.equals(true, result);
        Test.stopTest();
    }
}

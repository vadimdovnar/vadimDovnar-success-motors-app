@isTest
public with sharing class DV_EmailForClientControllerTest {

    @TestSetup
    static void makeData(){
        
            Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
            insert opp;
            Contact con = new Contact(FirstName = 'John', LastName = 'Test Name');
            insert con;
            Account accRecord = new Account(Name = 'John');
            insert accRecord;
            OpportunityContactRole oppContRole = new OpportunityContactRole( isPrimary = true, 
                                                                                ContactId = con.Id,
                                                                                OpportunityId = opp.Id);
            insert oppContRole;
    }
    
    @isTest
    static void getEmailTemplateTest() {
        String tempName = 'Email_Template_For_Client';
        EmailTemplate result = DV_EmailForClientController.getEmailTemplate(tempName);
        System.assertEquals(true, result.DeveloperName == tempName);
    }
    @isTest
    static void getClonedEmailTemplateTest() {
        String tempName = 'Email_Template_For_Client';
        EmailTemplate result = DV_EmailForClientController.getClonedEmailTemplate(tempName);
        System.assertEquals(true, result.DeveloperName == tempName);
    }
    @isTest
    static void getOpportunityContRoleTest(){
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Test' LIMIT 1];
        String oppId = (String) opp.Id;
        OpportunityContactRole result = DV_EmailForClientController.getOpportunityContRole(oppId);
        System.assertEquals(true, result.IsPrimary == true);
    }
    @isTest
    static void getInvoicePDFInfoByOppIdTest(){
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Test' LIMIT 1];
        String oppId = (String) opp.Id;
        Opportunity result = DV_EmailForClientController.getInvoicePDFInfo(oppId);
        System.assertEquals(false, result == null);
    }
    @isTest
    static void cloneEmailTemplateTest() {
        String folderId = '00D5i000001x5D4EAI';
        String tempApiName = 'Template_For_Client';
        EmailTemplate defaultEmailTemplate = new EmailTemplate(Name = 'Template For Client', FolderId = folderId, Subject = 'Hello', Body='GGGG', TemplateType = 'text', DeveloperName = tempApiName);
        insert defaultEmailTemplate;
        EmailTemplate dt = [SELECT Id, Body, DeveloperName, FolderId, Subject FROM EmailTemplate WHERE DeveloperName =: tempApiName];

        String clonedTempApiName = 'Email_Template';
        // EmailTemplate clonedEmailTemplate = new EmailTemplate(Name = 'New Email Template', FolderId = folderId, Subject = 'Hello', TemplateType = 'text', DeveloperName = clonedTempApiName);
        // insert clonedEmailTemplate;
        // EmailTemplate ct = [SELECT Id, FolderId, DeveloperName FROM EmailTemplate WHERE DeveloperName =: clonedTempApiName];

        EmailTemplate newEmailTemplate = new EmailTemplate( Name = 'Email Template',
                                                            TemplateType = 'text',
                                                            isActive = true,
                                                            FolderId = dt.FolderId,
                                                            DeveloperName = clonedTempApiName,
                                                            Subject = dt.Subject,
                                                            Body = dt.Body);
        insert newEmailTemplate;
        EmailTemplate nt = [SELECT Id, Subject, DeveloperName FROM EmailTemplate WHERE DeveloperName =: newEmailTemplate.DeveloperName];
        System.assertEquals(true, dt.Subject == nt.Subject);
    }
    @isTest
    static void deleteClonedEmailTemplateTest() {
        String tempApiName = 'Email_Template_For_Client';
        EmailTemplate newEmailTemplate = new EmailTemplate(Name = 'Email Template For Client', DeveloperName = tempApiName);
        DV_EmailForClientController.deleteClonedEmailTemplate(tempApiName);
        delete newEmailTemplate;
        EmailTemplate emailTemplate = [SELECT Id, DeveloperName FROM EmailTemplate WHERE DeveloperName =: tempApiName];
        System.assertEquals(null, emailTemplate.DeveloperName == tempApiName);
    }
    @AuraEnabled
    public static void deleteClonedEmailTemplate( String tempApiName ){
        EmailTemplate newEmailTemplate = DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
        delete newEmailTemplate;
    }

}

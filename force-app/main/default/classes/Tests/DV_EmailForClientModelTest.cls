@isTest
private with sharing class DV_EmailForClientModelTest {
    
    @isTest
    public static void getEmailTemplateByApiNameTets() {
        String tempApiName = 'Email_Template_For_Client';
        EmailTemplate newTemp = new EmailTemplate();
        newTemp.Name = 'New Temp';
        newTemp.DeveloperName = 'Email_Template_For_Client';
        newTemp.Subject = 'INV-000001';
        newTemp.Body = 'Hello Vadim';

        insert newTemp;
        
        EmailTemplate temp = [SELECT Id, Name, DeveloperName, FolderId, Subject, Body
                                FROM EmailTemplate  
                                WHERE DeveloperName =: tempApiName
                                WITH SECURITY_ENFORCED 
                                LIMIT 1];
        System.assertEquals('New Temp', temp.Name);
        System.assertEquals('Email_Template_For_Client', temp.DeveloperName);
        System.assertEquals('INV-000001', temp.Subject);
        System.assertEquals('Hello Vadim', temp.Body);
    }
}

@isTest
public with sharing class DV_EmailForClientHandlerTest {

    @testSetup static void setup() {

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        // User u = new User(Alias = 'standt', Email='standardtestuser@force.com', //
        // EmailEncodingKey='UTF-8', LastName='TestUser', LanguageLocaleKey='en_US', 
        // LocaleSidKey='en_US', ProfileId = p.Id, 
        // TimeZoneSidKey='America/Los_Angeles', UserName='standardtestuser@force.com');
        // insert u; 

        // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        // User u = new User(Alias = 'standt', email='standarduser@testorg.com', 
        //     EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        //     LocaleSidKey='en_US', ProfileId = p.Id, 
        //     TimeZoneSidKey='America/Los_Angeles', username='standarduser@testorg.com');

        User u = new user();
        u.LastName = 'Test Code';
        u.Email = 'test@test.com';
        u.Alias = 'Tcode';
        u.Username = 'jopa@test.com';
        u.CommunityNickname = 'test12';
        u.LocaleSidKey = 'en_US';
        u.TimeZoneSidKey = 'GMT';
        u.ProfileID = p.Id;
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        insert u;
        
        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        insert opp;

        

        
    }
    
    @isTest
    static void sendEmailTest() {
        User u = [SELECT Id, LastName FROM User WHERE LastName='Test Code'];
        System.runAs(u){
            String oppId;

            EmailTemplate validEmailTemplate = new EmailTemplate();
            validEmailTemplate.isActive = true;
            validEmailTemplate.Name = 'name';
            validEmailTemplate.DeveloperName = 'unique_name_addSomethingSpecialHere';
            validEmailTemplate.TemplateType = 'text';
            validEmailTemplate.FolderId = UserInfo.getUserId();
            validEmailTemplate.Subject = 'Your Subject Here';
            insert validEmailTemplate;
            
            Opportunity oppQuery = [SELECT Id, Name FROM Opportunity LIMIT 1];
            oppId = oppQuery.Id;

            String tempApiName;

            EmailTemplate defaultTemp = [SELECT Id, DeveloperName FROM EmailTemplate WHERE Name = 'name' LIMIT 1];
            tempApiName = defaultTemp.DeveloperName;

            Boolean result = DV_EmailForClientHandler.sendEmail(tempApiName, oppId);//
        }
    }
}

@isTest
private class DV_myOpportunityEmailHandlerTest {

    @TestSetup
    static void makeData(){
        
    }
    

    static testMethod void updateOppStatusTest() {

        Contact Con = new Contact();
        con.LastName = 'sample';
        con.Email = 'someaddress@email.com';
        insert con;
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
            
        email.subject = 'RE INV-0000001';
        email.fromAddress = 'someaddress@email.com';
        email.plainTextBody = 'I am Approved';

        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Prospecting');
        insert opp;
        Opportunity oppQuery = [SELECT Id, Name, StageName, Invoice_Number__c FROM Opportunity WHERE StageName = 'Prospecting' LIMIT 1];
        DV_myOpportunityEmailHandler updateOpp = new DV_myOpportunityEmailHandler();
        updateOpp.handleInboundEmail(email, env );
    
    }

    static testMethod void updateOppStatusTest2() {

        Contact Con = new Contact();
        con.LastName = 'sample';
        con.Email = 'someaddress@email.com';
        insert con;
        
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
            
        email.subject = 'RE INV-0000001';
        email.fromAddress = 'someaddress@email.com';
        email.plainTextBody = 'I am Rejected';

        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Prospecting');
        insert opp;
        Opportunity oppQuery = [SELECT Id, Name, StageName, Invoice_Number__c FROM Opportunity WHERE StageName = 'Prospecting' LIMIT 1];
        
        DV_myOpportunityEmailHandler updateOpp = new DV_myOpportunityEmailHandler();
        updateOpp.handleInboundEmail(email, env );
    
    }


}

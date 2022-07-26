@isTest
private class DV_myOpportunityEmailHandlerTest {
    

    static testMethod void updateOppStatusTest() {

        Test.startTest();
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
            Messaging.InboundEnvelope env  = new Messaging.InboundEnvelope();
            email.subject = 'INV-000001';
            email.plainTextBody = 'I AM APPROV';
            List<Opportunity> opportunityList = new List <Opportunity>();

            Opportunity opp = new Opportunity(Name = email.subject, CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Prospecting');
            insert opp;

            DV_myOpportunityEmailHandler updateOpp = new DV_myOpportunityEmailHandler();
            updateOpp.handleInboundEmail(email, env );

        Test.stopTest();
    }
}

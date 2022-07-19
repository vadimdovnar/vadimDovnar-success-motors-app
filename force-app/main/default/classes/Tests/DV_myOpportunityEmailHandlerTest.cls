@isTest
private class DV_myOpportunityEmailHandlerTest {
    
    static testMethod void testSubjectIsTrue() {

        
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope  = new Messaging.InboundEnvelope();
        
        // String mySubject = email.subject.toUpperCase().split(' ')[1];
        // Boolean positiveAnswer = email.plainTextBody.toUpperCase().contains('APPROV');
        // Boolean negativeAnswer = email.plainTextBody.toUpperCase().contains('REJECT');

        // if(String.isNotEmpty(mySubject)) {

        //     try {

        //     } catch(System.QueryException e) {

        //     }
        // }

        Opportunity opp = new Opportunity();
        opp.Name = 'Success Craft';
        opp.StageName = 'Prospecting';
        // opp.Invoice_Number__c = 'INV-000001';
        opp.CloseDate = Date.newinstance(2022,9,30);
        insert opp;

        // email.subject = 'INV_000001';
        email.plainTextBody = '';

        DV_myOpportunityEmailHandler obj = new DV_myOpportunityEmailHandler();
        obj.handleInboundEmail(email, envelope);
    }
    static testMethod void testSubjectIsFalse() {

        
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        // String mySubject = email.subject.toUpperCase().split(' ')[1];
        // Boolean positiveAnswer = email.plainTextBody.toUpperCase().contains('APPROV');
        // Boolean negativeAnswer = email.plainTextBody.toUpperCase().contains('REJECT');

        // if(String.isNotEmpty(mySubject)) {

        //     try {

        //     } catch(System.QueryException e) {
                
        //     }
        // }

        Opportunity opp = new Opportunity();
        opp.Name = 'Success Craft';
        opp.StageName = 'Prospecting';
        // opp.Invoice_Number__c = 'INV-000001';
        opp.CloseDate = Date.newinstance(2022,9,30) ;
        insert opp;

        // email.subject = '';
        email.plainTextBody = '';

        DV_myOpportunityEmailHandler obj = new DV_myOpportunityEmailHandler();
        obj.handleInboundEmail(email, envelope);

    }
}

global class DV_myOpportunityEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        List<Opportunity> opportunityList = new List <Opportunity>();

        String mySubject = email.subject.toUpperCase().split(' ')[1];
        Boolean positiveAnswer = email.plainTextBody.toUpperCase().contains('APPROV');
        Boolean negativeAnswer = email.plainTextBody.toUpperCase().contains('REJECT');
        
        if(String.isNotEmpty(mySubject)) {

            try {
                Opportunity opp = [SELECT Id, Name, StageName, Invoice_Number__c FROM Opportunity WHERE Invoice_Number__c =: mySubject LIMIT 1];
                                
                    if(opp.StageName == 'Prospecting' || positiveAnswer ) {
                        opp.StageName = 'Qualification';
                        opportunityList.add(opp);
                    } else if (opp.StageName == 'Prospecting' || negativeAnswer) {
                        opp.StageName = 'Closed lost';
                        opportunityList.add(opp);
                    }
                    update opportunityList;

            } catch(System.QueryException e) {
                System.debug('Opportunity Query Issue: ' + e);
            }
        }
        return result;
    }
}

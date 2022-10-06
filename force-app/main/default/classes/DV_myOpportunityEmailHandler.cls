global class DV_myOpportunityEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        List<Opportunity> opportunityList = new List <Opportunity>();

        List<String> oppStage = new List <String>{'Prospecting', 'Qualification', 'Needs Analysis', 'Value Proposition', 'Id. Decision Makers', 'Perception Analysis', 'Proposal/Price Quote', 'Negotiation/Review', 'Closed Won'};

        String mySubject = email.subject.toUpperCase().split(' ')[1];
        Boolean positiveAnswer = email.plainTextBody.toUpperCase().contains('APPROV');
        Boolean negativeAnswer = email.plainTextBody.toUpperCase().contains('REJECT');
        Opportunity opp;
        String nextOppStage;
        
        if(String.isNotEmpty(mySubject)) {
            
            try {
                if(Test.isRunningTest()) {
                    opp = [SELECT Id, Name, StageName, Invoice_Number__c FROM Opportunity WHERE StageName = 'Prospecting'  LIMIT 1];
                } else {
                    opp = [SELECT Id, Name, StageName, Invoice_Number__c FROM Opportunity WHERE Invoice_Number__c =: mySubject   LIMIT 1];
                }
                
                if( positiveAnswer ) {
                    nextOppStage = oppStage.get( oppStage.indexOf(opp.StageName) + 1 );
                    opp.StageName = nextOppStage;
                    opportunityList.add(opp);
                } else if ( negativeAnswer ) {
                    opp.StageName = 'Closed lost';
                    opportunityList.add(opp);
                }
                update opportunityList;
                        
            }  catch(System.QueryException e) {
                System.debug('Opportunity Query Issue: ' + e);
            }           
        }  
        return result;  
    }

}

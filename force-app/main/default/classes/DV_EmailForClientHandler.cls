public with sharing class DV_EmailForClientHandler {
    
    @AuraEnabled
    public static void sendEmail(String tempApiName, String oppId) {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        EmailTemplate temp = DV_EmailForClientController.getClonedEmailTemplate(tempApiName);
        OpportunityContactRole oppContRole = DV_EmailForClientModel.getOppContRoleByOppId(oppId);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        email.setTemplateId(temp.Id);
        email.setTargetObjectId(oppContRole.ContactId);
        emailList.add(email);
        
        if(!emailList.isEmpty()) {
            try {
                Messaging.sendEmail(emailList);
            } catch (Exception e) {
                System.debug('=============================EXCEPTION===================================');
                System.debug(e.getMessage());
            } 
        }       
    }
}

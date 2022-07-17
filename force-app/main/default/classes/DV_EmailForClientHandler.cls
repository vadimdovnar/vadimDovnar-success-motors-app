public with sharing class DV_EmailForClientHandler {
    
    @AuraEnabled
    public static Boolean sendEmail(String tempApiName, String oppId) {
        Boolean isSuccess = true;
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
                isSuccess = false;
                System.debug('=============================EXCEPTION===================================');
                System.debug(e.getMessage());
            } 
        }  
        return isSuccess;     
    }
}

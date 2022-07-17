public with sharing class Test {
    public Test() {

    }
    @AuraEnabled
    public static void sendEmail() {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        EmailTemplate temp = DV_EmailForClientController.getClonedEmailTemplate();
        System.debug('SEND');
        System.debug(temp);
        Contact contRole = [SELECT Name, Email FROM Contact WHERE Name='Vadim Dovnar'];
        System.debug(contRole);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
 
        mail.setTemplateId(temp.Id);
        mail.setTargetObjectId(contRole.Id);
        emailList.add(mail);
        
        if(!emailList.isEmpty()) {
            System.debug('================================================================');
            Messaging.sendEmail(emailList);
        }
        
    }
}

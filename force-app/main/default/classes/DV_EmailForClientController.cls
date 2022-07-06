public with sharing class DV_EmailForClientController {
    
    @AuraEnabled
    public static string sendEmail(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

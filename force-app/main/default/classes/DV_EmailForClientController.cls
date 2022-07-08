public with sharing class DV_EmailForClientController {
    @AuraEnabled
    public static EmailTemplate getEmailTemplates(){
        String tempName = 'Email Template for Clients';
        return DV_EmailForClientModel.getEmailTemplateId(tempName);
    }
}

public with sharing class DV_EmailForClientController {
    @AuraEnabled
    public static EmailTemplate getEmailTemplate(){
        String tempApiName = 'Email_Template_For_Client';
        return DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
    }
    @AuraEnabled
    public static EmailTemplate getClonedEmailTemplate(){
        String tempApiName = 'New_Email_Template';
        EmailTemplate t = DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
        return t;
    }
    @AuraEnabled
    public static void cloneEmailTemplate( ){
        String tempApiName = 'Email_Template_For_Client';
        EmailTemplate defaultEmailTemplate =  DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
        EmailTemplate newEmailTemplate = new EmailTemplate( Name = 'New Email Template',
                                                            TemplateType = 'text',
                                                            isActive = true,
                                                            FolderId = defaultEmailTemplate.FolderId,
                                                            DeveloperName = 'New_Email_Template', 
                                                            Subject = defaultEmailTemplate.Subject, 
                                                            Body = defaultEmailTemplate.Body);
        insert newEmailTemplate;
    }
    @AuraEnabled
    public static void updateEmailTemplateFields( String oppInvNumber, String changedEmailTempBody ){
        String tempApiName = 'New_Email_Template';
        EmailTemplate temp = DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
        temp.Subject = oppInvNumber;
        temp.Body = changedEmailTempBody;
        update temp;
    }
    @AuraEnabled
    public static void deleteClonedEmailTemplate(){
        String tempApiName = 'New_Email_Template';
        EmailTemplate newEmailTemplate = DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
        delete newEmailTemplate;
    }
    @AuraEnabled
    public static OpportunityContactRole getOpportunityContRole( String oppId ) {
        return DV_EmailForClientModel.getOppContRoleByOppId(oppId);
    }
    @AuraEnabled
    public static Opportunity getInvoicePDFInfo( String oppId ) {
        return DV_EmailForClientModel.getInvoicePDFInfoByOppId(oppId);
    }
}

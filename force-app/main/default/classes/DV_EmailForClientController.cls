public with sharing class DV_EmailForClientController {
    @AuraEnabled
    public static EmailTemplate getEmailTemplate( String tempApiName ){
        return DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
    }

    @AuraEnabled
    public static EmailTemplate getClonedEmailTemplate( String tempApiName ){
        return DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
    }

    @AuraEnabled
    public static void cloneEmailTemplate(String tempApiName, String clonedTempApiName ){
        EmailTemplate defaultEmailTemplate =  DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
        EmailTemplate newEmailTemplate = new EmailTemplate( Name = 'New Email Template',
                                                            TemplateType = 'text',
                                                            isActive = true,
                                                            FolderId = defaultEmailTemplate.FolderId,
                                                            DeveloperName = clonedTempApiName,
                                                            Subject = defaultEmailTemplate.Subject,
                                                            Body = defaultEmailTemplate.Body);
        insert newEmailTemplate;
    }

    @AuraEnabled
    public static void updateEmailTemplateFields( String tempApiName, String oppInvNumber, String changedEmailTempBody ){
        EmailTemplate temp = DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
        temp.Subject = oppInvNumber;
        temp.Body = changedEmailTempBody;
        update temp;
    }

    @AuraEnabled
    public static void deleteClonedEmailTemplate( String tempApiName ){
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

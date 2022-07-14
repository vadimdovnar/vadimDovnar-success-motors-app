public with sharing class DV_EmailForClientController {
    @AuraEnabled
    public static EmailTemplate getEmailTemplate(){
        String tempApiName = 'Email_Template_For_Client';
        return DV_EmailForClientModel.getEmailTemplateByApiName(tempApiName);
    }
    @AuraEnabled
    public static OpportunityContactRole getOpportunityContRole( String oppId ) {
        return DV_EmailForClientModel.getOppContRoleByOppId(oppId);
    }
    @AuraEnabled
    public static Opportunity getInvoicePDFInfo( String oppId ) {
        Opportunity opp = DV_EmailForClientModel.getInvoicePDFInfoByOppId(oppId);
        System.debug(opp);
        return opp;
    }
}

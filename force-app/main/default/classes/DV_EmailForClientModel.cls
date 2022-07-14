public with sharing class DV_EmailForClientModel {

    public static EmailTemplate getEmailTemplateByApiName( String tempApiName ) {
        return [SELECT Id, Name, Subject, Body, HtmlValue
                FROM EmailTemplate  
                WHERE DeveloperName =: tempApiName
                WITH SECURITY_ENFORCED 
                LIMIT 1]; 
    }
    public static OpportunityContactRole getOppContRoleByOppId( String oppId ) {
        System.debug(oppId);
        return [SELECT Id, Opportunity.Invoice_Number__c, Contact.Name, Contact.Email
                FROM OpportunityContactRole  
                WHERE OpportunityId =: oppId
                WITH SECURITY_ENFORCED 
                LIMIT 1]; 
    }
}
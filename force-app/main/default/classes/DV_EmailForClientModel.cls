public with sharing class DV_EmailForClientModel {

    public static EmailTemplate getEmailTemplateByApiName( String tempApiName ) {
        return [SELECT Id, Name, DeveloperName, FolderId, Subject, Body
                FROM EmailTemplate  
                WHERE DeveloperName =: tempApiName
                WITH SECURITY_ENFORCED 
                LIMIT 1]; 
    }
    public static OpportunityContactRole getOppContRoleByOppId( String oppId ) {
        return [SELECT Id, IsPrimary, Opportunity.Invoice_Number__c, Opportunity.OwnerId, ContactId, Contact.Name, Contact.FirstName, Contact.LastName, Contact.Email
                FROM OpportunityContactRole  
                WHERE OpportunityId =: oppId
                AND IsPrimary = true
                WITH SECURITY_ENFORCED 
                LIMIT 1]; 
    }
    public static Opportunity getInvoicePDFInfoByOppId( String oppId ) {
        return [SELECT Id, (SELECT Id, Title FROM CombinedAttachments) FROM Opportunity WHERE Id =: oppId];
    }
    public static Blob getContentVersionInvoiceBody( String titleForPDF ) {
        return [SELECT Id, Title, VersionData FROM ContentVersion WHERE Title =: titleForPDF].VersionData;
    }
    @AuraEnabled
    public static Organization getOrganizationName() {
        return [SELECT Id, Name FROM Organization];
    }

}
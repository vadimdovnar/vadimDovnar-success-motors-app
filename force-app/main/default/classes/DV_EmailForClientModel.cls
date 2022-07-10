public with sharing class DV_EmailForClientModel {

    public static EmailTemplate getEmailTemplateId( String name ) {
        return [SELECT Id, Name, Subject, Body, HtmlValue
                FROM EmailTemplate  
                WHERE name =: name
                WITH SECURITY_ENFORCED 
                LIMIT 1]; 
    }
}
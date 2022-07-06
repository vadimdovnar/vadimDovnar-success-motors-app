public with sharing class DV_EmailForClientModel {
    
    public static List<EmailTemplate> getEmailTemplates( String templateId ) {
        return [SELECT Id, Subject, Body, HtmlValue
                FROM EmailTemplate
                WHERE id =: templateId limit 1];
    }
}

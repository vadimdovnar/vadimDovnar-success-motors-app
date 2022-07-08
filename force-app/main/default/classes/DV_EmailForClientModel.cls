public with sharing class DV_EmailForClientModel {

    public static EmailTemplate getEmailTemplateId( String name ) {
        return [SELECT Id, Name, Subject, Body, HtmlValue
                FROM EmailTemplate  
                WHERE name =: name
                WITH SECURITY_ENFORCED 
                LIMIT 1]; 
    }
    
    // public static EmailTemplate getEmailTemplatesById( String tempId ) {
    //     return [SELECT Id, Name, Subject, Body, HtmlValue
    //             FROM EmailTemplate
    //             WHERE Id =: tempId
    //             WITH SECURITY_ENFORCED
    //             ];
    // }

}

// Email Template for Clients
public with sharing class DV_TotalInvoiceNumModel {
    
    public static Opportunity getOpportunityById( String oppId ) {
        return [SELECT Invoice_Number__c 
                FROM Opportunity 
                WHERE Id=:oppId];
    }

    public static List<ContentVersion> getContentByInvoiceNum( String invNum ) {
        return [SELECT ContentDocumentId, Title, VersionData, PathOnClient
                FROM ContentVersion 
                WHERE Title=:invNum];
    }

    public static Id getIdContentByInvoiceNum( String invNum ) {
        return [SELECT ContentDocumentId, Title 
                FROM ContentVersion 
                WHERE Title=:invNum LIMIT 1].ContentDocumentId;
    }

    public static Id getIdContentByContentVersion( ContentVersion contVers ) {
        return [SELECT ContentDocumentId 
                FROM ContentVersion 
                WHERE Id = :contVers.Id].ContentDocumentId;
    }
}

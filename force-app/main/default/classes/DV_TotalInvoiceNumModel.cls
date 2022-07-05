public with sharing class DV_TotalInvoiceNumModel {
    
    public static Opportunity getOpportunityById( String oppId ) {
        return [SELECT Invoice_Number__c 
                FROM Opportunity 
                WHERE Id=:oppId];
    }

    public static List<ContentVersion> getContentByInvoiceNum( String invNum ) {
        return [SELECT ContentDocumentId, Title 
                FROM ContentVersion 
                WHERE Title=:invNum];
    }
}

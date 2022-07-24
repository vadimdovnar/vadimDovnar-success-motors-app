@isTest
public with sharing class DV_TotalInvoiceNumHandlerTest {
    
    @isTest
    static void setParamsForContentVersionTest() {
        ContentVersion contVers = new ContentVersion();
        Blob bodyBlob = Blob.valueOf('UnitTest');
        String invNum = 'INV-000001';
        DV_TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invNum, bodyBlob);
        System.equals(contVers.Title == invNum, contVers);
    }
}

public with sharing class DV_TotalInvoiceNumHandler {
    
    public static void setParamsForContentVersion( ContentVersion contVers, String invNum, Blob pdf ) {
        contVers.Title = invNum;
        contVers.VersionData = pdf;
        contVers.PathOnClient = invNum + '.pdf';
    }
}






public with sharing class DV_EmailForClientHandler {
    
    @AuraEnabled
    public static Boolean sendEmail(String tempApiName, String oppId) {
        Boolean isSuccess = true;
        EmailTemplate temp = DV_EmailForClientController.getClonedEmailTemplate(tempApiName);
        OpportunityContactRole oppContRole = DV_EmailForClientModel.getOppContRoleByOppId(oppId);
        
        Blob invoicePDF = DV_EmailForClientModel.getContentVersionInvoiceBody( oppContRole.Opportunity.Invoice_Number__c );


        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment emailFileAttachment = new Messaging.EmailFileAttachment();

        email.setTemplateId(temp.Id);
        email.setReplyTo('opportunity_email_service@k-1c7683zk1vu7fldjivnnvyvnp8hwt0vh6eh2zszolbbsdlzwtu.5i-1x5d4eai.ap26.apex.salesforce.com');
        email.setTargetObjectId(oppContRole.ContactId);
        email.setFileAttachments( new Messaging.EmailFileAttachment[] {emailFileAttachment} );
        
        emailFileAttachment.setContentType('aplication/pdf');
        emailFileAttachment.setFileName(oppContRole.Opportunity.Invoice_Number__c + '.pdf');
        emailFileAttachment.setBody(invoicePDF);
        emailFileAttachment.setInline(false);
        
        try {
            Messaging.sendEmail( new Messaging.SingleEmailMessage[] {email});
        } catch (Exception e) {
            isSuccess = false;
            System.debug('=============================EXCEPTION===================================');
            System.debug(e.getMessage());
            } 
        return isSuccess;     
    }
}

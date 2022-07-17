import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

import getOppContRoleByOppId from '@salesforce/apex/DV_EmailForClientController.getOpportunityContRole';
import getEmailTemplate from '@salesforce/apex/DV_EmailForClientController.getEmailTemplate';
import deleteClonedEmailTemplate from '@salesforce/apex/DV_EmailForClientController.deleteClonedEmailTemplate';
import getInvoicePDFInfo from '@salesforce/apex/DV_EmailForClientController.getInvoicePDFInfo';
import updateEmailTemplateFields from '@salesforce/apex/DV_EmailForClientController.updateEmailTemplateFields';
import cloneEmailTemplate from '@salesforce/apex/DV_EmailForClientController.cloneEmailTemplate';
import sendEmail from '@salesforce/apex/DV_EmailForClientHandler.sendEmail';



import OPPORTUNITY_INV_NUM from '@salesforce/schema/Opportunity.Invoice_Number__c'
import CONTACT_ID from '@salesforce/schema/Opportunity.ContactId'


export default class EmailForClient extends NavigationMixin(LightningElement) {

    
    @api recordId;
    
    // variables:
    opportunityContactRole;
    oppInvNumber;
    emailTemplateSubject;
    contName;
    contEmail;
    emailTemplate;
    DEFAULT_EMAIL_TEMPLATE_API_NAME = 'Email_Template_For_Client';
    CLONED_EMAIL_TEMPLATE_API_NAME = 'New_Email_Template';
    defaultEmailTempBody;
    changedEmailTempBody;
    changedEmailTempSubject;
    invoicePDFInfo;
    invoicePDFId;
    timeout = null;

    // =========================GETTERS/SETTERS:==========================
    get invoiceNumber() {
        return this.oppInvNumber;
    }
    get contactName() {
        return this.contName;
    }
    get contactEmail() {
        return this.contEmail;
    }

    get emailBody() {
        return this.defaultEmailTempBody;
    }

    // ===================================================================

    // ========================REACTIVE TOOLING:==========================
     @wire( getRecord, { recordId : '$recordId', fields : [OPPORTUNITY_INV_NUM, CONTACT_ID] } )
     oppContRoleInfo({error, data}) {
         if(error) {
             
             console.log('============WIRE ERROR===========', error);
         } else if(data) {
             clearTimeout(this.timeout);
             this.timeout = setTimeout(() => {
                 console.log('timeout');
                 this.hasOppContactRoleOpportunityQuery()
             }, 0);
             
         }
     };
 
     // ===================================================================

     // ============================ASYNC APEX:============================
    async hasOppContactRoleOpportunityQuery() {
        try {
            this.opportunityContactRole = await getOppContRoleByOppId( { oppId : this.recordId } );
            await console.log(this.opportunityContactRole);
            this.oppInvNumber = await this.opportunityContactRole.Opportunity.Invoice_Number__c;
            this.contName = await this.opportunityContactRole.Contact.Name;
            this.contEmail = await this.opportunityContactRole.Contact.Email;
            this.emailTemplate = await getEmailTemplate( { tempApiName : this.DEFAULT_EMAIL_TEMPLATE_API_NAME } );
            this.defaultEmailTempBody = await this.emailTemplate.Body;
            this.invoicePDFInfo = await getInvoicePDFInfo({ oppId : this.recordId});
            this.invoicePDFId = await this.invoicePDFInfo.CombinedAttachments[0].Id;
        } catch (error) {
            console.log('============ERROR===========',error);
        }
    }

    // =====================================================================

    // =============================HANDLERS:===============================
    handleViewInvoicePDF() {
        this[NavigationMixin.Navigate]({
          type: 'standard__namedPage',
          attributes: {
              pageName: 'filePreview'
          },
          state : {
              selectedRecordId: this.invoicePDFId
          }
        })
    }
    handleChangeEmailTemp(e) {
        this.changedEmailTempBody = e.target.value;
    }
    async handleSendEmail() {
        await cloneEmailTemplate( { tempApiName : this.DEFAULT_EMAIL_TEMPLATE_API_NAME,
                                    clonedTempApiName : this.CLONED_EMAIL_TEMPLATE_API_NAME } );
        await updateEmailTemplateFields( { tempApiName: this.CLONED_EMAIL_TEMPLATE_API_NAME,
                                           oppInvNumber : this.oppInvNumber,
                                           changedEmailTempBody : this.changedEmailTempBody || this.defaultEmailTempBody } );

        await sendEmail( { tempApiName : this.CLONED_EMAIL_TEMPLATE_API_NAME, oppId : this.recordId } );
        // await deleteClonedEmailTemplate( { tempApiName : this.CLONED_EMAIL_TEMPLATE_API_NAME } );
    }

    // =============================LIFECYCLE:==============================
    errorCallback(error, stack) {
        console.error('emailForClient: errorCallback >', error, stack);
    }

    // =====================================================================


}

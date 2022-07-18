import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

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
    isDataLoading = true;
    count = 0;
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
    emailSendingStatus;

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
            this.isDataLoading = false;
            
            
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
        this.isDataLoading = true;
        await cloneEmailTemplate( { tempApiName : this.DEFAULT_EMAIL_TEMPLATE_API_NAME,
                                    clonedTempApiName : this.CLONED_EMAIL_TEMPLATE_API_NAME } );
        await updateEmailTemplateFields( { tempApiName: this.CLONED_EMAIL_TEMPLATE_API_NAME,
                                           oppInvNumber : this.oppInvNumber,
                                           changedEmailTempBody : this.changedEmailTempBody || this.defaultEmailTempBody } );

        this.emailSendingStatus = await sendEmail( { tempApiName : this.CLONED_EMAIL_TEMPLATE_API_NAME, oppId : this.recordId } );

        await (this.emailSendingStatus) ? this.fireSuccessEvent() : this.fireErrorEvent();
        await this.closeModalEvent();
        this.isDataLoading = false;
        await deleteClonedEmailTemplate( { tempApiName : this.CLONED_EMAIL_TEMPLATE_API_NAME } );
    }

    // =============================LIFECYCLE:==============================
    connectedCallback() {
        console.log('============CONNECTED================');
    }
    renderedCallback() {
        console.log('============RERENDER================', this.count);
        this.count = this.count + 1;
        // this.isDataLoading = false;
    }
    errorCallback(error, stack) {
        console.error('emailForClient: errorCallback >', error, stack);
    }

    // =====================================================================

    // ==============================EVENTS:================================
    closeModalEvent() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    fireSuccessEvent() {
        const title = 'Email sent successfully';
        const variant = 'success';
        const message = 'Contact Email : ' + this.contEmail
        const event = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(event);
    }
    fireErrorEvent() {
        const title = 'Email not sent';
        const variant = 'error';
        const message = 'Contact Email : ' + this.contEmail
        const event = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(event);
    }


    // =====================================================================


}

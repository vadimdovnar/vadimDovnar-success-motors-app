import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';

import getOppContRoleByOppId from '@salesforce/apex/DV_EmailForClientController.getOpportunityContRole';
import getEmailTemplate from '@salesforce/apex/DV_EmailForClientController.getEmailTemplate';



import OPPORTUNITY_INV_NUM from '@salesforce/schema/Opportunity.Invoice_Number__c'
import CONTACT_ID from '@salesforce/schema/Opportunity.ContactId'


export default class EmailForClient extends LightningElement {

    @api recordId;
    
    // variables:
    opportunityContactRole;
    oppInvNumber;
    contName;
    contEmail;

    emailTemplate;
    emailTemplateBody;
    

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
        return this.emailTemplateBody;
    }
    // ===================================================================

    // ========================REACTIVE TOOLING:==========================

     @wire( getRecord, { recordId : '$recordId', fields : [OPPORTUNITY_INV_NUM, CONTACT_ID] } )
     oppContRoleInfo({error, data}) {
         if(error) {
             
             console.log('============ERROR===========', error);
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
            this.oppInvNumber = await this.opportunityContactRole.Opportunity.Invoice_Number__c;
            this.contName = await this.opportunityContactRole.Contact.Name;
            this.contEmail = await this.opportunityContactRole.Contact.Email;

            this.emailTemplate = await getEmailTemplate();
            this.emailTemplateBody = await this.emailTemplate.Body;

        } catch (error) {
            console.log('============ERROR===========',error);
        }
    }
    // =====================================================================

   

    
}
import { LightningElement, wire, api, track} from 'lwc';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
// import getEmailTemplates from '@salesforce/apex/DV_EmailForClientController.getEmailTemplates';
import OPP_INV_NUM from '@salesforce/schema/Opportunity.Invoice_Number__c';
import CONTACT_ID from '@salesforce/schema/Opportunity.ContactId';





 
export default class DV_EmailForClient extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: [OPP_INV_NUM, CONTACT_ID] })
    opportunity;

    get invNumber() {
        return getFieldValue(this.opportunity.data, OPP_INV_NUM);
    }

    get contId() {
        return getFieldValue(this.opportunity.data, CONTACT_ID);
    }

    
    

}

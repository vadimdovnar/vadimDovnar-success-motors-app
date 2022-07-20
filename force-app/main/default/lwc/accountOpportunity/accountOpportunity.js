import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import getOpportunities from '@salesforce/apex/DV_accountOpportunityController.getOpportunities';

import ACCOUNT_ID from '@salesforce/schema/Account.Id'

export default class AccountOpportunity extends NavigationMixin(LightningElement) {
    @api accid;
    @api recordId;
    @track accountOpportunity = [];
    timeout = null;

    // =========================GETTERS/SETTERS:==========================
    get opportunities() {
        return this.accountOpportunity;
    }
    // ===================================================================

    // ========================REACTIVE TOOLING:==========================

    @wire( getRecord, { recordId : '$recordId', fields : ACCOUNT_ID } )
    account({error, data}) {

        if(error) {
            console.log('============ERROR==========', error);
        } else if(data) {
            if(this.recordId) {
                console.log('============AccountId==========', this.recordId);
                clearTimeout(this.timeout);
                this.timeout = setTimeout(() => {
                    console.log('timeout');
                    this.hasOpportunityQuery()
                }, 0);
            } 
        }
    }

    // ===================================================================

    // ============================ASYNC APEX:============================
    async hasOpportunityQuery() {
        try {
            this.accountOpportunity = await getOpportunities( { accountId : this.recordId } );
            await console.log(this.accountOpportunity );            
        } catch (error) {
            console.log('============ERROR===========',error);
        }
    }
    // =====================================================================

    // =============================LIFECYCLE:==============================
    async connectedCallback() {
        try {
            this.accountOpportunity = await getOpportunities( { accountId : this.accid } );
            await console.log(this.accountOpportunity );            
        } catch (error) {
            console.log('============ERROR===========',error);
        }
    }
    // =====================================================================

    // ==============================EVENTS:================================
    showOpportunityEvent(event) {
        const oppId = event.target.getAttribute('data-id');
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: oppId,
                actionName: 'view',
            },
        });
    }
    // =====================================================================
}
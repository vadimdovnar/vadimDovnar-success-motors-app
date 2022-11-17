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
    isModalOpen = false;
    oppId;
    
    // =========================GETTERS/SETTERS:==========================
    get opportunities() {
        if(this.accountOpportunity.length) {
            return this.accountOpportunity;
        } else {
            return null;
        }
    }
    get opportunityId() {
        return this.oppId;
    }
    // ===================================================================

    // ========================REACTIVE TOOLING:==========================

    @wire( getRecord, { recordId : '$recordId', fields : ACCOUNT_ID } )
    account({error, data}) {

        if(error) {
            console.log('============ERROR==========', error);
        } else if(data) {
            if(this.recordId) {
                clearTimeout(this.timeout);
                this.timeout = setTimeout(() => {
                    console.log('timeout');
                    this.hasOpportunityQuery();
                }, 0);
            } 
        }

    }

    // ===================================================================

    // ============================ASYNC APEX:============================
    async hasOpportunityQuery() {
        console.log('====================',  this.isModalOpen );
        try {
            this.accountOpportunity = await getOpportunities( { accountId : this.recordId } );            
        } catch (error) {
            console.log('============ERROR===========',error);
        }
    }
    // =====================================================================

    // =============================LIFECYCLE:==============================
    async connectedCallback() {
        try {
            this.accountOpportunity = await getOpportunities( { accountId : this.accid } );            
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

    // =============================HANDLERS:===============================
    handleOpenModalPopup(event) {
        this.oppId = event.target.getAttribute('data-id');
        this.isModalOpen = true;
    }
    handleClosePopup(event) {
        this.isModalOpen = event.detail.value;
    }
    // =====================================================================
}
import { api, LightningElement, track, wire } from 'lwc';

import getAccNameWithClosedOpp from '@salesforce/apex/DV_SummaryOfCustomerDataController.getAccNameWithClosedOpp';
export default class SummaryOfCustomerData extends LightningElement {

    //variables:
    myMap;
    @track map = [];

    // =============================LIFECYCLE:==============================
    async connectedCallback() {
        this.myMap = await getAccNameWithClosedOpp();
        await this.iteration( this.map, this.myMap );
    }
    // =====================================================================
    
    // =============================HANDLERS:===============================
    iteration(m, obj) {
        for(let key in obj) {
            let sum = 0;
            let accId;
            for(let i = 0; i < obj[key].length; i++) {
                sum += obj[key][i].Amount;
                accId = obj[key][i].AccountId;
            }
            m.push({ nameAndClosedDeal: 'Account Name: ' + key + ' / Sum: ' + '$' + sum, accountId: accId});
        }
    }

    handleSectionToggle(event){
        console.log(event.detail.openSections);
    }
    // =====================================================================
}
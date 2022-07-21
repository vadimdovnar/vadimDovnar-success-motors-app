import { api, LightningElement, track, wire } from 'lwc';

import getAccNameWithClosedOpp from '@salesforce/apex/DV_SummaryOfCustomerDataController.getAccNameWithClosedOpp';
export default class SummaryOfCustomerData extends LightningElement {

    //variables:
    myMap;
    newMyMap;
    fieldValue;
    @track map = [];
    @track newMap = [];


    // =============================LIFECYCLE:==============================
    async connectedCallback() {
        this.myMap = await getAccNameWithClosedOpp();
        await this.iterationAllAccounts( this.map, this.myMap );
    }
    async renderedCallback() {
        
        console.log('======REN=========');
    }
    // =====================================================================
    
    // =============================HANDLERS:===============================
    iterationAllAccounts(m, obj) {
        let arr = [];
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
    iterationAccountsForSearch(m, obj) {
        let re = new RegExp(`^${this.fieldValue}`);
        // const handler1 = {
        //     deleteProperty(target, prop) {
        //         if (prop in target) {
        //             delete target[prop];
        //             console.log(`property removed: ${prop}`);
        //             // expected output: "property removed: texture"
        //         }
        //     }
        // };
        // let newProxy = new Proxy(m, handler1);
        // for(key in newProxy) {
        //     delete newProxy[key];
        // }
        console.log('==========', m);
        for(let key in obj) {
            let sum = 0;
            let accId;
            for(let i = 0; i < obj[key].length; i++) {
                sum += obj[key][i].Amount;
                accId = obj[key][i].AccountId;
            }
            if(re.test(key) || re.test(sum)) {
                console.log('RESULT');
                m.push({ nameAndClosedDeal: 'Account Name: ' + key + ' / Sum: ' + '$' + sum, accountId: accId});
            }
        }
    }
    async getAccountByNameOrTotalAccount() {
        this.myMap = await getAccNameWithClosedOpp();

    }

    handleSectionToggle(event){
        console.log(event.detail.openSections);
    }
    // =====================================================================
    async handlerShowResult(event) {
        
        this.fieldValue = event.target.value;
        console.log(this.fieldValue);  
        if(this.fieldValue) {
            this.newMyMap = await getAccNameWithClosedOpp();
            console.log('============sfgdfgdfgd', this.newMyMap);
            await this.iterationAccountsForSearch( this.newMap, this.newMyMap );
            await console.log('===========render', this.newMap);
        } 
    }

    //=========================PAGINATION===================================

    // The key column for the data table
   

    // Maximum ammount of data rows to display at one time
  
   
}
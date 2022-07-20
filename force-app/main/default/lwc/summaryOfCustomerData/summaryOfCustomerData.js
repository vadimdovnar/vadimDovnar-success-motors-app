// import Id from '@salesforce/schema/Account.Id';
import { getRecord } from 'lightning/uiRecordApi';
import { api, LightningElement, track } from 'lwc';

import getAccNameWithClosedOpp from '@salesforce/apex/DV_SummaryOfCustomerDataController.getAccNameWithClosedOpp';


import ACCOUNT_ID from '@salesforce/schema/Account.Id';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
// import Account from '@salesforce/schema/Case.Account';
// import Id from '@salesforce/schema/Account.Id';

export default class SummaryOfCustomerData extends LightningElement {

    @api recordId;

    //variables:

    accountList;
    opportunityList;
    timeout = null;
    myMap;
    @track map = [];

    async connectedCallback() {
        this.myMap = await getAccNameWithClosedOpp();
        await this.iteration( this.map, this.myMap );
        await console.log('======RENDERED=====', this.map );
    }
    
    async renderedCallback() {
        // this.myMap = await getAccNameWithClosedOpp();
        // for(let key in this.myMap) {
        //     this.map.push({value:this.myMap[key], key:key});
        // }
        // console.log('======RENDERED=====', await this.map );
    }

    iteration(m, obj) {
        for(let key in obj) {
            m.push({value:obj[key], key:key});
        }
    }

    // @wire( getRecord, { recordId : '$recordId', fields : [ACCOUNT_ID, ACCOUNT_NAME] } )
    //  account({error, data}) {
    //      if(error) {
             
    //          console.log('============WIRE ERROR===========', error);
    //      } else if(data) {
    //          clearTimeout(this.timeout);
    //          this.timeout = setTimeout(() => {
    //              console.log('timeout');
    //              this.hasContactQuery()
    //          }, 0);
             
    //      }
    //  };
    // ============================ASYNC APEX:============================
    // async hasContactQuery() {
    //     try {
    //         this.accountList = await getAccounts();
    //         await console.log(his.accountList);
            
            
    //     } catch (error) {
    //         console.log('============ERROR===========',error);
    //     }
    // }

    // ===================================================================== 

}
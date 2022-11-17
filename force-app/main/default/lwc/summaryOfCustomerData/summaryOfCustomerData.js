import {LightningElement} from "lwc";

import getAccNameWithClosedOpp from "@salesforce/apex/DV_SummaryOfCustomerDataController.getAccNameWithClosedOpp";
export default class SummaryOfCustomerData extends LightningElement {
    
    //variables:
    visibleFields = [];
    _queryFields = [];
    _queriedData;
    _searchFieldValue = null;
    _pageSizeValue = "10";

    // ========================GETTERS AND SETTERS:=========================
    get queryFields() {
        return this._queryFields;
    }
    get pageSizeValue() {
        return this._pageSizeValue;
    }
    get searchFieldValue() {
        return this._searchFieldValue;
    }
    set searchFieldValue(value) {
        this.setAttribute('value', value);
    }
    // =====================================================================

    isData() {
        return this._queryFields && Array.isArray(this._queryFields) && this._queryFields.length;
    }

    // =============================LIFECYCLE:==============================
    async connectedCallback() {
        this._queriedData = await getAccNameWithClosedOpp();
        this._queryFields = await this.handlerIterationAllAccounts(this._queriedData);
    }

    async renderedCallback() {
        console.log('rerender called');
        
    }
    // =====================================================================

    // =============================HANDLERS:===============================
    handlerIterationAllAccounts(queriedData) {
        const result = [];
        for (let key in queriedData) {
            let sum = 0;
            let accId;
            for (let i = 0; i < queriedData[key].length; i++) {
                sum += queriedData[key][i].Amount;
                accId = queriedData[key][i].AccountId;
            }
            result.push({nameAndClosedDeal: key + " $" + sum, accountId: accId});
        }
        return result;
    }

    handlerIterationAccountsForSearch(queriedData) {
        let re = new RegExp(`^${this._searchFieldValue.toUpperCase()}`);
        const result = [];
        for (let key in queriedData) {
            let sum = 0;
            let accId;
            for (let i = 0; i < queriedData[key].length; i++) {
                sum += queriedData[key][i].Amount;
                accId = queriedData[key][i].AccountId;
            }
            if (re.test(key.toUpperCase()) || re.test(sum)) {
                console.log("RESULT");
                result.push({nameAndClosedDeal: key + " $" + sum, accountId: accId});
            }
        }
        return result;
    }

    handlerUpdateAccountRecords(event) {
        console.log("=====DETAIL=====", event.detail);
        this.visibleFields = [...event.detail.records];
    }

    async handlerShowResult(event) {
        this._searchFieldValue = event.target.value;
        console.log(this._searchFieldValue);
        this._queryFields = [];
        if (!this._searchFieldValue) {
            this._queryFields = await this.handlerIterationAllAccounts(this._queriedData);
        } else {
            this._queryFields = await this.handlerIterationAccountsForSearch(this._queriedData);
        }
    }

    async handelClearSearch(event) {
        this._searchFieldValue = null;
        let elem = this.template.querySelector('.search-input');
        elem.value = '';
        this._queryFields = [];
        this._queryFields = await this.handlerIterationAllAccounts(this._queriedData);
    }
    // =====================================================================
}

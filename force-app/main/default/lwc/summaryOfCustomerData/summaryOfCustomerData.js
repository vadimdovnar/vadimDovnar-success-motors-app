import {api, LightningElement, track, wire} from "lwc";

import getAccNameWithClosedOpp from "@salesforce/apex/DV_SummaryOfCustomerDataController.getAccNameWithClosedOpp";
export default class SummaryOfCustomerData extends LightningElement {
    //variables:
    visibleFields = [];
    _queryFields = [];
    _queriedData;

    _pageSizeValue = '10';

    get queryFields() {
        return this._queryFields;
    }
    get pageSizeValue() {
        return this._pageSizeValue;
    }


    // =============================LIFECYCLE:==============================
    async connectedCallback() {
        this._queriedData = await getAccNameWithClosedOpp();
        this._queryFields = await this.iterationAllAccounts(this._queriedData);
    }
    // =====================================================================

    // =============================HANDLERS:===============================
    iterationAllAccounts(queriedData) {
        const result = [];
        for (let key in queriedData) {
            let sum = 0;
            let accId;
            for (let i = 0; i < queriedData[key].length; i++) {
                sum += queriedData[key][i].Amount;
                accId = queriedData[key][i].AccountId;
            }
            result.push({nameAndClosedDeal: "Account Name: " + key + " / Sum: " + "$" + sum, accountId: accId});
        }
        return result;
    }
    iterationAccountsForSearch(queriedData) {
        const result = [];
        for (let key in queriedData) {
            let sum = 0;
            let accId;
            for (let i = 0; i < queriedData[key].length; i++) {
                sum += queriedData[key][i].Amount;
                accId = queriedData[key][i].AccountId;
            }
            if (re.test(key) || re.test(sum)) {
                console.log("RESULT");
                result.push({nameAndClosedDeal: "Account Name: " + key + " / Sum: " + "$" + sum, accountId: accId});
            }
        }
        return result;
    }

    // =====================================================================
    async handlerShowResult(event) {
        this.isSearchedData = event.target.value;
        this._queryFields = [];
        if(!this.isSearchedData) {
            this._queryFields = await this.iterationAllAccounts(this._queriedData);
        } else {
            this._queryFields = await this.iterationAccountsForSearch(this._queriedData);
        }
    }
    async handelClearSearch() {
        this._queryFields = [];
        this._queryFields = await this.iterationAllAccounts(this._queriedData);
    }
    //=========================PAGINATION===================================

    updateAccountHandler(event) {
        console.log("=====DETAIL=====", event.detail);
        this.visibleFields = [...event.detail.records];
    }
}

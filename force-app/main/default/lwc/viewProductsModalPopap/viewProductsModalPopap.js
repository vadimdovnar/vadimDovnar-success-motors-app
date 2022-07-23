import { LightningElement, api, track } from 'lwc';
import getOpportunityProducts from '@salesforce/apex/DV_viewProductsModalPopapController.getOpportunityProducts';

export default class ViewProductsModalPopap extends LightningElement {

    @track products = [];
    @api oppid;
    @api isModalOpen;

    // ========================GETTERS AND SETTERS:=========================
    get oppProducts() {
        return this.products;
    }
    // =====================================================================
    
    // =============================LIFECYCLE:==============================
    async connectedCallback() {
        await console.log( this.oppid );
        this.products = await getOpportunityProducts( { oppId : this.oppid} );
        await console.log('===============OPID', this.oppid);
    }
    // =====================================================================
    
    // =============================HANDLERS:===============================
    handlerCloseModalPupap() {
        this.isModalOpen = false;
        this.dispatchEvent(new CustomEvent('update', {
            detail: {
                value: this.isModalOpen
            }
        }))
    }
    // =====================================================================
}
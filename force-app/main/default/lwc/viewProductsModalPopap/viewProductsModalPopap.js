import { LightningElement, api, track } from 'lwc';
import getOpportunityProducts from '@salesforce/apex/DV_viewProductsModalPopapController.getOpportunityProducts';

export default class ViewProductsModalPopap extends LightningElement {

    @track products = [];
    @api oppid;

    get oppProducts() {
        return this.products;
    }

    async connectedCallback() {
        await console.log( this.oppid );
        this.products = await getOpportunityProducts( { oppId : this.oppid} );
        await console.log('===============OPID', this.oppid);
    }

    // async randerCallback() {
    //     await console.log( this.oppid );
    //     this.products = await getOpportunityProducts( { oppId : this.oppid} );
    //     await console.log('===============OPID', this.oppid);
    // }

    

}
import { LightningElement, track} from 'lwc';
import getEmailTemplates from '@salesforce/apex/DV_EmailForClientController.getEmailTemplates';
 
export default class DV_EmailForClient extends LightningElement {

    @track template = {};

    async connectedCallback() {
        this.template = await getEmailTemplates();
    }

    get tempSubj() {
        return this.template.Subject;
    }

    get tempBody() {
        return this.template.Body;
    }

    get contactName() {
        return this.template.Subject;
    }

    get contactEmail() {
        return this.template.Subject;
    }

    
}


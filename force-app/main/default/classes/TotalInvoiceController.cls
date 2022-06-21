public with sharing class TotalInvoiceController {

    public TotalInvoiceController() {
 
    }

    public String getCurrentDate() {
        return Date.today().format();
    }
    public Contact getContact() {
        return [SELECT Id, Name, Phone, Email FROM Contact WHERE Id = '0035i000005u80pAAA'];
    }
}

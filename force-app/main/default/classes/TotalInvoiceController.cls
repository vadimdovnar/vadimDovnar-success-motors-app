public with sharing class TotalInvoiceController {

    public TotalInvoiceController() {
 
    }

    public String getCurrentDate() {
        return Date.today().format();
    }
}

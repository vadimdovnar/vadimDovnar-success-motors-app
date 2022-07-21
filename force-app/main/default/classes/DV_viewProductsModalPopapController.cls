public with sharing class DV_viewProductsModalPopapController {
    
    @AuraEnabled
    public static List<OpportunityLineItem> getOpportunityProducts( String oppId ) {
        return DV_viewProductsModalPopapModel.getOpprtunityProductsByOppId(oppId);
    }
}

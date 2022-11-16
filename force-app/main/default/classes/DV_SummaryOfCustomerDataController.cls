public with sharing class DV_SummaryOfCustomerDataController {
    
    @AuraEnabled(cacheable= true)
    public static Map<String, List<Opportunity>> getAccNameWithClosedOpp() {

        Map<String, List<Opportunity>> accountOppMap = new Map<String, List<Opportunity>>();
        List<Account> accs = DV_SummaryOfCustomerDataModel.getAccounts();
        List<Opportunity> opps = DV_SummaryOfCustomerDataModel.getOpportunities();
        String accName;

        for(Integer i = 0; i < accs.size(); i++) {
            accName = accs[i].Name;
            List<Opportunity> newOppList = new List<Opportunity>();
            for(Integer z = 0; z < opps.size(); z++) {
                if(opps[z].Account.Name == accs[i].Name) {
                    newOppList.add(opps[z]);
                }
            }
            if(!newOppList.isEmpty()) {
                accountOppMap.put(accName, newOppList);
            }
        }
        return accountOppMap;
    }
}

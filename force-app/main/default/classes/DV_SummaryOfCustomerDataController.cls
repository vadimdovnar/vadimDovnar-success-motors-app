public with sharing class DV_SummaryOfCustomerDataController {
    
    @AuraEnabled
    public static Map<String, List<Opportunity>> getAccsNameWithClosedOpp() {
        System.debug('==========');
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
    @AuraEnabled
    public static Map<String, List<Opportunity>> getAccNameWithClosedOpp(String accountId) {
        Map<String, List<Opportunity>> accountOppMap = new Map<String, List<Opportunity>>();
        List<Account> acc = DV_SummaryOfCustomerDataModel.getAccount(accountId);
        List<Opportunity> opps = DV_SummaryOfCustomerDataModel.getOpportunities();
        String accName = acc[0].Name;

        List<Opportunity> newOppList = new List<Opportunity>();
            for(Integer i = 0; i < opps.size(); i++) {
                if(opps[i].Account.Name == accName) {
                    newOppList.add(opps[i]);
                }
            }
            if(!newOppList.isEmpty()) {
                accountOppMap.put(accName, newOppList);
            }
        return accountOppMap;
    }
}

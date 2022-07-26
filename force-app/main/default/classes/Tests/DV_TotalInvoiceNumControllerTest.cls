@isTest
public with sharing class DV_TotalInvoiceNumControllerTest {

	@TestSetup
	static void makeData(){
		Account acc = new Account(Name='Abce');
		insert acc;
		
		Opportunity  testOppty = new Opportunity();
		testOppty.Name='testOppty';
		testOppty.AccountId=acc.id;
		testOppty.StageName='Open';
		testOppty.CloseDate=System.today();
		insert testOppty;
	}
    
	@isTest
    static  void addPageTest() {

		Opportunity opp = [SELECT Id, Name, Invoice_Number__c FROM Opportunity WHERE Name = 'testOppty' LIMIT 1];
		Blob bodyBlob = Blob.valueOf('UnitTest');
		ContentVersion contVersion_1 = new ContentVersion(Title = opp.Invoice_Number__c, PathOnClient = 'Test.jpg', VersionData = bodyBlob, origin = 'H');
		insert contVersion_1;
		

		test.startTest();
			
			PageReference pageRef = Page.DV_TotalInvoice;
			Test.setCurrentPage(pageRef);
			
			pageRef.getParameters().put('opportunity', opp.id);
			ApexPages.StandardController sc = new ApexPages.standardController(opp);
			
			DV_TotalInvoiceNumController  controller = new DV_TotalInvoiceNumController(sc);
			controller.addPage();

		test.stopTest();
	}

	@isTest
	static void addPageTest2() {

		Opportunity opp = [SELECT Id, Name, Invoice_Number__c FROM Opportunity WHERE Name = 'testOppty' LIMIT 1];
		test.startTest();
			
			PageReference pageRef = Page.DV_TotalInvoice;
			Test.setCurrentPage(pageRef);
			
			pageRef.getParameters().put('opportunity', opp.id);
			ApexPages.StandardController sc = new ApexPages.standardController(opp);
			
			DV_TotalInvoiceNumController  controller = new DV_TotalInvoiceNumController(sc);
			controller.addPage();

		test.stopTest();
	}
}
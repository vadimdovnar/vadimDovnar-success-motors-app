@isTest
public with sharing class DV_TotalInvoiceNumControllerTest {
    
    public static testMethod void addPageTest() {

        Account acc = new Account(Name='Abce');
		insert acc;
		
		Opportunity  testOppty = new Opportunity();
		testOppty.name='testOppty';
		testOppty.AccountId=acc.id;
		testOppty.StageName='Open';
		testOppty.CloseDate=System.today();
		insert testOppty;

		test.startTest();
		
			
			PageReference pageRef = Page.DV_TotalInvoice;
			Test.setCurrentPage(pageRef);
			
			pageRef.getParameters().put('opportunity', testOppty.id);
			ApexPages.StandardController standartController = new ApexPages.standardController(testOppty);
            Opportunity currentOpportunity = (Opportunity) standartController.getRecord();

            PageReference pageRef2 = new ApexPages.StandardController(currentOpportunity).view();
			
			DV_TotalInvoiceNumController  controller = new DV_TotalInvoiceNumController(standartController);
			controller.addPage();

		test.stopTest();
		// Account acc = new Account(Name='Abce');
		// insert acc;
		
        // Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.newinstance(2022, 07, 30), StageName = 'Closed Won');
        // insert opp;
        // Opportunity opp2 = [SELECT Id FROM Opportunity LIMIT 1];
        // String oppId = (String) opp2.Id;
        // String invoiceNumber = 'INV-00004';
		
        // Blob bodyBlob = Blob.valueOf('UnitTest');
        // ContentVersion contVersion_1 = new ContentVersion(Title = 'Test', PathOnClient = 'Test.jpg', VersionData = bodyBlob, origin = 'H');
        // insert contVersion_1;
        // ContentVersion contVersion_2 = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id =: contVersion_1.Id LIMIT 1];

        // List<ContentVersion> result = DV_TotalInvoiceNumModel.getContentByInvoiceNum(contVersion_2.Title);
        // ContentVersion contVers = new ContentVersion();

        // if(result.size() > 0) {
        //     Id contDocId = DV_TotalInvoiceNumModel.getIdContentByInvoiceNum( invoiceNumber );
        //     contVers.ContentDocumentId = contDocId;
        //     DV_TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invoiceNumber, bodyBlob);
        //     insert contVers;
        // } else {
        //     DV_TotalInvoiceNumHandler.setParamsForContentVersion(contVers, invoiceNumber, bodyBlob);
        //     insert contVers;

        //     Id contDocId = DV_TotalInvoiceNumModel.getIdContentByContentVersion( contVers );
        //     ContentDocumentLink contDocLink = new ContentDocumentLink();
        //     contDocLink.ContentDocumentId = contDocId;
        //     contDocLink.ShareType = 'V';
        //     contDocLink.LinkedEntityId = oppId;
        //     insert contDocLink;
        // }
        
		// Opportunity  testOppty = new Opportunity();
		// testOppty.name='testOppty';
		// testOppty.AccountId=acc.id;
		// testOppty.StageName='Open';
		// testOppty.CloseDate=System.today();
		// insert testOppty;

		// test.startTest();
		// 	PageReference pageRef = Page.DV_TotalInvoiceNum;
		// 	Test.setCurrentPage(pageRef);
			
		// 	pageRef.getParameters().put('id',testOppty.id);
		// 	ApexPages.StandardController sc = new ApexPages.standardController(testOppty);
			
		// 	DV_TotalInvoiceNumController  controller = new DV_TotalInvoiceNumController(sc);
		// 	controller.addPage();
		// test.stopTest();
	}

}


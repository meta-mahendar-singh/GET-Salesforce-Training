@isTest
public class TestAccountController {
    
    @testSetup
    static void setUpTestdata(){
        List<Account> accountList = new List<Account>();
        
        for(Integer i = 0; i < 5 ; i++){
            Account testAccount1 = new Account(Name = 'TestJ '+i, BillingState = 'Rajasthan', BillingCity = 'Jaipur', BillingCountry = 'India');
        	accountList.add(testAccount1);
        }
        for(Integer j = 0; j < 5 ; j++){
            Account testAccount1 = new Account(Name = 'TestN '+j, BillingState = 'Maharastra', BillingCity = 'Nagpur', BillingCountry = 'India');
        	accountList.add(testAccount1);
        }
        for(Integer k = 0; k < 5 ; k++){
            Account testAccount1 = new Account(Name = 'TestS '+k, BillingState = 'New South Wales', BillingCity = 'Sydney', BillingCountry = 'Australia');
        	accountList.add(testAccount1);
       }
        insert accountList;
    }
    
    
    @isTest
    static void testSearchWithCityOnly(){
        PageReference pageRef = page.AccountFilter;
        test.setCurrentPage(pageRef);
        AccountController accController = new AccountController();
        accController.setCity('pur');
        List<Account> actualAccounts = [SELECT Name , BillingCity , BillingState ,BillingCountry FROM Account WHERE BillingCity LIKE '%pur%'];
        System.assertEquals(accController.getAccounts(), actualAccounts, 'Accounts Not fetched correctly');
    }
    
    @isTest
    static void testSearchWithCityAndState(){
        PageReference pageRef = page.AccountFilter;
        test.setCurrentPage(pageRef);
        AccountController accController = new AccountController();
        accController.setCity('Nagpur');
        accController.setState('rastr');
        List<Account> actualAccounts = [SELECT Name , BillingCity , BillingState ,BillingCountry FROM Account WHERE BillingCity LIKE '%Nagpur%' AND BillingState LIKE '%rastr%'];
        System.assertEquals(accController.getAccounts(), actualAccounts, 'Accounts Not fetched correctly');
    }
    
    @isTest
    static void testSearchWithAllField(){
        PageReference pageRef = page.AccountFilter;
        test.setCurrentPage(pageRef);
        AccountController accController = new AccountController();
        accController.setCity('ydne');
        accController.setState('New South Wales');
        accController.setCountry('Australia');
        List<Account> actualAccounts = [SELECT Name , BillingCity , BillingState ,BillingCountry FROM Account WHERE BillingCity LIKE '%ydne%' AND BillingState LIKE '%New South Wales%' AND BillingCountry LIKE '%Australia%'];
        System.assertEquals(accController.getAccounts(), actualAccounts, 'Accounts Not fetched correctly');
    }

}
@isTest
public class ShoppingEnterpriseTest {
    
    @testSetup
    static void setTestData() {
        List<Product2> products = new List<Product2>(); 
        for(Integer i = 0 ; i < 35 ; i ++ ) {
            products.add(new Product2(Name = 'test'+i ,ProductCode = 't'+i ,Description = 'New Product',price_per_unit__c = i*150 ,quantity_available__c = i*4));
        }
        insert products;
    }
    
    @isTest
    static void testGetOrders() {
        List<PlacedOrder__c> orders = [SELECT ID,Price__c,status__c FROM PlacedOrder__c ORDER BY Id DESC LIMIT 1000] ;
        ShoppingController con = new ShoppingController() ;
        System.assertEquals(con.getOrders(), orders , 'All orders not fetched');
    }
    
    @isTest
    static void testSortOrders() {
        List<PlacedOrder__c> orders = [SELECT ID,Price__c,status__c FROM PlacedOrder__c ORDER BY Id DESC LIMIT 1000] ;
        ShoppingController con = new ShoppingController() ;
        con.sortOrder();
        orders = [SELECT ID,Price__c,status__c FROM PlacedOrder__c ORDER BY price__c DESC LIMIT 1000] ;
        System.assertEquals(con.getOrders(), orders , 'All orders not fetched');
    }
    
    @isTest
    static void testGetProducts() {
        List<Product2> products = [SELECT Name,ProductCode,Description,price_per_unit__c,quantity_available__c FROM Product2  LIMIT 1000] ;
        ShoppingController con = new ShoppingController() ;
        System.assertEquals(con.getProducts(), products , 'All products not fetched');
    }
    
    @isTest
    static void testSearchProducts() {
        ShoppingController con = new ShoppingController() ;
        con.ProductName = 't2' ;
        List<Product2> products = [SELECT Name,ProductCode,Description,price_per_unit__c,quantity_available__c FROM Product2 WHERE NAME LIKE '%t2%' LIMIT 1000] ;
        con.SearchProduct();
        System.assertEquals(con.tempProducts, products, 'Search not giving correct results');
    }
    
    @isTest
    static void testSortProduct() {
        ShoppingController con = new ShoppingController() ;
        con.getProducts();
        List<wrapProduct> wraps = con.getWrapProducts();
        con.SortData();
        System.assertEquals(wraps[0].product.Name, 'test0' , 'Products could not be sorted');
        
    }
    
    @isTest
    static void testGetCartItems() {
        ShoppingController con = new ShoppingController() ;
        con.getProducts();
        List<wrapProduct> wraps = con.getWrapProducts();
        for(Integer i = 0 ; i < 5 ; i++) {
            wraps[i].selected = true;
        }
        con.addSelected();
        system.assertEquals(con.SelectedWrapProducts.size(), 4 , 'Not all selected items added to cart');
    }
    
    @isTest
    static void testDeleteFromCart() {
        ShoppingController con = new ShoppingController() ;
        con.getProducts();
        List<wrapProduct> wraps = con.getWrapProducts();
        for(Integer i = 0 ; i < 5 ; i++) {
            wraps[i].selected = true;
        }
        con.addSelected();
        con.WrappedProductId = con.SelectedWrapProducts[0].product.Id;
        con.removeFromCart();
        system.assertEquals(con.SelectedWrapProducts.size(), 3 , 'Item not removed from cart');
    }
    
    @isTest
    static void testUpdateCart() {
        ShoppingController con = new ShoppingController() ;
        con.getProducts();
        List<wrapProduct> wraps = con.getWrapProducts();
        for(Integer i = 0 ; i < 5 ; i++) {
            wraps[i].selected = true;
        }
        con.addSelected();
        con.WrappedProductId = con.SelectedWrapProducts[1].product.Id;
        con.previousQuantity = con.SelectedWrapProducts[1].quantity;
        con.SelectedWrapProducts[1].quantity = 3;
        con.updateQuantity();
        system.assertEquals(con.SelectedWrapProducts[1].product.quantity_available__c, 5, 'Could not update product quantity');
    }
    
    @isTest
    static void testPlaceOrder() {
        ShoppingController con = new ShoppingController() ;
        con.checkout();
        con.getProducts();
        List<wrapProduct> wraps = con.getWrapProducts();
        for(Integer i = 0 ; i < 5 ; i++) {
            wraps[i].selected = true;
        }
        con.addSelected();
        con.placeOrder();
        con.totalPrice = con.getTotalOrderPrice();
        List<PlacedOrder__c> orders= [SELECT Id FROM PlacedOrder__c LIMIT 100];
        List<cart__c> cart = [SELECT Id FROM cart__c LIMIT 100];
        system.assertEquals(orders.size(), 1, 'Order could not be placed');
        system.assertEquals(cart.size(), 4 , 'all or some items could not be added to order');
    } 
}
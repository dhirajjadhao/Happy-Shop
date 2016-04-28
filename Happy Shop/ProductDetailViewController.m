//
//  ProductDetailViewController.m
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+Badge.h"
#import "webService.h"
#import "SVProgressHUD.h"
#import "Constants.h"

@interface ProductDetailViewController(){
    
    webService *webServiceObject;
    NSMutableDictionary *productDetail;
}

@end

@implementation ProductDetailViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
    [self updateCart];
    
    // Set realm notification block
    self.notification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *note, RLMRealm *realm)
                         {
                             
                             UIView *productAnimationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+30, self.view.bounds.size.width, 30)];
                             [productAnimationView setBackgroundColor:appThemeColor];
                             [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:productAnimationView];
                             
                             [UIView animateWithDuration:0.7 delay:0.2 usingSpringWithDamping:0.9 initialSpringVelocity:0.4 options:UIViewAnimationOptionAllowUserInteraction animations:^
                              {
                                  
                                  productAnimationView.frame = CGRectMake(self.view.frame.size.width-20,30, 3, 3);
                              } completion:^(BOOL finished){
                                  
                                  if (finished) {
                                      [productAnimationView removeFromSuperview];
                                      
                                      self.cartButton.badgeValue = [NSString stringWithFormat:@"%ld",(unsigned long)[[Product allObjects] count]];
                                      self.cartButton.badgeBGColor = appThemeColor;
                                  }
                                  
                              }];
                             
                             
                         }];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [RLMRealm.defaultRealm removeNotification:self.notification];
    
}


-(void)viewDidLoad{
    
    webServiceObject = [[webService alloc] init];
    productDetail = [[NSMutableDictionary alloc] init];
    
    [self setupUI];
    
    [SVProgressHUD show];
    [self fetchProductDetail];
    [self updateCart];
}

-(void)updateCart{
    
    self.cartButton.badgeValue = [NSString stringWithFormat:@"%ld",(unsigned long)[[Product allObjects] count]];
    self.cartButton.badgeBGColor = appThemeColor;
}



-(void)setupUI{
    
    self.addToCartButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.addToCartButton.layer.shadowOffset = CGSizeMake(0, -5);
    self.addToCartButton.layer.shadowRadius = 5;
    self.addToCartButton.layer.shadowOpacity = 0.4;

    
    if ([productDetail objectForKey:@"name"]) {
        
        self.title = [productDetail objectForKey:@"name"];
        [self.productImageView setImageWithURL:[NSURL URLWithString:[productDetail objectForKey:@"img_url"]]];
        self.productName.text = [productDetail objectForKey:@"name"];
        self.productPrice.text = [NSString stringWithFormat:@"S$%.2f",[[productDetail objectForKey:@"price"] floatValue]/100.0];
        self.productDescription.text = [productDetail objectForKey:@"description"];
        
        if ([[productDetail objectForKey:@"under_sale"] boolValue]) {
            self.productOnSale.hidden = NO;
        }
        else{
            self.productOnSale.hidden = YES;
        }
        
    }
    else{
        self.title = @"Loading...";
        self.productName.text = @"Loading...";
        self.productPrice.text = @"Loading...";
        self.productDescription.text = @"Loading...";
        self.productOnSale.hidden = YES;
    }
    

    
}


#pragma mark Fetch Product List

-(void)fetchProductDetail{
    

    [webServiceObject sendRequest:[NSString stringWithFormat:@"%@%@.json",kSephoraProductDetailBaseURL,self.selectedProductID] parameter:nil requestType:@"GET" :^(AFHTTPRequestOperation *operation, id responseObject){
        
        productDetail = [responseObject objectForKey:@"product"];
        [SVProgressHUD dismiss];
        [self setupUI];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [SVProgressHUD dismiss];
        
    }];
}


#pragma mark Action Methods

- (IBAction)addToCartButtonPressed:(id)sender {
    
    Product *productObject = [[Product alloc] init];
    
    if ([Product allObjects].count > 0  && [Product objectForPrimaryKey:[NSString stringWithFormat:@"%@",self.selectedProductID]]) {

            [SVProgressHUD showInfoWithStatus:@"Item already in Bag."];

    }
    else{
    
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            
            productObject.productIndex = [NSString stringWithFormat:@"%@",[productDetail objectForKey:@"id"]];
            productObject.productName = [productDetail objectForKey:@"name"];
            productObject.productImageURL = [productDetail objectForKey:@"img_url"];
            productObject.productUnits = 1;
            productObject.productUnitPrice =  [[NSString stringWithFormat:@"%.2f",[[productDetail objectForKey:@"price"] floatValue]/100] floatValue];
            productObject.productPriceForTotalUnits = productObject.productUnits*productObject.productUnitPrice;
            productObject.onSale = [[productDetail objectForKey:@"under_sale"] boolValue];
            
            [Product createOrUpdateInDefaultRealmWithValue:productObject];
            
        }];
        
    }
    

    

}
@end

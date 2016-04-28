//
//  ProductDetailViewController.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealmObjectClass.h"
#import "AppDelegate.h"

@interface ProductDetailViewController : UIViewController

@property (strong,nonatomic) NSString *selectedProductID;

@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;
- (IBAction)addToCartButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextView *productDescription;

@property (nonatomic, strong) RLMNotificationToken *notification;
@property (strong, nonatomic) IBOutlet UIButton *cartButton;

@property (strong, nonatomic) IBOutlet UILabel *productOnSale;

@end

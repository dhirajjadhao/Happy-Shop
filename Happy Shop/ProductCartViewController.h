//
//  ProductCartViewController.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 17/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealmObjectClass.h"

@interface ProductCartViewController : UIViewController

@property (nonatomic, strong) RLMResults *totalProductsInCart;
@property (nonatomic, strong) RLMNotificationToken *notification;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *continueShoppingButton;


@end

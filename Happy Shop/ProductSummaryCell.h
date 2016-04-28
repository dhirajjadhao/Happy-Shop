//
//  ProductSummaryCell.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 17/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSummaryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *summerySubTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *summeryShippingLabel;
@property (strong, nonatomic) IBOutlet UILabel *summeryTotalLabel;
@property (strong, nonatomic) IBOutlet UIButton *continueShoppingButton;

@end

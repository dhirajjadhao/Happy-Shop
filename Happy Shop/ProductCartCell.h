//
//  ProductCartCell.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 17/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCartCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *productUnitPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *productTotalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *productQuantityLabel;
@property (strong, nonatomic) IBOutlet UIStepper *productQuantityStepper;
@property (strong, nonatomic) IBOutlet UILabel *productOnSale;


@end

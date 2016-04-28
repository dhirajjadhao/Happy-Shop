//
//  ProductListCell.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@property (strong, nonatomic) IBOutlet UILabel *productOnSale;

@end

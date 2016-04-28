//
//  ProductListViewController.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListViewController : UIViewController

@property (strong,nonatomic) id productList;
@property (strong,nonatomic) NSString *selectedCategory;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;

@end

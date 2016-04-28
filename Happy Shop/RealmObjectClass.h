//
//  RealmObjectClass.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <Realm/Realm.h>

#pragma mark Product Objects

@interface Product : RLMObject
@property NSString *productIndex;
@property NSString *productName;
@property NSString *productImageURL;
@property NSInteger productUnits;
@property float productUnitPrice;
@property float productPriceForTotalUnits;
@property BOOL onSale;


@end




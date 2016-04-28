//
//  AppDelegate.h
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


-(BOOL)isInternetAvailable;

@end


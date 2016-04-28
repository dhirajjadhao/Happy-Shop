//
//  ProductListViewController.m
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import "ProductListViewController.h"
#import "UIImageView+AFNetworking.h"
#import "webService.h"
#import "Constants.h"
#import "ProductListCell.h"
#import "SVProgressHUD.h"
#import "ProductDetailViewController.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import "UIButton+Badge.h"

@interface ProductListViewController(){
    
    webService *webServiceObject;
    int page;
    UIRefreshControl *bottomRefreshControl;
}

@end

@implementation ProductListViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [self updateCart];
}

-(void)viewDidLoad{
    
    self.title = self.selectedCategory;
    
    webServiceObject = [[webService alloc] init];
    page = 1;
    
    [SVProgressHUD show];
    [self fetchProductList];
    
    bottomRefreshControl = [UIRefreshControl new];
    bottomRefreshControl.triggerVerticalOffset = 20;
    [bottomRefreshControl addTarget:self action:@selector(fetchProductList) forControlEvents:UIControlEventValueChanged];
    self.collectionView.bottomRefreshControl = bottomRefreshControl;
    
    [self updateCart];
}

-(void)updateCart{
    
    self.cartButton.badgeValue = [NSString stringWithFormat:@"%ld",(unsigned long)[[Product allObjects] count]];
    self.cartButton.badgeBGColor = appThemeColor;
}



#pragma mark Fetch Product List

-(void)fetchProductList{
    
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
    [requestDict setObject:self.selectedCategory forKey:@"category"];
    [requestDict setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    
    [webServiceObject sendRequestURLEncoded:kSephoraProductListBaseURL parameter:requestDict requestType:@"GET" :^(AFHTTPRequestOperation *operation, id responseObject){
        
        if ([self.productList count] > 0) {
            
            self.productList = [self.productList arrayByAddingObjectsFromArray:[responseObject objectForKey:@"products"]];
        }
        else{
            self.productList = [responseObject objectForKey:@"products"];
        }
        
        
        [self.collectionView reloadData];
        page++;
        [SVProgressHUD dismiss];
        [bottomRefreshControl endRefreshing];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
        [SVProgressHUD dismiss];
        [bottomRefreshControl endRefreshing];
    
    }];
}


#pragma mark Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"productDetail"]) {
        
        ProductDetailViewController *destinationView = segue.destinationViewController;
        destinationView.selectedProductID = [[self.productList objectAtIndex:[[self.collectionView indexPathsForSelectedItems] objectAtIndex:0].item] objectForKey:@"id"];
    }
}


#pragma mark Collection view delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.productList count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductListCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.productName.text = [[self.productList objectAtIndex:indexPath.item] objectForKey:@"name"];
    cell.productPrice.text = [NSString stringWithFormat:@"S$%.2f",[[[self.productList objectAtIndex:indexPath.item] objectForKey:@"price"] floatValue]/100.0];
    [cell.productImageView setImageWithURL:[NSURL URLWithString:[[self.productList objectAtIndex:indexPath.item] objectForKey:@"img_url"]]];
    if ([[[self.productList objectAtIndex:indexPath.item] objectForKey:@"under_sale"] boolValue]) {
        
        cell.productOnSale.hidden = NO;
    }
    else{
        
        cell.productOnSale.hidden = YES;
    }
    cell.productName.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
  
    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([SharedAppDelegate isInternetAvailable]) {
        [self performSegueWithIdentifier:@"productDetail" sender:self];
    }
    else{
        
        [SVProgressHUD showErrorWithStatus:@"No Internet!"];
    }
    
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(self.view.bounds.size.width*0.5-8, 225);
    
}


@end

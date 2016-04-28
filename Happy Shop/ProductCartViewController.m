//
//  ProductCartViewController.m
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 17/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import "ProductCartViewController.h"
#import "ProductCartCell.h"
#import "ProductSummaryCell.h"
#import "UIImageView+AFNetworking.h"
#import "ProductDetailViewController.h"
#import "Constants.h"

@interface ProductCartViewController(){
    
    float subTotal;
}

@end

@implementation ProductCartViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
  
    subTotal = 0;
    
    // Set realm notification block
    __weak typeof(self) weakSelf = self;
    self.notification = [RLMRealm.defaultRealm addNotificationBlock:^(NSString *note, RLMRealm *realm)
                         {
                             subTotal = 0;
                             
                             if (self.totalProductsInCart.count == 0) {
                                 
                                 self.tableView.hidden = YES;
                             }
                             else{
                                 
                                 self.tableView.hidden = NO;
                             }
                             
                             
                             [weakSelf.tableView reloadData];
                         }];
    
    
    
    self.totalProductsInCart = [Product allObjects];
    
    if (self.totalProductsInCart.count == 0) {
        
        self.tableView.hidden = YES;
    }
    else{
        
        self.tableView.hidden = NO;
    }
    
    [self.tableView reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [RLMRealm.defaultRealm removeNotification:self.notification];
    
}


-(void)viewDidLoad{
    
    [super viewDidLoad];

    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqual:@"showDetailFromCart"]) {
        
        ProductDetailViewController* detailView = [segue destinationViewController];
        Product *productObject = [self.totalProductsInCart objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailView.selectedProductID = productObject.productIndex;
        
    }
    
}


#pragma mark Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.totalProductsInCart count]+1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Your Bag";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == [self.totalProductsInCart count]){
        
        ProductSummaryCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"orderSummaryCell" forIndexPath:indexPath];
        
        
        for (int i=0; i<[self.totalProductsInCart count]; i++) {
            
            Product *productObject = [self.totalProductsInCart objectAtIndex:i];
            subTotal = subTotal+productObject.productPriceForTotalUnits;
        }
        
        cell.summerySubTotalLabel.text = [NSString stringWithFormat:@"S$%.2f",subTotal];
        cell.summeryTotalLabel.text = [NSString stringWithFormat:@"S$%.2f",subTotal];
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        
        [cell.continueShoppingButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    else{
        
        
        Product *productObject = [self.totalProductsInCart objectAtIndex:indexPath.row];
        
        ProductCartCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
        
        
        [cell.productImageView setImageWithURL:[NSURL URLWithString:productObject.productImageURL]];
        
        cell.productOnSale.hidden = !productObject.onSale;
        
        cell.productNameLabel.text = productObject.productName;
        cell.productNameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        cell.productUnitPriceLabel.text = [NSString stringWithFormat:@"S$%.2f",productObject.productUnitPrice];
        cell.productTotalPriceLabel.text = [NSString stringWithFormat:@"S$%.2f",productObject.productUnitPrice*productObject.productUnits];
        cell.productQuantityLabel.text = [NSString stringWithFormat:@"Qty: %ld",(long)productObject.productUnits];
        
        cell.productQuantityStepper.value = productObject.productUnits;
        cell.productQuantityStepper.tag = indexPath.row;
        
        [cell.productQuantityStepper addTarget:self action:@selector(productQuantityStepperPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        
        return cell;
        
        
    }
    
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    if (!(indexPath.row == [self.totalProductsInCart count])) {
        
        if ([SharedAppDelegate isInternetAvailable]) {
            [self performSegueWithIdentifier:@"showDetailFromCart" sender:nil];
        }
        else{
        
            [SVProgressHUD showErrorWithStatus:@"No Internet!"];
        }
        
        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == [self.totalProductsInCart count]) {
        
        return 226;
    }
    
    return 114;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.totalProductsInCart count]) {
        
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            
            Product *productObject = [self.totalProductsInCart objectAtIndex:indexPath.row];
            [[RLMRealm defaultRealm] deleteObject:productObject];
        }];
        
    }
}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma  mark Actions

- (void)productQuantityStepperPressed:(UIStepper*)sender
{
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        
        Product *productObject = [self.totalProductsInCart objectAtIndex:sender.tag];
        
        productObject.productUnits = sender.value;
        productObject.productPriceForTotalUnits = productObject.productUnits*productObject.productUnitPrice;
        [Product createOrUpdateInDefaultRealmWithValue:productObject];
        
    }];
}


- (IBAction)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end

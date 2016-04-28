//
//  HomeViewController.m
//  Happy Shop
//
//  Created by Dhiraj Jadhao on 16/04/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductListViewController.h"
#import "UIButton+Badge.h"
#import "RealmObjectClass.h"
#import "HomeViewCell.h"
#import "Constants.h"

@interface HomeViewController()<UITableViewDelegate>{
    
    NSArray *categories;
}

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [self updateCart];
}

-(void)viewDidLoad{
    
    [[self.navigationController navigationBar] setTintColor:[UIColor whiteColor]];
    
    categories = [NSArray arrayWithObjects:@"Skincare",@"Bath & Body",@"Men",@"Nails",@"Tools",@"Makeup", nil];
    
    
    [self updateCart];
    
}

-(void)updateCart{
 
    self.cartButton.badgeValue = [NSString stringWithFormat:@"%ld",(unsigned long)[[Product allObjects] count]];
    self.cartButton.badgeBGColor = appThemeColor;
}


#pragma mark Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"productList"]) {
        
        ProductListViewController *destinationView = segue.destinationViewController;
        destinationView.selectedCategory = [categories objectAtIndex:[[self.collectionView indexPathsForSelectedItems] objectAtIndex:0].item];
    }
}



#pragma mark Collection view delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [categories count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.categoryName.text = [categories objectAtIndex:indexPath.item];
    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"productList" sender:self];

    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.view.bounds.size.width*0.5-8, 54);
    
}


@end

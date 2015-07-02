//
//  RestaurantDetailVC.h
//  EVA
//
//  Created by SourabhBanerjee on 6/18/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantListModel.h"
@interface RestaurantDetailVC : UIViewController

@property(nonatomic,strong)RestaurantListModel*objRestmodel;

@property(nonatomic,strong)NSString*strResName;
@end

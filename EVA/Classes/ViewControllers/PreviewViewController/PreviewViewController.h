//
//  PreviewViewController.h
//  EVA
//
//  Created by SourabhBanerjee on 6/19/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantListModel.h"
@interface PreviewViewController : UIViewController
@property(nonatomic,strong)RestaurantListModel*objrestPreview;
@property(nonatomic,strong)NSMutableArray*arrRestNamePreview;
@end

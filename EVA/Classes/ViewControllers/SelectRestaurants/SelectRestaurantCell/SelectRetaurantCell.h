//
//  SeectRetaurantCell.h
//  EVA
//
//  Created by SourabhBanerjee on 6/17/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectRetaurantCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *lbl_LocationName;
@property (nonatomic, weak) IBOutlet UILabel *lbl_FoodName;
@property (nonatomic, weak) IBOutlet UILabel *lbl_DistanceName;
@property (nonatomic, weak) IBOutlet UILabel *lblRestaturentName;
@property (nonatomic, weak) IBOutlet UIButton *btnResturentAdd;

@end

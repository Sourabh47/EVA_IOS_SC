//
//  RestaurantListModel.h
//  EVA
//
//  Created by SourabhBanerjee on 6/25/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantListModel : NSObject
@property (strong, nonatomic) NSString*restM_bizId;
@property (strong, nonatomic) NSString*restM_rating;
@property (strong, nonatomic) NSString*restM_mobileUrl;
@property (strong, nonatomic) NSString*restM_ratingImgUrl;
@property (strong, nonatomic) NSString*restM_name;
@property (strong, nonatomic) NSString*restM_phone;
@property (strong, nonatomic) NSString*restM_SnippetText;
@property (strong, nonatomic) NSString*restM_Address;
@property (assign) int restM_Id;

@end

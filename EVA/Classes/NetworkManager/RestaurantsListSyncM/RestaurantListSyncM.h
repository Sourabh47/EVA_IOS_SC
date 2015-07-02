//
//  RestaurantListSyncM.h
//  EVA
//
//  Created by SourabhBanerjee on 6/25/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SyncRestListDelegate<NSObject>

-(void)syncGetResListDetailWithSuccess:(id)responseObject;
-(void)syncGetFailure:(NSError*) error;
@end
@interface RestaurantListSyncM : NSObject
{
    id <SyncRestListDelegate> delegatRestListSync;

}
@property (retain) id delegatRestListSync;
-(void)postSearchRestListServiceCall:(NSString*)url withParams:(NSDictionary*)params;

@end

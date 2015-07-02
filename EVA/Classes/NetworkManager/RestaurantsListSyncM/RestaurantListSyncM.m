//
//  RestaurantListSyncM.m
//  EVA
//
//  Created by SourabhBanerjee on 6/25/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "RestaurantListSyncM.h"
#import "AFNetworking.h"

@implementation RestaurantListSyncM
@synthesize delegatRestListSync;




#pragma mark- POST_LOGIN_API
-(void)postSearchRestListServiceCall:(NSString*)url withParams:(NSDictionary*)params
{
    NSURL *url1 = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if ([responseObject isKindOfClass:[NSArray class]]) {
             NSArray *responseArray = (NSArray *)responseObject;
             NSLog(@"%@",(NSArray *)responseArray);

             /* do something with responseArray */
         } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *responseDict = (NSDictionary*)responseObject;
             /* do something with responseDict */
            NSLog(@"%@",(NSDictionary *)responseObject);
             [self.delegatRestListSync syncGetResListDetailWithSuccess:responseDict];

         }
         
       //  NSLog(@"%@",(NSMutableArray *)responseObject);

        // NSLog(@"%@",(NSDictionary *)responseObject);
         
         // NSDictionary*obhh=(NSDictionary *)responseObject;
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [self.delegatRestListSync syncGetFailure:error];
     }];
    
    [operation start];
    
}


@end

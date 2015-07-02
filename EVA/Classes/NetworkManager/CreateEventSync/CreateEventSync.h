//
//  CreateEventSync.h
//  EVA
//
//  Created by SourabhBanerjee on 7/1/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SyncEventCreateDelegate<NSObject>


//POST_USER_API
-(void)syncPostEventSuccess:(id) responseObject;
-(void)syncPostEventFailure:(NSError*) error;


@end
@interface CreateEventSync : UIViewController
{
    id <SyncEventCreateDelegate>delegateEventCreateSync;
    
}
@property (retain) id delegateEventCreateSync;
-(void)postCreateEventServiceCall:(NSString*)url withParams:(NSDictionary*) params;

@end

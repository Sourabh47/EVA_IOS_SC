//
//  NewEventSync.h
//  EVA
//
//  Created by SourabhBanerjee on 6/30/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SyncNewEventDelegate<NSObject>

-(void)syncGetNewEventSuccess:(id) responseObject;
-(void)syncGetNewEventFailure:(NSError*) error;

@end
@interface NewEventSync : UIViewController
{
    id <SyncNewEventDelegate> delegateNewEventinSync;
    
}
@property (retain) id delegateNewEventinSync;
-(void)getNewEventServiceCall:(NSString*)url withParams:(NSDictionary*) params;


@end

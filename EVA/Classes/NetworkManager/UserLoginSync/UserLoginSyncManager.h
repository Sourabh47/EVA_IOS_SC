//
//  LoginSyncManager.h
//  EVA
//
//  Created by SourabhBanerjee on 6/23/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SyncLoginDelegate<NSObject>

-(void)syncGetLoginSuccess:(id) responseObject;
-(void)syncGetLoginFailure:(NSError*) error;

//POST_USER_API
-(void)syncPostLoginSuccess:(id) responseObject;
-(void)syncPostLoginFailure:(NSError*) error;


@end
@interface UserLoginSyncManager : UIViewController
{
 id <SyncLoginDelegate> delegateLoginSync;

}
@property (retain) id delegateLoginSync;
-(void)getloginServiceCall:(NSString*)url withParams:(NSDictionary*) params;
-(void)postloginServiceCall:(NSString*)url withParams:(NSDictionary*) params;

@end

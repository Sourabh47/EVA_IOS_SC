//
//  LoginSyncManager.m
//  EVA
//
//  Created by SourabhBanerjee on 6/23/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "UserLoginSyncManager.h"
#import "AFNetworking.h"

@interface UserLoginSyncManager ()

@end

@implementation UserLoginSyncManager
@synthesize delegateLoginSync;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--
#pragma mark- GET_LOGIN_API

-(void)getloginServiceCall:(NSString*)url withParams:(NSDictionary*) params
{
    NSURL *url1 = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"%@",(NSDictionary *)responseObject);
        [self.delegateLoginSync syncGetLoginSuccess:responseObject];
        // NSDictionary*obhh=(NSDictionary *)responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.delegateLoginSync syncGetLoginFailure:error];
    }];
    
    [operation start];

}

#pragma mark- POST_LOGIN_API
-(void)postloginServiceCall:(NSString*)url withParams:(NSDictionary*) params
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@",(NSDictionary *)responseObject);
         [self.delegateLoginSync syncPostLoginSuccess:responseObject];
    }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [self.delegateLoginSync syncPostLoginFailure:error];

     }];


}

@end

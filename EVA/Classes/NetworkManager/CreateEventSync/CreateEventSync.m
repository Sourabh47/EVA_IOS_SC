//
//  CreateEventSync.m
//  EVA
//
//  Created by SourabhBanerjee on 7/1/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "CreateEventSync.h"
#import "AFNetworking.h"

@interface CreateEventSync ()

@end

@implementation CreateEventSync
@synthesize delegateEventCreateSync;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- POST_LOGIN_API

-(void)postCreateEventServiceCall:(NSString*)url withParams:(NSDictionary*) params;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager POST:url parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"%@",(NSDictionary *)responseObject);
             [self.delegateEventCreateSync systemLayoutFittingSizeDidChangeForChildContentContainer:responseObject];
         }
              failure:
         ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             [self.delegateEventCreateSync syncPostEventFailure:error];
             
         }];
        


}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

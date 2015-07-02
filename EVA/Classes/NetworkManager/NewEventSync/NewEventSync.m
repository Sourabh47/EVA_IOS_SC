
//
//  NewEventSync.m
//  EVA
//
//  Created by SourabhBanerjee on 6/30/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "NewEventSync.h"
#import "AFNetworking.h"

@interface NewEventSync ()

@end

@implementation NewEventSync
@synthesize delegateNewEventinSync;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getNewEventServiceCall:(NSString*)url withParams:(NSDictionary*)params
{
    NSURL *url1 = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@",(NSDictionary *)responseObject);
         [self.delegateNewEventinSync syncGetNewEventSuccess:responseObject];
         // NSDictionary*obhh=(NSDictionary *)responseObject;
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [self.delegateNewEventinSync syncGetNewEventFailure:error];
     }];
    
    [operation start];


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

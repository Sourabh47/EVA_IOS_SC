//
//  LoginViewController.m
//  EVA
//
//  Created by SourabhBanerjee on 6/11/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "LoginViewController.h"
#import "NewEventViewController.h"
#import "VarificationCodeVC.h"
#import "CountryListViewController.h"
#import "AFNetworking.h"
#import "UserLoginSyncManager.h"
#import "UserLoginModel.h"
@interface LoginViewController ()
{
    IBOutlet UITextField *txtPhoneNumber;
    IBOutlet UILabel *lblCountryName;
    IBOutlet UITextField *txtCountryCode;
    UserLoginModel*objloginModel;
    NSMutableArray *arr_UserModel; ;

}
@end

@implementation LoginViewController


#pragma mark--
#pragma mark- View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"timezone"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    

   // NSArray *timezoneNames = [NSTimeZone knownTimeZoneNames] ;
    objloginModel=[[UserLoginModel alloc]init];
    arr_UserModel=[[NSMutableArray alloc]init];
//NSDictionary*dic=[NSTimeZone abbreviationDictionary];

    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,450, 20)];
    view.backgroundColor=[UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0];
    [self.navigationController.view addSubview:view];
    [txtPhoneNumber becomeFirstResponder];
 // [self getUserDetailHelpOfEvaToken];
    //[self postUserDetail];
    // Do any additional setup after loading the view.
}
- (void)didSelectCountry:(NSDictionary *)country
{
    
   // NSMutableArray*arr=[[NSMutableArray alloc]init];
    for (id key in country)
    {
        if ([key isEqualToString:@"name"]) {
            id value = [country objectForKey:key];
         lblCountryName.text=value;

        }
        else if ([key isEqualToString:@"dial_code"])
        {
            id value = [country objectForKey:key];
             txtCountryCode.text=value;

        }
    }



    NSLog(@"%@", country);
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--
#pragma mark- IBACTION
-(IBAction)openEventViewControllerAction:(id)sender
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.window setRootViewController:app.tabBarController];

    
}
-(BOOL)validatePhonenumber:(NSString *) phoneNumber{
    NSString *isDigitRegEx = @"^[0-9\\-]{1,}$";
    NSPredicate *digitValidator = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isDigitRegEx];
    if([digitValidator evaluateWithObject:phoneNumber]){
        int count=0;
        for(int i=0;i<[phoneNumber length];i++){
            if([phoneNumber characterAtIndex:i]=='-')
                count++;
        }
        if([phoneNumber length]-count>12)
            return NO;
        
        else if ([phoneNumber length]-count<10)
            return NO;
        else
            return YES;
    }
    return NO;
}
-(IBAction)varificationAction:(id)sender
{
    
    BOOL matches= [self validatePhonenumber:txtPhoneNumber.text];

    if (matches)
    {
        UIStoryboard *newStoryBoard;
        newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        ///////////////////////////CREATE TAB 1/////////////////////
        //VarificationCodeVC *viewController_Varification=[newStoryBoard instantiateViewControllerWithIdentifier:@"VarificationCodeVC"];
      //  [self.navigationController pushViewController:viewController_Varification animated:YES];
        [LoadingViewController instance].lblDownloading.text=@"Loading";
        [[LoadingViewController instance]startRotationonview:self.view];
       [self postUserDetail:txtPhoneNumber.text DeviceToken:@"" EvaToken:@""];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter valid phone number." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
-(IBAction)showCountryListAction:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    CountryListViewController *viewController_Count=[newStoryBoard instantiateViewControllerWithIdentifier:@"CountryListViewController"];
    [viewController_Count setDelegate:self];
    [self.navigationController pushViewController:viewController_Count animated:YES];
    
}

#pragma mark-
#pragma mark-API CALL

#pragma mark-
#pragma mark-GET_USERAPI CALL

/////////////////////////FETCH USER DETAILS////////////////////
-(void)getUserDetailHelpOfEvaToken
{
    if ([SettingPlist ReadIsEvaToken]) {
        
    
    UserLoginSyncManager *syncLogin = [[UserLoginSyncManager alloc] init];
    syncLogin.delegateLoginSync=self;
    
    NSString *strParam=[NSString stringWithFormat:GET_USER_API,ServiceURL_EVA,[SettingPlist ReadIsEvaToken]];
   [syncLogin getloginServiceCall:strParam withParams:nil];
    //[syncLogin getloginServiceCall:@"http://130.211.184.232:8080/user?evaToken=439087482d21d57584b6d1a26cc9e3844ed75c36f33c0f7952042ab0412b2405" withParams:nil];
    
    }
}

/////////////////////DELEGATE METHODS FOR FETCH USER DETAIL///////////////
-(void)syncGetLoginSuccess:(id)responseObject
{
    NSDictionary*dicval=(NSDictionary *)responseObject;
    [objloginModel setUserLogin_strPhoneNumber:[dicval objectForKey:@"phone"]];
    [objloginModel setUserLogin_strDeviceToken:[dicval objectForKey:@"fbToken"]];
    [objloginModel setUserLogin_strEvaToken:[dicval objectForKey:@"evaToken"]];


    [arr_UserModel addObject:objloginModel];
    NSLog(@"%@",[SettingPlist ReadIsEvaToken]);

    
}
-(void)syncGetLoginFailure:(NSError*)error;

{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];

}
#pragma mark-
#pragma mark-POST_USERAPI CALL

/////////////////////////POST USER DETAILS////////////////////

-(void)postUserDetail:(NSString*)strPhoneNumber DeviceToken:(NSString*)strDeviceToken EvaToken:(NSString*)strEvaToken
{
    
    UserLoginSyncManager *syncLogin = [[UserLoginSyncManager alloc] init];
    syncLogin.delegateLoginSync=self;
    
    NSDictionary *params = @ {@"phone":strPhoneNumber,@"fbToken":strDeviceToken,@"evaToken":strEvaToken };
    NSString *strAPI=[NSString stringWithFormat:POST_USER_API,ServiceURL_EVA];
    [syncLogin postloginServiceCall:strAPI withParams:params];
    
}
/////////////////////DELEGATE METHODS FOR POST USER DETAIL///////////////
-(void)syncPostLoginSuccess:(id)responseObject
{
    
    [[LoadingViewController instance]stopRotation];

    ///////SAVE EVA TOKET IN PLIST////
    [SettingPlist writeEvaToken:[(NSDictionary *)responseObject objectForKey:@"evaToken"]];
    
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    ///////////////////////////CREATE TAB 1/////////////////////
    VarificationCodeVC *viewController_Varification=[newStoryBoard instantiateViewControllerWithIdentifier:@"VarificationCodeVC"];
    [self.navigationController pushViewController:viewController_Varification animated:YES];
    
    
}
-(void)syncPostLoginFailure:(NSError*)error;

{
    [[LoadingViewController instance]stopRotation];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    
}






//-(void)getUserDetailHelpOfEvaToken
//{
//
//    NSURL *url = [NSURL URLWithString:@"http://130.211.184.232:8080/user?evaToken=439087482d21d57584b6d1a26cc9e3844ed75c36f33c0f7952042ab0412b2405"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    // 2
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        // 3
//        
//        NSLog(@"%@",(NSDictionary *)responseObject);
//       // NSDictionary*obhh=(NSDictionary *)responseObject;
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        // 4
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    
//    // 5
//    [operation start];
//}
/*
 ///////////////////////POST LOGIN API
 
 //      NSString*strFb=@"";
 //     NSString*streva=@"";
 //    NSString*strphone=@"1234312453";
 //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
 //
 //
 //    NSDictionary *params = @ {@"phone":strphone,@"fbToken":strFb,@"evaToken":streva };
 //
 //
 //    [manager POST:@"http://130.211.184.232:8080/user?" parameters:params
 //          success:^(AFHTTPRequestOperation *operation, id responseObject)
 //    {
 //        NSLog(@"JSON: %@", responseObject);
 //
 //        NSDictionary*dic=(NSDictionary*)responseObject;
 //
 //    }
 //          failure:
 //     ^(AFHTTPRequestOperation *operation, NSError *error) {
 //         NSLog(@"Error: %@", error);
 //     }];
 //    

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

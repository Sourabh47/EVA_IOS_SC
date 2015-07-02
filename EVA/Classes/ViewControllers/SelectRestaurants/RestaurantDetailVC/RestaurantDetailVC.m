//
//  RestaurantDetailVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/18/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "RestaurantDetailVC.h"
#import "PreviewViewController.h"

@interface RestaurantDetailVC ()
{
    IBOutlet UILabel*lblReturentName;
    IBOutlet UILabel*lblLocation;
    IBOutlet UILabel*lbldistance;
    IBOutlet UILabel*lbltime;
    IBOutlet UILabel*lblPhoneFirst;
    IBOutlet UILabel*lblPhoneSecond;
    IBOutlet UITextView*txtvwDetai;
    IBOutlet UILabel*lblFoodType;
  

}
@end

@implementation RestaurantDetailVC
@synthesize strResName,objRestmodel;
- (void)viewDidLoad {
    [super viewDidLoad];
    lblReturentName.text=objRestmodel.restM_name;
    lblPhoneFirst.text=objRestmodel.restM_phone;
    lblLocation.text=objRestmodel.restM_Address;
    txtvwDetai.text=objRestmodel.restM_SnippetText;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







#pragma mark -
#pragma mark-IBACTION
-(IBAction)previewAction:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PreviewViewController *viewController_preview=[newStoryBoard instantiateViewControllerWithIdentifier:@"PreviewViewController"];
    viewController_preview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController_preview animated:YES];
}
-(IBAction)BackbtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

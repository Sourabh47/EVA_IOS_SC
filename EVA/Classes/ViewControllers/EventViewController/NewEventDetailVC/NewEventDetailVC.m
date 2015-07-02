
//
//  NewEventDetailVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/26/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "NewEventDetailVC.h"
#import "NewEventDetailCell.h"
#import "AcceptInvitationVC.h"
@interface NewEventDetailVC ()
{
    IBOutlet UILabel*lbl_EventName;
    
    IBOutlet UILabel*lbl_DateTime;
    
    IBOutlet UILabel*lbl_Location;
    
    IBOutlet UILabel*lbl_RestFirst;
    IBOutlet UILabel*lbl_RestSecond;
    IBOutlet UILabel*lbl_RestThird;
    IBOutlet UIScrollView*scrvw;
    
    IBOutlet UITableView*tblInvite;
    
}
@property (nonatomic, strong) NSMutableArray *arry_contactData;

@end

@implementation NewEventDetailVC

@synthesize arry_contactData;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,450, 20)];
    view.backgroundColor=[UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0];
    [self.navigationController.view addSubview:view];
    arry_contactData = [[NSMutableArray alloc]initWithObjects:@"Sourabh",@"Sachin",@"Anil",@"Rohan", nil];
    [tblInvite reloadData];
    
    [scrvw setContentSize:CGSizeMake(scrvw.frame.size.width+100, scrvw.frame.size.height+800)];
    
    // Do any additional setup after loading the view.
}
- (void)viewDidLayoutSubviews {
    if (iPhone6) {
        [scrvw setContentSize:CGSizeMake(scrvw.frame.size.width, scrvw.frame.size.height+400)];

    }
    else if (IS_IPHONE_5)
    {
        [scrvw setContentSize:CGSizeMake(scrvw.frame.size.width, scrvw.frame.size.height+400)];

    }
    else if (IS_IPHONE_6_PLUS)
    {
        [scrvw setContentSize:CGSizeMake(scrvw.frame.size.width, scrvw.frame.size.height+400)];

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // [scrvw setContentOffset:
    //  CGPointMake(0, -scrvw.contentInset.top) animated:YES];
    
    
    
}
#pragma mark-
#pragma mark-IBACTION
-(IBAction)AcceptEventAction:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    AcceptInvitationVC *viewController_AcceptEvent=[newStoryBoard instantiateViewControllerWithIdentifier:@"AcceptInvitationVC"];
    viewController_AcceptEvent.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController_AcceptEvent animated:YES];
}


-(IBAction)BackbtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];;
}
-(IBAction)sendInvitebtnAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                    message:@"your invitation has been sent successfully."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //[self.navigationController popToRootViewControllerAnimated:NO];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

#pragma mark -
#pragma mark -TABLEVIEW DELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arry_contactData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  42;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"NewEventDetailCell";
    NewEventDetailCell *cell = (NewEventDetailCell*)[tblInvite dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
    tableView.separatorColor = [UIColor whiteColor];
    
    
    cell.lblUserName.text= [arry_contactData objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];

    return cell;
    
}
#pragma mark-
#pragma mark-IBACTION
-(IBAction)popvwConroller:(id)sender
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

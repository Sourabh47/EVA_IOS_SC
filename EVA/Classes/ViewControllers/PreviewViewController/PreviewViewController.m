//
//  PreviewViewController.m
//  EVA
//
//  Created by SourabhBanerjee on 6/19/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "PreviewViewController.h"
#import "PrevieContactCell.h"
#import "TKContact.h"
#import "NewEventViewController.h"
@interface PreviewViewController ()
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

@implementation PreviewViewController
@synthesize arry_contactData,objrestPreview,arrRestNamePreview;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,450, 20)];
    view.backgroundColor=[UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0];
    [self.navigationController.view addSubview:view];
    arry_contactData=[[NSMutableArray alloc]init];
    [self showDataInPreviewScreen];
    //NSLog(@"%@",objrestPreview.restM_name);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark -SHOW DATA IN PREVIEW SCREEN
-(void)showDataInPreviewScreen
{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    lbl_EventName.text=[app.appDel_DicForEvent objectForKey:@"EventName"];
    lbl_Location.text=[app.appDel_DicForEvent objectForKey:@"Location"];
    lbl_DateTime.text=[app.appDel_DicForEvent objectForKey:@"StartDate"];
    for (int i=0; i<[arrRestNamePreview count]; i++) {
        if (i==0) {
            objrestPreview=[arrRestNamePreview objectAtIndex:i];
            lbl_RestFirst.text=[NSString stringWithFormat:@"1.%@",objrestPreview.restM_name];
        }
        else if (i==1)
        {
            objrestPreview=[arrRestNamePreview objectAtIndex:i];
            lbl_RestSecond.text=[NSString stringWithFormat:@"2.%@",objrestPreview.restM_name];
        }
        else
        {
            objrestPreview=[arrRestNamePreview objectAtIndex:i];
            lbl_RestThird.text=[NSString stringWithFormat:@"3.%@",objrestPreview.restM_name];

        }
    }
    TKContact*cont=[app.appDel_DicForEvent objectForKey:@"ContactName"];
    
    NSMutableArray*arr=[[NSMutableArray alloc]initWithArray:cont];
    for (int i=0; i<[arr count]; i++)
    {
        TKContact*cont=[arr objectAtIndex:i];
        [arry_contactData addObject:cont.name];
    }
    
  //  arry_contactData = [[NSMutableArray alloc]initWithObjects:@"Sourabh",@"Sachin",@"Anil",@"Rohan", nil];
    [tblInvite reloadData];

    
}
#pragma mark-IBACTION
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

    static NSString *CellIdentifier = @"PrevieContactCell";
    PrevieContactCell *cell = (PrevieContactCell*)[tblInvite dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
    tableView.separatorColor = [UIColor whiteColor];
   
    
        cell.lblUserName.text= [arry_contactData objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
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

//
//  NewEventViewController.m
//  EVA
//
//  Created by SourabhBanerjee on 6/11/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "NewEventViewController.h"
#import "CreateEventVC.h"
#import "NewEventCell.h"
#import "NewEventDetailVC.h"
#import "AcceptInvitationVC.h"
#import "NewEventSync.h"
@interface NewEventViewController ()
{
    IBOutlet UIView*vwAlert;
    NSMutableArray *arry_contactData;
    IBOutlet UITableView*tbl_NewEvent;

}
@end

@implementation NewEventViewController

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,450, 20)];
        view.backgroundColor=[UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0];
        [self.navigationController.view addSubview:view];
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,450, 20)];
    view.backgroundColor=[UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0];
    [self.navigationController.view addSubview:view];

    arry_contactData = [[NSMutableArray alloc]initWithObjects:@"Macmbo Cafe",@"Radisan",@"Sayaji",@"Fortune",@"CrownPlace",@"Alaw", nil];
    [tbl_NewEvent reloadData];
    ////////////////////////////APICALL FOR EVENT LIST///
    
    [self callNewEventList];
   // [[LoadingViewController instance]startRotationonview:self.view];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(IBAction)createEventAction:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    CreateEventVC *viewController_NewEvent=[newStoryBoard instantiateViewControllerWithIdentifier:@"CreateEventVC"];
    viewController_NewEvent.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController_NewEvent animated:YES];
}
#pragma mark -
#pragma mark -TABLEVIEW DELEGATE
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;//[self.countries count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, tableView.frame.size.width, 30.0)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(0, 0, sectionHeaderView.frame.size.width, 25.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [headerLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    [sectionHeaderView addSubview:headerLabel];
    
    switch (section) {
        case 0:
            headerLabel.text = @"Today";
            NSLog(@"bla");
            return sectionHeaderView;
            break;
        case 1:
            headerLabel.text = @"Jun 10";
            return sectionHeaderView;
            break;
        case 2:
            headerLabel.text = @"June 25";
            return sectionHeaderView;
            break;
        case 3:
            headerLabel.text = @"July 12";
            return sectionHeaderView;
            break;
        case 4:
            headerLabel.text = @"Mrch 13";
            return sectionHeaderView;
            break;
        case 5:
            headerLabel.text = @"Sep 13";
            return sectionHeaderView;
            break;
        case 6:
            headerLabel.text = @"Dec 12";
            return sectionHeaderView;
            break;
        default:
            break;
    }
    
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//[arry_contactData count];
    
    
    //return [arry_contactData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  278.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellIdentifier = @"SelectRetaurantCell";
    //    SelectRetaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    static NSString *CellIdentifier = @"NewEventCell";
    NewEventCell *cell = (NewEventCell*)[tbl_NewEvent dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
    tableView.separatorColor = [UIColor whiteColor];
    
    //cell.btnResturentAdd.tag=indexPath.row;
    
    cell.lblRestaturentName.text=[arry_contactData objectAtIndex: indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor =  [UIColor colorWithRed:247 green:247 blue:247 alpha:1 ];
    [cell setSelectedBackgroundView:bgColorView];
    [cell.btnAccept addTarget:self
                             action:@selector(AcceptEventAction:)
                   forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString*strName;
    
    strName= [arry_contactData objectAtIndex: indexPath.row];
    
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    NewEventDetailVC *viewController_EVdetail=[newStoryBoard instantiateViewControllerWithIdentifier:@"NewEventDetailVC"];
    [self.navigationController pushViewController:viewController_EVdetail animated:YES];

    
    
    //    UIStoryboard *newStoryBoard;
    //    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //
    //    ///////////////////////////CREATE TAB 1/////////////////////
    //    RestaurantDetailVC *viewController_RestaurantDetailVC=[newStoryBoard instantiateViewControllerWithIdentifier:@"RestaurantDetailVC"];
    //    viewController_RestaurantDetailVC.hidesBottomBarWhenPushed = YES;
    //    viewController_RestaurantDetailVC.strResName=strName;
    //    [self.navigationController pushViewController:viewController_RestaurantDetailVC animated:YES];
    
}
#pragma mark-
#pragma mark- API IMPLEMENT

-(void)callNewEventList
{
    NewEventSync *syncEvent = [[NewEventSync alloc] init];
    syncEvent.delegateNewEventinSync=self;
    
    NSString *strParam=[NSString stringWithFormat:GET_NEWEVENT_LIST_API,ServiceURL_EVA,[SettingPlist ReadIsEvaToken]];
   // NSString *strParam=[NSString stringWithFormat:GET_NEWEVENT_LIST_API,ServiceURL_EVA,@"aaaa"];

    [syncEvent getNewEventServiceCall:strParam withParams:nil];



}

/////////////////////DELEGATE METHODS FOR FETCH USER DETAIL///////////////
-(void)syncGetNewEventSuccess:(id)responseObject
{
    //NSDictionary*dicval=(NSDictionary *)responseObject;
    //[objloginModel setUserLogin_strPhoneNumber:[dicval objectForKey:@"phone"]];
    ///[objloginModel setUserLogin_strDeviceToken:[dicval objectForKey:@"fbToken"]];
   // [objloginModel setUserLogin_strEvaToken:[dicval objectForKey:@"evaToken"]];
    
    
   // [arr_UserModel addObject:objloginModel];
    
    
}
-(void)syncGetNewEventFailure:(NSError*)error;

{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    
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

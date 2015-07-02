//
//  AcceptInvitationVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/29/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "AcceptInvitationVC.h"
#import "AcceptInvitationCell.h"
@interface AcceptInvitationVC ()
{
    IBOutlet UITableView*tbl_Restaurent;
    NSMutableArray*arrSelectRestuID;
    NSMutableDictionary*dicAddIndex;
    NSMutableArray*arrSelectedImage;
    
    NSMutableArray *data;               // the data source
    NSMutableArray *arr_RestModel; ;

}
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSMutableArray *tablecopyData;
@property (nonatomic, strong) NSMutableArray *searchResult;

@end

@implementation AcceptInvitationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    data = [[NSMutableArray alloc] init];
    
    
    self.tablecopyData=[[NSMutableArray alloc]init];
    arrSelectRestuID=[[NSMutableArray alloc]init];
    arr_RestModel=[[NSMutableArray alloc]init];
    //////////SET IMAGE IN NAVIGATION STATUS BAR//////
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,450, 20)];
    view.backgroundColor=[UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0];
    [self.navigationController.view addSubview:view];
    ////////////////////////////////
    [tbl_Restaurent setBackgroundView:nil];
    [tbl_Restaurent setBackgroundView:[[UIView alloc] init]];
    
    self.tableData = @[@"Macmbo Cafe",@"Radisan",@"Sayaji",@"Fortune",@"CrownPlace",@"Alaw"];
    
    [self.tablecopyData addObjectsFromArray:self.tableData];
    arrSelectedImage=[[NSMutableArray alloc] init];;
    for (int i = 0; i<[self.tableData count]; i++) //yourTableSize = how many rows u got
    {
        [arrSelectedImage addObject:@"NO"];
    }


    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark -TABLEVIEW DELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResult count];
    }
    else
    {
        return [self.tablecopyData count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  278.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AcceptInvitationCell";
    AcceptInvitationCell *cell = (AcceptInvitationCell*)[tbl_Restaurent dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[AcceptInvitationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
    tbl_Restaurent.separatorColor = [UIColor whiteColor];
    
    cell.btnResturentAdd.tag=indexPath.row;
    
    cell.lblRestaturentName.text= self.tablecopyData[indexPath.row];
    
    [cell.btnResturentAdd addTarget:self
                             action:@selector(addResturantcreateBubble:)
                   forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor = [UIColor clearColor];
    [cell.btnResturentAdd setBackgroundImage:[UIImage imageNamed:@"cir_tbl"] forState:UIControlStateNormal];
    [cell.btnResturentAdd setBackgroundImage:[UIImage imageNamed:@"right_tbl"] forState:UIControlStateSelected];
    
    
    if ([arrSelectedImage count]>0)
    {
        
        if([[arrSelectedImage objectAtIndex:indexPath.row]isEqualToString:@"NO"])
        {
            [cell.btnResturentAdd setSelected:NO];
        }
        else
        {
            [cell.btnResturentAdd setSelected:YES];
        }
        
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor =  [UIColor colorWithRed:247 green:247 blue:247 alpha:1 ];
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //    NSString*strName;
    //    if (tableView == self.searchDisplayController.searchResultsTableView)
    //    {
    //        strName= [self.searchResult objectAtIndex:indexPath.row];
    //    }
    //    else
    //    {
    //        strName= self.tablecopyData[indexPath.row];
    //
    //    }
//    RestaurantListModel*objM=[[RestaurantListModel alloc]init];
//    
//    UIStoryboard *newStoryBoard;
//    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    ///////////////////////////CREATE TAB 1/////////////////////
//    RestaurantDetailVC *viewController_RestaurantDetailVC=[newStoryBoard instantiateViewControllerWithIdentifier:@"RestaurantDetailVC"];
//    viewController_RestaurantDetailVC.hidesBottomBarWhenPushed = YES;
//    objM=[self.tableData objectAtIndex:indexPath.row];
//    [viewController_RestaurantDetailVC setObjRestmodel:objM];
//    //viewController_RestaurantDetailVC.strResName=strName;
//    [self.navigationController pushViewController:viewController_RestaurantDetailVC animated:YES];
    
}
//////////TABLEVIEW BUTTON ACTION//////
-(IBAction)addResturantcreateBubble:(id)sender
{
    
    //tbl_Restaurent.constant=5;
    NSInteger tag=[sender tag];
    // UIButton *button = (UIButton *)sender;
    NSString*strname;
    
    
    
    if([sender isSelected]) //if the button is selected, deselect it, and then replace the "YES" in the array with "NO"
    {
        [arrSelectedImage replaceObjectAtIndex:tag withObject:@"NO"];
        [sender setSelected:NO];
        
       // [data removeObjectAtIndex:tag];
        strname= [self.searchResult objectAtIndex:tag];

    }
    else if (![sender isSelected]) //if the button is unselected, select it, and then replace the "NO" in the array with "YES"
    {
        [arrSelectedImage replaceObjectAtIndex:tag withObject:@"YES"];
        [sender setSelected:YES];
       // [data removeObjectAtIndex:tag];

        
        
        
        
    }
    
    
    
    // [self tokenFieldShouldReturn:self.txtAddResturent];
    
    
}

#pragma mark - IBACTION
-(IBAction)popView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)AcceptInvite:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Alert!"
                                  message:@"Congrats you accept the invitation."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
//    UIAlertAction* cancel = [UIAlertAction
//                             actionWithTitle:@"Cancel"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
    
    [alert addAction:ok];
    //[alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
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

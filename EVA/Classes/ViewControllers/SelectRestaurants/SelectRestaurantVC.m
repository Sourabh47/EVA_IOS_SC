//
//  SelectRestaurantVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/17/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "SelectRestaurantVC.h"
#import "SelectRetaurantCell.h"
#import "RestaurantDetailVC.h"
#import "PreviewViewController.h"
#import "HEBubbleView.h"
#import "HEBubbleViewItem.h"
#import "RestaurantListSyncM.h"
#import "RestaurantListModel.h"
@interface SelectRestaurantVC ()<UISearchDisplayDelegate,HEBubbleViewDataSource, HEBubbleViewDelegate>

{
    
    IBOutlet UITableView*tbl_Restaurent;
    IBOutlet UIView*vw_SearchAdd;
    IBOutlet UIView*vw_tbl;
   // IBOutlet UISearchBar*searchBar_res;
    IBOutlet NSLayoutConstraint*tblYpotision;
    NSMutableArray*arrSelectRestuID;
    NSMutableDictionary*dicAddIndex;
    NSMutableDictionary*dicAddIndexForBubble;
    NSMutableArray*arrAddPreviewRest;
    //////////////BUBBLE//////
    
    NSMutableArray*arrSelectedImage;

    NSMutableArray *data;               // the data source
    @private
    HEBubbleView *bubbleView;           // The view containing the bubbles
    NSInteger bubbleCount;               // item number for bubble label
    
    //////////////////END BUBBLE//.////////
    
    NSMutableArray *arr_RestModel; ;

}
// Implement all menucontroller item actions in delegate of bubbleview
-(void)deleteSelectedBubble:(id)sender;
///////////////////////

@property (nonatomic, strong) NSMutableArray *toRecipients;

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSMutableArray *tablecopyData;

@property (nonatomic, strong) NSMutableArray *searchResult;
@end

@implementation SelectRestaurantVC


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    bubbleView.frame = self.view.bounds;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    [bubbleView removeFromSuperview];
    bubbleView = nil;
    // Release any retained subviews of the main view.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc] init];
    dicAddIndex=[[NSMutableDictionary alloc]init];
    dicAddIndexForBubble=[[NSMutableDictionary alloc]init];
    arrAddPreviewRest=[[NSMutableArray alloc]init];

    bubbleCount = 0;
    
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
    
    ///////////////////////////CREATE BUBBLE/////
    [self CreateBubble];
   
    //////////////////////////////CALL RESTAURANT API///////////
    NSString*strLOcation=@"43387,missionblvd,fremont,CA&radius=1000";

    [self postRestDetail:@"" Location:strLOcation];

}

- (void)didReceiveMemoryWarning
{
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
    static NSString *CellIdentifier = @"SelectRetaurantCell";
    SelectRetaurantCell *cell = (SelectRetaurantCell*)[tbl_Restaurent dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SelectRetaurantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
      cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
   tableView.separatorColor = [UIColor whiteColor];
    RestaurantListModel*objrest;

    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        objrest= [self.searchResult objectAtIndex:indexPath.row];
        cell.lblRestaturentName.text=objrest.restM_name;
        cell.lbl_LocationName.text=objrest.restM_Address;

       // cell.btnResturentAdd.tag=indexPath.row;

    }
    else
    {

        objrest= self.tablecopyData[indexPath.row];
        cell.lblRestaturentName.text=objrest.restM_name;
        //cell.btnResturentAdd.tag=indexPath.row;
        cell.lbl_LocationName.text=objrest.restM_Address;
    }
    cell.btnResturentAdd.tag=objrest.restM_Id;
    //indexPath.row;

    [cell.btnResturentAdd addTarget:self
               action:@selector(addResturantcreate:)
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
    RestaurantListModel*objM=[[RestaurantListModel alloc]init];

    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    RestaurantDetailVC *viewController_RestaurantDetailVC=[newStoryBoard instantiateViewControllerWithIdentifier:@"RestaurantDetailVC"];
    viewController_RestaurantDetailVC.hidesBottomBarWhenPushed = YES;
    objM=[self.tableData objectAtIndex:indexPath.row];
    [viewController_RestaurantDetailVC setObjRestmodel:objM];
    //viewController_RestaurantDetailVC.strResName=strName;
    [self.navigationController pushViewController:viewController_RestaurantDetailVC animated:YES];

}
//////////TABLEVIEW BUTTON ACTION//////
-(IBAction)addResturantcreate:(id)sender
    {
        
          tblYpotision.constant=55;//5;
        NSInteger tag=[sender tag];
   // UIButton *button = (UIButton *)sender;
         NSString*strname;
        
        RestaurantListModel *item;
        NSMutableArray*arr=[[NSMutableArray alloc]init];
        for (item in self.tableData)
        {
            [arr addObject:item.restM_name ];
            
            
        }

        
        if([sender isSelected]) //if the button is selected, deselect it, and then replace the "YES" in the array with "NO"
        {
            [arrSelectedImage replaceObjectAtIndex:tag withObject:@"NO"];
            [sender setSelected:NO];
            ///////////////////DELETE BUBBLE WITH IMAGE////
            NSString*strvall=[dicAddIndex objectForKey:[NSString stringWithFormat:@"%ld",(long)tag]];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF = %@", strvall];
            NSArray *results = [data filteredArrayUsingPredicate:predicate];
            NSUInteger index = [data indexOfObject:[results objectAtIndex:0]];
            
            
           // NSInteger newtag=[strvall integerValue];
            
            [data removeObjectAtIndex:index];
            [dicAddIndex removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)tag]];
            if ([data count]==0) {
                tblYpotision.constant=-55;
            }
            [bubbleView removeItemAtIndex:index animated:YES];
            ///////////////////END DELETE BUBBLE WITH IMAGE////

        }
        else if (![sender isSelected]) //if the button is unselected, select it, and then replace the "NO" in the array with "YES"
        {
            [arrSelectedImage replaceObjectAtIndex:tag withObject:@"YES"];
            [sender setSelected:YES];
       
            if ([self.searchDisplayController isActive])
            {
               // strname= [self.searchResult objectAtIndex:tag];
                item=[self.tableData objectAtIndex:tag];
                strname=item.restM_name;

            }
            else
            {
                strname= [arr objectAtIndex:tag];
                item=[self.tableData objectAtIndex:tag];

            }
            [arrAddPreviewRest addObject:item];
            if ([data count]<=2) {
                
                NSInteger index = [data count];
                
                if (index < 0) {
                    index = 0;
                }
                
                if (index > [data count])
                {
                    index = [data count];
                }
                
                [data addObject:strname];

                if (index==0) {
                    [dicAddIndex setValue:strname forKey:[NSString stringWithFormat:@"%ld",(long)tag]];
                    [dicAddIndexForBubble setValue:[NSString stringWithFormat:@"%ld",(long)tag] forKey:[NSString stringWithFormat:@"%ld",(long)index]];
                    [bubbleView setTag:0];


                }
                else if (index==1)
                {
                    [dicAddIndex setValue:strname forKey:[NSString stringWithFormat:@"%ld",(long)tag]];
                    [dicAddIndexForBubble setValue:[NSString stringWithFormat:@"%ld",(long)tag] forKey:[NSString stringWithFormat:@"%ld",(long)index]];
                    [bubbleView setTag:1];

                
                }
                else
                {
                    [dicAddIndex setValue:strname forKey:[NSString stringWithFormat:@"%ld",(long)tag]];

                    [dicAddIndexForBubble setValue:[NSString stringWithFormat:@"%ld",(long)tag] forKey:[NSString stringWithFormat:@"%ld",(long)index]];
                    [bubbleView setTag:2];


                }
                
                [bubbleView addItemAnimated:index animat:YES];

                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                                message:@"Maxumum limit is only 3."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }

        }
        
        
    
    // [self tokenFieldShouldReturn:self.txtAddResturent];
    
    
}


#pragma mark -
#pragma mark -SEARCH CONTROLLER


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResult removeAllObjects];
    [self.tablecopyData removeAllObjects];
    [tbl_Restaurent reloadData];
    
    
    RestaurantListModel *item;

    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    [searchArray addObjectsFromArray:self.tableData];
    
    for (item  in searchArray) {
        NSString *objectName = item.restM_name;
        NSRange resultsRange = [objectName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (resultsRange.length > 0)
            [self.searchResult addObject:item];
    }
    
    searchArray = nil;
    
    
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];

    
    //  self.searchResult = [NSMutableArray arrayWithArray: [self.tableData filteredArrayUsingPredicate:resultPredicate]];
    
    
    //    NSMutableArray*arr=[[NSMutableArray alloc]init];
    //    for (item in self.tableData)
    //    {
    //        [arr addObject:item.restM_name ];
    //
    //        
    //    }

    
    
    
    //self.searchResult = [NSMutableArray arrayWithArray: [arr filteredArrayUsingPredicate:resultPredicate]];
    

    }

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    
    
    [controller.searchResultsTableView setBackgroundColor:[UIColor clearColor]];
    
    controller.searchResultsTableView.bounces=true;
    tbl_Restaurent.separatorColor = [UIColor clearColor];
    if ([searchString isEqualToString:@""]) {
        
        [self.searchResult removeAllObjects];
        [self.tablecopyData addObjectsFromArray:self.tableData];
        [tbl_Restaurent reloadData];
    }
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tbl_Restaurent.rowHeight = 278.0f; // or some other height
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [self.searchResult removeAllObjects];
    self.searchResult=nil;
    [tbl_Restaurent reloadData];
    [self.tablecopyData addObjectsFromArray:self.tableData];
    [tbl_Restaurent reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark-IBACTION
-(IBAction)previewAction:(id)sender
{
    if ([data count]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Select atleast one restaraunt first." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
 
    }
    else
    {
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PreviewViewController *viewController_preview=[newStoryBoard instantiateViewControllerWithIdentifier:@"PreviewViewController"];
        viewController_preview.arrRestNamePreview=arrAddPreviewRest;
    [self.navigationController pushViewController:viewController_preview animated:YES];
    }
}
-(IBAction)restaurentDeatialAction:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    RestaurantDetailVC *viewController_RestaurantDetailVC=[newStoryBoard instantiateViewControllerWithIdentifier:@"RestaurantDetailVC"];
    viewController_RestaurantDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController_RestaurantDetailVC animated:YES];
}
-(IBAction)BackbtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}



//////////////////////////////// deleteSelectedBubble /////////////////////////
#pragma mark - delete bubble item

-(void)deleteSelectedBubble:(id)sender
{
   // NSInteger bubbleindex=[bubbleView tag];
    
   NSInteger tag= bubbleView.tag;

    NSLog(@"%ld",(long)bubbleView.activeBubble.index);
    
    NSInteger bubbleindex=bubbleView.activeBubble.index;
        ///////////////////DELETE BUBBLE WITH IMAGE////
        NSString*strvallNew=[dicAddIndexForBubble objectForKey:[NSString stringWithFormat:@"%ld",(long)bubbleindex]];
    
        NSInteger newtagVAlue=[strvallNew integerValue];
    
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newtagVAlue inSection:0];
        SelectRetaurantCell*cell = (SelectRetaurantCell*)[tbl_Restaurent cellForRowAtIndexPath:indexPath];
    
    
        [arrSelectedImage replaceObjectAtIndex:newtagVAlue withObject:@"NO"];
        [cell.btnResturentAdd setSelected:NO];
        ///////////////////DELETE BUBBLE WITH IMAGE////
        //NSString*strvall=[dicAddIndexForBubble objectForKey:[NSString stringWithFormat:@"%ld",(long)newtagVAlue]];
        // NSInteger newtag=[strvall integerValue];
    
        [data removeObjectAtIndex:bubbleView.activeBubble.index ];
        [dicAddIndexForBubble removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)bubbleView.activeBubble.index ]];
        if ([data count]==0) {
            tblYpotision.constant=-55;
        }
        [bubbleView removeItemAtIndex:bubbleView.activeBubble.index  animated:YES];

   

    
    

    //
//    
//    NSLog(@"test1 controller %@",[sender class]);
//    NSLog(@"%ld",(long)bubbleView.activeBubble.index);
//    
//    [data removeObjectAtIndex:bubbleView.activeBubble.index];
//    if ([data count]==0) {
//        tblYpotision.constant=-55;
//
//    }
//    [bubbleView removeItemAtIndex:bubbleView.activeBubble.index animated:YES];
    ////////////////////////////////
//    
//    NSLog(@"%ld",(long)bubbleView.activeBubble.index);
//    
//    NSInteger bubbleindex=bubbleView.activeBubble.index;
//    ///////////////////DELETE BUBBLE WITH IMAGE////
//    NSString*strvallNew=[dicAddIndexForBubble objectForKey:[NSString stringWithFormat:@"%ld",(long)bubbleindex]];
//    
//    NSInteger newtagVAlue=[strvallNew integerValue];
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newtagVAlue inSection:0];
//    SelectRetaurantCell*cell = (SelectRetaurantCell*)[tbl_Restaurent cellForRowAtIndexPath:indexPath];
//    
//    
//    [arrSelectedImage replaceObjectAtIndex:newtagVAlue withObject:@"NO"];
//    [cell.btnResturentAdd setSelected:NO];
//    ///////////////////DELETE BUBBLE WITH IMAGE////
//    //NSString*strvall=[dicAddIndexForBubble objectForKey:[NSString stringWithFormat:@"%ld",(long)newtagVAlue]];
//    // NSInteger newtag=[strvall integerValue];
//    
//    [data removeObjectAtIndex:bubbleView.activeBubble.index ];
//    [dicAddIndexForBubble removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)bubbleView.activeBubble.index ]];
//    if ([data count]==0) {
//        tblYpotision.constant=-55;
//    }
//    [bubbleView removeItemAtIndex:bubbleView.activeBubble.index  animated:YES];
}

///////////////////////////////////////////////////////////////
#pragma mark - bubble view data source
///////////////////////////////////////////////////////////////

// DataSource

-(NSInteger)numberOfItemsInBubbleView:(HEBubbleView *)bubbleView
{
    
    NSLog(@"Asking for bubble count");
    
    return [data count];
}

-(HEBubbleViewItem *)bubbleView:(HEBubbleView *)bubbleViewIN bubbleItemForIndex:(NSInteger)index
{
    // TODO: implement reuse queue
    
    
    NSString *itemIdentifier = @"bubble";
    
    HEBubbleViewItem *item = [bubbleView dequeueItemUsingReuseIdentifier:itemIdentifier];
    
    if (item == nil) {
        item = [[HEBubbleViewItem alloc] initWithReuseIdentifier:itemIdentifier];
        NSLog(@"Created a new bubble");
    }else {
        NSLog(@"Used a bubble from the queue");
    }
    
    item.textLabel.text = data[index];
    
    return item;
}

///////////////////////////////////////////////////////////////
#pragma mark - bubble view delegate
///////////////////////////////////////////////////////////////

// DataSource
-(void)CreateBubble
{
    // init bubble view
    bubbleView = [[HEBubbleView alloc] initWithFrame:self.view.frame];
    
    bubbleView.backgroundColor = [UIColor whiteColor];
    [bubbleView setFrame:CGRectMake(vw_SearchAdd.frame.origin.x, vw_SearchAdd.frame.origin.y, vw_SearchAdd.frame.size.width, vw_SearchAdd.frame.size.height)];
    // configure bubble view
    bubbleView.alwaysBounceVertical = YES;
    bubbleView.bubbleDataSource = self;
    bubbleView.bubbleDelegate = self;
    bubbleView.selectionStyle = HEBubbleViewSelectionStyleDefault;
    
    [vw_SearchAdd addSubview:bubbleView];
    

    
    /////////////////
    tblYpotision.constant=-60;
    
}


// called when a bubble gets selected
-(void)bubbleView:(HEBubbleView *)bubbleView didSelectBubbleItemAtIndex:(NSInteger)index
{
    NSLog(@"selected bubble at index");
}

// returns wheter to show a menu callout or not for a given index
-(BOOL)bubbleView:(HEBubbleView *)bubbleView shouldShowMenuForBubbleItemAtIndex:(NSInteger)index
{
    NSLog(@"telling delegate to show menu");
    return YES;
}

/* ////////////////////////////////////////////////////////////////////////////////////////////////////
 
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 !!!!! Always override canBecomeFirstResponder and return YES, otherwise the menu is not shown !!!!!!
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
 * //////////////////////////////////////////////////////////////////////////////////////////////////// */

-(BOOL)canBecomeFirstResponder
{
    NSLog(@"Asking %@ if it can become first responder",[self class]);
    return YES;
}


/*
 Create the menu items you want to show in the callout and return them. Provide selectors
 that are implemented in your bubbleview delegate. override canBecomeFirstResponder and return
 YES, otherwise menu will not be shown
 */

-(NSArray *)bubbleView:(HEBubbleView *)bubbleView menuItemsForBubbleItemAtIndex:(NSInteger)index
{
    
    NSLog(@"Asking %@ for menu items",[self class]);
    
    NSArray *items;
    
    UIMenuItem *item0 = [[UIMenuItem alloc] initWithTitle:@"Delete item" action:@selector(deleteSelectedBubble:)];
   // UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"Insert Left" action:@selector(inserLeft:)];
   // UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"Insert Right" action:@selector(insertRight:)];
    
    items = @[item0];
    
    
    
    
    return items;
}

-(void)bubbleView:(HEBubbleView *)bubbleView didHideMenuForBubbleItemAtIndex:(NSInteger)index
{
    NSLog(@"Did hide menu for bubble at index %li",(long)index);
}

#pragma mark-
#pragma mark-API IMPLEMENT
/////////////////////////POST USER DETAILS////////////////////

-(void)postRestDetail:(NSString*)strTerm Location:(NSString*)strLocation
{
    [[LoadingViewController instance]startRotationonview:vw_SearchAdd];
    RestaurantListSyncM *syncRes = [[RestaurantListSyncM alloc] init];
    syncRes.delegatRestListSync=self;
    NSString *strAPI=[NSString stringWithFormat:POST_SEARCH_RESTAURANT_DETAIL,ServiceURL_EVA,[SettingPlist ReadIsEvaToken],strTerm,strLocation];
    [syncRes postSearchRestListServiceCall:strAPI withParams:nil];
}
-(void)syncGetResListDetailWithSuccess:(id)responseObject
{
    [[LoadingViewController instance]stopRotation];
    NSDictionary*dicval=(NSDictionary *)responseObject;
    NSMutableArray*arry_Rest=[dicval valueForKey:@"list"];
    int L= -1;
    for (id dict in arry_Rest)
    {
        L++;
        RestaurantListModel*objRestModel=[[RestaurantListModel alloc]init];
    [objRestModel setRestM_Id:L];
        
    [objRestModel setRestM_bizId:[dict objectForKey:@"bizId"]];
    [objRestModel setRestM_mobileUrl:[dict objectForKey:@"mobileUrl"]];
    [objRestModel setRestM_name:[dict objectForKey:@"name"]];
    [objRestModel setRestM_phone:[dict objectForKey:@"phone"]];
    [objRestModel setRestM_rating:[dict objectForKey:@"rating"]];
    [objRestModel setRestM_ratingImgUrl:[dict objectForKey:@"ratingImgUrl"]];
    [objRestModel setRestM_SnippetText:[dict objectForKey:@"snippetText"]];
        NSArray*arr=[dict objectForKey:@"displayAddress"];
            NSString*str1=[arr objectAtIndex:0];
            NSString*str2=[arr objectAtIndex:1];


    [objRestModel setRestM_Address:[NSString stringWithFormat:@"%@%@",str1,str2 ]];
        
        [arr_RestModel addObject:objRestModel];
    }
    
    
    
    ////////////////////////////CREATE TABLE VIEW AND ADD DATA///////////
    self.tableData = [arr_RestModel copy];
  //  self.tableData = @[@"Macmbo Cafe",@"Radisan",@"Sayaji",@"Fortune",@"CrownPlace",@"Alaw"];
    
    [self.tablecopyData addObjectsFromArray:self.tableData];
    self.searchResult = [NSMutableArray arrayWithCapacity:[self.tableData count]];
    
    
    /////////////////////ARRAY FOR YABLEVIEW SELECTED IMAGE//////////
    arrSelectedImage=[[NSMutableArray alloc] init];;
    for (int i = 0; i<[self.tableData count]; i++) //yourTableSize = how many rows u got
    {
        [arrSelectedImage addObject:@"NO"];
    }
    
  //RestaurantListModel*objRestModel=[arr_RestModel objectAtIndex:6];
   // NSLog(@"%@", objRestModel.restM_ratingImgUrl);
    [tbl_Restaurent reloadData];
}
-(void)syncGetFailure:(NSError*) error
{
    [[LoadingViewController instance]stopRotation];
    
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

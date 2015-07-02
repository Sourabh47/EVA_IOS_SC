//
//  UpcomingVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/11/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "UpcomingEventVC.h"
#import "UpcomingCell.h"
#import "UpcomingDetailVC.h"
@interface UpcomingEventVC ()

{

NSMutableArray *arry_contactData;
    IBOutlet UITableView*tbl_UpcomingEvent;
}

@end

@implementation UpcomingEventVC

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}




- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
       // [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"Upcoming", @"comment")];

        //self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
       // self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Upcoming" image:nil selectedImage:nil];

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
    [tbl_UpcomingEvent reloadData];
    
    ///////////////SAVE OBJECT CORE DATA
//    NSManagedObjectContext *context = [self managedObjectContext];
//
//    NSManagedObject *newobje = [NSEntityDescription insertNewObjectForEntityForName:@"UpcomingEvent" inManagedObjectContext:context];
//    
//    [newobje setValue:@"ba" forKey:@"up_eventName"];
//         NSError *error = nil;
//// Save the object to persistent store
//               if (![context save:&error]) {
//    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    
                   
 //////////////FETCH BOBJECT
//                   NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//                   NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UpcomingEvent"];
//                   NSArray*arr = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

//}

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark -
#pragma mark -IBACTION

-(IBAction)AcceptEventAction:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    UpcomingDetailVC *viewController_upcoming=[newStoryBoard instantiateViewControllerWithIdentifier:@"UpcomingDetailVC"];
    viewController_upcoming.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController_upcoming animated:YES];
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
    
    
    static NSString *CellIdentifier = @"UpcomingCell";
    UpcomingCell *cell = (UpcomingCell*)[tbl_UpcomingEvent dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
    tableView.separatorColor = [UIColor whiteColor];
    
        cell.btnResturentAdd.tag=indexPath.row;
        
        cell.lblRestaturentName.text=[arry_contactData objectAtIndex: indexPath.row];
        
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor =  [UIColor colorWithRed:247 green:247 blue:247 alpha:1 ];
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString*strName;
   
    strName= [arry_contactData objectAtIndex: indexPath.row];
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    UpcomingDetailVC *viewController_upcoming=[newStoryBoard instantiateViewControllerWithIdentifier:@"UpcomingDetailVC"];
    viewController_upcoming.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController_upcoming animated:YES];

    
    
//    UIStoryboard *newStoryBoard;
//    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    ///////////////////////////CREATE TAB 1/////////////////////
//    RestaurantDetailVC *viewController_RestaurantDetailVC=[newStoryBoard instantiateViewControllerWithIdentifier:@"RestaurantDetailVC"];
//    viewController_RestaurantDetailVC.hidesBottomBarWhenPushed = YES;
//    viewController_RestaurantDetailVC.strResName=strName;
//    [self.navigationController pushViewController:viewController_RestaurantDetailVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

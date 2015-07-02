//
//  TimeZoneVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/25/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "TimeZoneVC.h"

@interface TimeZoneVC ()<UISearchDisplayDelegate>
{
    IBOutlet UITableView*tblTimeZone;
}
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSMutableArray *searchResult;

@end

@implementation TimeZoneVC
@synthesize delegateTimeZone;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // self.tableData = @[@"One",@"Two",@"Three",@"Twenty-one"];
    self.searchResult = [NSMutableArray arrayWithCapacity:[self.tableData count]];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"timezone"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
   self.tableData = [content componentsSeparatedByString:@"\n"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResult count];
    }
    else
    {
        return [self.tableData count];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*strname;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        strname = [self.searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        strname = self.tableData[indexPath.row];
    }
    [self.delegateTimeZone GetTimeZoneName:strname];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [self.searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = self.tableData[indexPath.row];
    }
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResult removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResult = [NSMutableArray arrayWithArray: [self.tableData filteredArrayUsingPredicate:resultPredicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}
#pragma mark-IBACTION

-(IBAction)BackbtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];;
}

@end
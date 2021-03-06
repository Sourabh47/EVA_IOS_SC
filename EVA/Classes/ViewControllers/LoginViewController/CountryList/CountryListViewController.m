//
//  CountryListViewController.m
//  Country List
//
//  Created by Pradyumna Doddala on 18/12/13.
//  Copyright (c) 2013 Pradyumna Doddala. All rights reserved.
//

#import "CountryListViewController.h"
#import "CountryListDataSource.h"
#import "CountryCell.h"

@interface CountryListViewController ()
{

    IBOutlet UIButton*btnDone;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataRows;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar_Country;

@end

@implementation CountryListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil delegate:(id)delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        // Custom initialization
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CountryListDataSource *dataSource = [[CountryListDataSource alloc] init];
    _dataRows = [dataSource countries];
    [_tableView reloadData];
   // [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
    [btnDone setHidden:YES];

}

-(IBAction)BackbtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataRows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    CountryCell *cell = (CountryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[CountryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryName];
    cell.detailTextLabel.text = [[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryCallingCode];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [btnDone setHidden:NO];

}

#pragma mark -
#pragma mark Actions

- (IBAction)done:(id)sender
{
    
    //NSDictionary*dic= [_dataRows objectAtIndex:[_tableView indexPathForSelectedRow].row];
 //   ;
    
    if ([_delegate respondsToSelector:@selector(didSelectCountry:)]) {
        [self.delegate didSelectCountry:[_dataRows objectAtIndex:[_tableView indexPathForSelectedRow].row]];
        [self.navigationController popViewControllerAnimated:YES];
    
    } else {
        NSLog(@"CountryListView Delegate : didSelectCountry not implemented");
    }
}

@end

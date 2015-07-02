//
//  CreateEventVC.h
//  EVA
//
//  Created by SourabhBanerjee on 6/11/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKPeoplePickerController.h"
#import <CoreLocation/CoreLocation.h>

#import "ILGeoNamesLookup.h"
#import "ILGeoNamesSearchController.h"

@interface CreateEventVC : UIViewController<UINavigationControllerDelegate, TKPeoplePickerControllerDelegate,CLLocationManagerDelegate, ILGeoNamesLookupDelegate, ILGeoNamesSearchControllerDelegate>
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (IBAction)showPeoplePicker:(id)sender;
@property (nonatomic, retain) NSMutableArray *arr_WorlLocationResult;


@end

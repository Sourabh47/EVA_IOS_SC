//
//  CreateEventVC.m
//  EVA
//
//  Created by SourabhBanerjee on 6/11/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "CreateEventVC.h"
#import "UIImage+TKUtilities.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "LMAddress.h"
#import "LMGeocoder.h"
#import "SelectRestaurantVC.h"
#import "TimeZoneVC.h"
#import "CreateEventSync.h"
//#import "ILGeoNamesSearchController.h"
#define thumbnailSize 75
static NSString *kGeoNamesAccountName = @"ilgeonamessample";

@interface CreateEventVC ()<CLLocationManagerDelegate>
{
    IBOutlet UITextField*txtEventName;
    IBOutlet UITextField*txtLocation;
    IBOutlet UILabel*lblTimeZone;
    ILGeoNamesLookup	*geocoder;
    ILGeoNamesLookup	*wikipediaGeocoder;

}

//@property (nonatomic, retain) ILGeoNamesLookup *geocoder;
//@property (nonatomic, retain) ILGeoNamesLookup *wikipediaGeocoder;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UILabel *selectedDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *startdatePicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *enddatePicker;

@property (strong, nonatomic) IBOutlet UIButton *btnStratDate;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDate;

@property (strong, nonatomic) IBOutlet UIView *vwStart;
@property (strong, nonatomic) IBOutlet UIView *vwEnd;
@property (strong, nonatomic) IBOutlet UIView *vwTimeZone;


@end

@implementation CreateEventVC
@synthesize selectedDate,startdatePicker,btnEndDate,btnStratDate;
@synthesize vwEnd,vwStart,enddatePicker,arr_WorlLocationResult;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Contacts"];
   // [self getCurrentLocation ];
    [self setdefaultTimeZone];
    arr_WorlLocationResult=[[NSMutableArray alloc]init];
    txtEventName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
     NSDate * now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy  hh:mm a"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:now];
    [btnStratDate setTitle:formatedDate forState:UIControlStateNormal];
    
    NSDateFormatter *dateFormatterEnd = [[NSDateFormatter alloc] init];
    
    [dateFormatterEnd setDateFormat:@"dd-MM-yyyy HH:mm"];
    [dateFormatterEnd setDateFormat:@"dd-MMM-yyyy  hh:mm a"];
    
    NSString *formatedDateEnd = [dateFormatter stringFromDate:now];
    [btnEndDate setTitle:formatedDateEnd forState:UIControlStateNormal];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    
}

- (void)dealloc
{
    // Clean up; make sure to add this
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--TEXTFILED DELEGATE
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
        [textField resignFirstResponder];
    return YES;
}

//#pragma mark--CURRENT LOCATION
//-(void)getCurrentLocation
//{
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
//        
//    
//    
//    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [self.locationManager requestAlwaysAuthorization];
//    }
//    [self.locationManager startUpdatingLocation];
//    
//}
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    
//   // NSString*strAddress;
//    CLLocation *location = [locations lastObject];
//    CLLocationCoordinate2D coordinate = location.coordinate;
//    
//   // NSString*strstrLatitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
//   // NSString*strstrLongitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
//    
//    [[LMGeocoder sharedInstance] reverseGeocodeCoordinate:coordinate
//                                                  service:kLMGeocoderGoogleService
//                                        completionHandler:^(LMAddress *address, NSError *error) {
//                                            
//                                            if (address && !error) {
//                                                self.addressLabel.text = address.formattedAddress;
//                                                NSLog(@"%@",address.formattedAddress);
//                                                NSLog(@"%@",address.country);
//                                                NSLog(@"%@",address.locality);
//                                                NSLog(@"%@",address.administrativeArea);
//                                               txtLocation.text=[NSString stringWithFormat:@"%@,%@",address.administrativeArea,address.country];
//
//                                            }
//                                            else {
//                                                self.addressLabel.text = [error localizedDescription];
//                                                NSLog(@"%@",address.formattedAddress);
//                                                NSLog(@"%@",address.country);
//                                                NSLog(@"%@",address.locality);
//                                                NSLog(@"%@",address.administrativeArea);
//                                                txtLocation.text=[NSString stringWithFormat:@"%@%@",address.administrativeArea,address.country];
//
//                                            }
//                                            
//                                            [self.addressLabel sizeToFit];
//                                        }];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"Updating location failed");
//}
//


#pragma mark--TIMEZONE
-(void)setdefaultTimeZone
{
 // NSTimeZone*str=[NSTimeZone localTimeZone];
    NSDate *currentDate = [[NSDate alloc] init];
   // NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    // or specifc Timezone: with name
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    
    NSString *timeZoneName = [[NSTimeZone localTimeZone] name];
    lblTimeZone.text=timeZoneName;

}
#pragma mark-DATE PICKER
/////////DATE PICKER FOR START AND END DATE//////
static int tapCount = 0;
-(IBAction)createStartDatePicker:(id)sender
{
    [txtEventName resignFirstResponder];
        tapCount++;
    tapCountEndPic=0;
    [enddatePicker removeFromSuperview];

    if (tapCount==1) {
    
    
    startdatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, vwStart.frame.origin.y+100, 325, 300)];
    startdatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    startdatePicker.hidden = NO;
    startdatePicker.date = [NSDate date];
        [self.view addSubview:startdatePicker];

    [startdatePicker addTarget:self
                   action:@selector(startPickerbtnAction:)
         forControlEvents:UIControlEventValueChanged];

////////
    [vwEnd setFrame:CGRectMake(0, vwStart.frame.origin.y+230, vwEnd.frame.size.width, vwEnd.frame.size.height)];
    }
    else if (tapCount==2)
    {
        tapCount=0;
        startdatePicker.hidden=YES;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
        [dateFormatter setDateFormat:@"dd-MMM-yyyy  hh:mm a"];

        NSString *formatedDate = [dateFormatter stringFromDate:self.startdatePicker.date];
        [btnStratDate setTitle:formatedDate forState:UIControlStateNormal];
        [vwEnd setFrame:CGRectMake(0, vwStart.frame.origin.y+44, vwEnd.frame.size.width, vwEnd.frame.size.height)];

    }
}


-(void)startPickerbtnAction:(id)sender
{
   // NSInteger tag=[sender tag];
    //[startdatePicker removeFromSuperview];
    [txtEventName resignFirstResponder];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MMM-yyyy HH:mm:ss"];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy  hh:mm a"];

    NSString *formatedDate = [dateFormatter stringFromDate:self.startdatePicker.date];
    [btnStratDate setTitle:formatedDate forState:UIControlStateNormal];
  }
///////////////////////END DATE PICKER//////

static int tapCountEndPic = 0;

-(IBAction)createEndDatePicker:(id)sender
{
    tapCount=0;
    [txtEventName resignFirstResponder];

    tapCountEndPic++;
    [startdatePicker removeFromSuperview];
    [vwEnd setFrame:CGRectMake(0, vwStart.frame.origin.y+44, vwEnd.frame.size.width, vwEnd.frame.size.height)];
    if (tapCountEndPic==1) {
        
    enddatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, vwEnd.frame.origin.y+100, 325, 300)];
    enddatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    enddatePicker.hidden = NO;
    enddatePicker.date = [NSDate date];
    
    [enddatePicker addTarget:self
                        action:@selector(endDatePickerbtnAction:)
              forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:enddatePicker];
    }
    else if (tapCountEndPic==2)
    {
        tapCountEndPic=0;
        enddatePicker.hidden=YES;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
        [dateFormatter setDateFormat:@"dd-MMM-yyyy  hh:mm a"];

        NSString *formatedDate = [dateFormatter stringFromDate:self.enddatePicker.date];
        [btnEndDate setTitle:formatedDate forState:UIControlStateNormal];

    
    }
    
    

   // self.selectedDate.text =formatedDate;
    
}
-(void)endDatePickerbtnAction:(id)sender
{
    [txtEventName resignFirstResponder];

    // NSInteger tag=[sender tag];
    //enddatePicker.hidden=NO;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy  hh:mm a"];

    NSString *formatedDate = [dateFormatter stringFromDate:self.enddatePicker.date];
    [btnEndDate setTitle:formatedDate forState:UIControlStateNormal];
    //self.selectedDate.text =formatedDate;
    
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // Code logic
    [[self view] endEditing:YES];
    
}

#pragma mark-IBACTION
-(IBAction)timeZonAction:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ///////////////////////////CREATE TAB 1/////////////////////
    TimeZoneVC *viewController_TimeZoneVC=[newStoryBoard instantiateViewControllerWithIdentifier:@"TimeZoneVC"];
    [viewController_TimeZoneVC setDelegateTimeZone:self];
    [self.navigationController pushViewController:viewController_TimeZoneVC animated:YES];

}
-(IBAction)locationSearh:(id)sender
{
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //ILGeoNamesSearchController *searchController = [[ILGeoNamesSearchController alloc] init];

   // searchController.delegate = self;
   // searchController.delegateWorldLOcation=self;
    ///////////////////////////CREATE TAB 1/////////////////////
    ILGeoNamesSearchController *viewController_Varification=[newStoryBoard instantiateViewControllerWithIdentifier:@"ILGeoNamesSearchController"];
    viewController_Varification.delegate = self;
    viewController_Varification.delegateWorldLOcation=self;

   [self.navigationController pushViewController:viewController_Varification animated:YES];


}
-(IBAction)BackbtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];;
}

- (IBAction)showPeoplePicker:(id)sender
{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.appDel_DicForEvent=[[NSMutableDictionary alloc]init];
    if (txtEventName.text && txtEventName.text.length <= 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please enter event name." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (txtLocation.text && txtLocation.text.length <= 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please enter location or enable your location services in your iphone setting." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    
    }
    else if (lblTimeZone.text && lblTimeZone.text.length <= 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please enter your current tme zone." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (btnStratDate.titleLabel.text.length == 0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please select start date." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    
    }
    else if (btnEndDate.titleLabel.text.length == 0)
    {
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please select end date." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else
    {
      //  NSLog(@"%@",btnStratDate.titleLabel.text);
    [txtEventName resignFirstResponder];
        [app.appDel_DicForEvent setObject:txtEventName.text forKey:@"EventName"];
        [app.appDel_DicForEvent setObject:txtLocation.text forKey:@"Location"];
        [app.appDel_DicForEvent setObject:lblTimeZone.text forKey:@"TimeZone"];
        [app.appDel_DicForEvent setObject:btnStratDate.titleLabel.text forKey:@"StartDate"];
        [app.appDel_DicForEvent setObject:btnEndDate.titleLabel.text forKey:@"EndDate"];

        
        
    TKPeoplePickerController *controller = [[TKPeoplePickerController alloc] initPeoplePicker];
    controller.actionDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
        //txtEventName.text= @"";
      //  btnEndDate.titleLabel.text=@"";
       // btnStratDate.titleLabel.text=@"";
    }
}

#pragma mark - TKContactsMultiPickerControllerDelegate

- (void)tkPeoplePickerController:(TKPeoplePickerController*)picker didFinishPickingDataWithInfo:(NSArray*)contacts
{
    [self dismissViewControllerAnimated:YES completion:nil];
    for (id view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]])
            [(UIButton*)view removeFromSuperview];
    }
    
    __block CGRect nameButtonRect = CGRectMake(4, 4, thumbnailSize, thumbnailSize);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // ABAddressBookRef addressBook = ABAddressBookCreate();
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        [contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            TKContact *contact = (TKContact*)obj;
            NSNumber *personID = [NSNumber numberWithInt:contact.recordID];
            ABRecordID abRecordID = (ABRecordID)[personID intValue];
            ABRecordRef abPerson = ABAddressBookGetPersonWithRecordID(addressBook, abRecordID);
            
            // Check person image
            UIImage *personImage = nil;
            if (abPerson != nil && ABPersonHasImageData(abPerson)) {
                if ( /* DISABLES CODE */ (&ABPersonCopyImageDataWithFormat) != nil ) {// iOS >= 4.1
                    CFDataRef contactThumbnailData = ABPersonCopyImageDataWithFormat(abPerson, kABPersonImageFormatThumbnail);
                    personImage = [UIImage imageWithData:(__bridge NSData*)contactThumbnailData];
                    CFRelease(contactThumbnailData);
                    CFDataRef contactImageData = ABPersonCopyImageDataWithFormat(abPerson, kABPersonImageFormatOriginalSize);
                    CFRelease(contactImageData);
                    
                } else {// iOS < 4.1
//                    CFDataRef contactImageData = ABPersonCopyImageData(abPerson);
//                    personImage = [[UIImage imageWithData:(__bridge NSData*)contactImageData] thumbnailImage:CGSizeMake(thumbnailSize, thumbnailSize)];
//                    CFRelease(contactImageData);
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
                if (personImage)
                    [nameButton setBackgroundImage:personImage forState:UIControlStateNormal];
                else
                    [nameButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
                
                [nameButton setFrame:nameButtonRect];
                [nameButton setAlpha:0.0f];
                [nameButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
                [nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [nameButton setTitle:contact.name forState:UIControlStateNormal];
                [nameButton setTitleEdgeInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
                [self.scrollView addSubview:nameButton];
                
                [UIView animateWithDuration:0.2 animations:^{
                    nameButton.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, nameButtonRect.origin.y + thumbnailSize + 4)];
                }];
                
                if (idx != 0 && idx%4 == 3) {
                    nameButtonRect.origin.x = 4;
                    nameButtonRect.origin.y += thumbnailSize + 4;
                }
                else {
                    nameButtonRect.origin.x += thumbnailSize + 4;
                }
            });
            
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CFRelease(addressBook);
        });
    });
}

- (void)tkPeoplePickerControllerDidCancel:(TKPeoplePickerController*)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark ILGeoNamesSearchControllerDelegate methods

- (NSString*)geoNamesUserIDForSearchController:(ILGeoNamesSearchController*)controller {
    return kGeoNamesAccountName;
}

- (void)geoNamesSearchController:(ILGeoNamesSearchController*)controller didFinishWithResult:(NSDictionary*)result
{
    NSLog(@"didFinishWithResult: %@", result);
 //   [self.controller dismissModalViewControllerAnimated:YES];
    
    if(result) {
        //double latitude = [[result objectForKey:kILGeoNamesLatitudeKey] doubleValue];
       // double longitude = [[result objectForKey:kILGeoNamesLongitudeKey] doubleValue];
       // position.text = [NSString stringWithFormat:@"%.5f%c  %.5f%c",
                      //   fabs(latitude), latitude >= 0.0 ? 'N' : 'S',
                       //  fabs(longitude), longitude >= 0.0 ? 'E' : 'W'];
        NSString*strNAme = [result objectForKey:kILGeoNamesAlternateNameKey];
       //NSString*str = [result objectForKey:kILGeoNamesFeatureNameKey];
        NSString*strCountry = [result objectForKey:kILGeoNamesCountryNameKey];
       txtLocation.text= [NSString stringWithFormat:@"%@,%@",strNAme,strCountry];
        
    }
}
-(void)getLocationDataForWorld:(NSDictionary*)dicresult
{
    if(dicresult) {
        // double latitude = [[result objectForKey:kILGeoNamesLatitudeKey] doubleValue];
        // double longitude = [[result objectForKey:kILGeoNamesLongitudeKey] doubleValue];
        // position.text = [NSString stringWithFormat:@"%.5f%c  %.5f%c",
        //   fabs(latitude), latitude >= 0.0 ? 'N' : 'S',
        //  fabs(longitude), longitude >= 0.0 ? 'E' : 'W'];
        txtLocation.text = [dicresult objectForKey:kILGeoNamesAlternateNameKey];
        //NSString*str = [dicresult objectForKey:kILGeoNamesFeatureNameKey];
       // NSString*strCountry = [dicresult objectForKey:kILGeoNamesCountryNameKey];
    }


}
-(void)getLocationDataForWorldString:(NSString*)str
{
    txtLocation.text = str;//[dicresult objectForKey:kILGeoNamesAlternateNameKey];

}

#pragma mark-
#pragma maek-TIMEZONE DELEGATE
-(void)GetTimeZoneName:(NSString*)strTimeZone
{
      NSString*str=strTimeZone;
    lblTimeZone.text=str;
    lblTimeZone.textAlignment=NSTextAlignmentLeft;
}
#pragma mark- API CALL
-(void)postEventDetail:(NSString*)strPhoneNumber DeviceToken:(NSString*)strDeviceToken EvaToken:(NSString*)strEvaToken
{
    
    CreateEventSync *syncEvent = [[CreateEventSync alloc] init];
    syncEvent.delegateEventCreateSync=self;
   // NSDictionary *params = @ {@"phone":strPhoneNumber,@"fbToken":strDeviceToken,@"evaToken":strEvaToken };
   // NSString *strAPI=[NSString stringWithFormat:POST_USER_API,ServiceURL_EVA];
   // [syncEvent postCreateEventServiceCall:strAPI withParams:nil];
}
/////////////////////DELEGATE METHODS FOR POST EVENT DETAIL///////////////
-(void)syncPostEventSuccess:(id) responseObject;
{

    
    [[LoadingViewController instance]stopRotation];
    
    ///////SAVE EVA TOKET IN PLIST////
        
    
}
-(void)syncPostEventFailure:(NSError*) error;
{
    [[LoadingViewController instance]stopRotation];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];

}
@end

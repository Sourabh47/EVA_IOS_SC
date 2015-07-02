//
//  TimeZoneVC.h
//  EVA
//
//  Created by SourabhBanerjee on 6/25/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeZoneDelegate<NSObject>

-(void)GetTimeZoneName:(NSString*)strTimeZone;
@end
@interface TimeZoneVC : UIViewController
{
    id <TimeZoneDelegate>delegateTimeZone;

}
@property (retain) id delegateTimeZone;

@end

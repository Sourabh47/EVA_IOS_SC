//
//  UpcomingEvent.h
//  EVA
//
//  Created by SourabhBanerjee on 6/30/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UpcomingEvent : NSManagedObject

@property (nonatomic, retain) NSString * up_eventName;
@property (nonatomic, retain) id up_resturantName;
@property (nonatomic, retain) NSString * up_hashValue;
@property (nonatomic, retain) NSString * up_evaToken;
@property (nonatomic, retain) id up_user;
@property (nonatomic, retain) NSString * up_voteUp;
@property (nonatomic, retain) NSString * up_voteDown;
@property (nonatomic, retain) NSString * up_dateTime;

@end

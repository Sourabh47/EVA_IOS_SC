#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif


#pragma mark - Constants


#pragma mark-
#pragma mark- APIURLS

#define ServiceURL_EVA @"http://130.211.184.232:8080/"

#define GET_USER_API @"%@user?evaToken=%@"
#define POST_USER_API @"%@user?"


#define POST_SEARCH_RESTAURANT_DETAIL @"%@search?evaToken=%@&term=%@&location=%@"

#define GET_NEWEVENT_LIST_API @"%@invite?evaToken=%@"



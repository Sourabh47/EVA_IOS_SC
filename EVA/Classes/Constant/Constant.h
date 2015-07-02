#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "LoadingViewController.h"
#endif


#pragma mark - Constants
#define appDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]


#pragma mark-
#pragma mark Log
#pragma mark-

#define DEBUG_ON  // uncomment to show all debug code
//#define DEBUG_OFF  // uncomment to hide all debug code

#ifdef DEBUG_ON
#   define Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define Log(...)
#endif

#define DEBUG_INFO_ON  // uncomment to show all debug code
//#define DEBUG_INFO_OFF  // uncomment to hide all debug code

#ifdef DEBUG_INFO_ON
#   define Log_INFO(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define Log_INFO(...)
#endif




/*#define isPortraitOrientation ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown)*/
#define iPad  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)

#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)


#define StoryBoard_IPad      @"Main"



#define kDocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define KDATABASE_NAME @"EVA"
#define KDATABASE_NAME_WITH_EXTS @"EVA.sqlite"



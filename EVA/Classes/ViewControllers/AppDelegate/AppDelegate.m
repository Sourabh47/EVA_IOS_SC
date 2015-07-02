//
//  AppDelegate.m
//  EVA
//
//  Created by SourabhBanerjee on 6/11/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import "AppDelegate.h"
#import "NewEventViewController.h"
#import "UpcomingEventVC.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "Constant.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize appDel_DicForEvent;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    appDel_DicForEvent=[[NSMutableDictionary alloc]init];
    [self.window makeKeyAndVisible];
    [self createTabbar];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
#pragma Mark--  TAB BAR
-(void)createTabbar
{
    
    //init the UITabBarController
    UIStoryboard *newStoryBoard;
    newStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ///////////////////////////CREATE TAB 1/////////////////////
    NewEventViewController *viewController_NewEvent=[newStoryBoard instantiateViewControllerWithIdentifier:@"NewEventViewController"];
    UINavigationController *navController1=[[UINavigationController alloc] initWithRootViewController:viewController_NewEvent];
    //[viewController_NewEvent setTitle:@"New Events"];

    [navController1 setNavigationBarHidden:YES];

    ///////////////////////////CREATE TAB 2/////////////////////

    UpcomingEventVC *viewController_Upcoming=[newStoryBoard instantiateViewControllerWithIdentifier:@"UpcomingEventVC"];
    UINavigationController *navController2=[[UINavigationController alloc] initWithRootViewController:viewController_Upcoming];
    //[viewController_Upcoming setTitle:@"Upcoming"];
    [navController2 setNavigationBarHidden:YES];
    
    ///////////////////////////CREATE TAB 3/////////////////////

    SettingViewController *viewController_Setting=[newStoryBoard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    UINavigationController *navController3=[[UINavigationController alloc] initWithRootViewController:viewController_Setting];
   [navController3 setNavigationBarHidden:YES];
    //[viewController_Setting setTitle:@"Settings"];
    
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.viewControllers = @[navController1,navController2,navController3];
    
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"NewEventTab_Sele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.image = [[UIImage imageNamed:@"NewEventTab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.title = @"New Events";
    
    
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"Upcoming_TabSele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"upcomingTab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.title = @"Upcoming";
    
    tabBarItem3.selectedImage = [[UIImage imageNamed:@"settingTabSele"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"setting_Tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.title = @"Settings";
    
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:249/255.0f green:249/255.0f blue:249/255.0f alpha:1.0]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:0/255.0f green:188/255.0f blue:212/255.0f alpha:1.0] }forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:146/255.0f green:146/255.0f blue:146/255.0f alpha:1.0] }forState:UIControlStateNormal];

    
    //int CheckLoginScreen=0;
    if ([SettingPlist ReadIsEvaToken]) {
        

    // AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //appDelegate.window setRootViewController:appDelegate.tabBarController];
            [self.window addSubview:self.tabBarController.view];
    }
    else{
        LoginViewController *loginVC=[newStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    UINavigationController*navigationController = [[UINavigationController alloc] initWithRootViewController: loginVC];
         [navigationController setNavigationBarHidden:YES];
        

        [self.window setRootViewController:navigationController];
    }
}
#pragma mark-
#pragma mark- CORE DATA
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EVADB" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EVA.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}






@end

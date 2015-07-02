//
//  coreData.h
//  EVA
//
//  Created by SourabhBanerjee on 6/30/15.
//  Copyright (c) 2015 47Billion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface coreData : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

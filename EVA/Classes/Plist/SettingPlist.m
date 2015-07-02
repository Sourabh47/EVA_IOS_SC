//
//  SettingPlist.m
//  RPost
//
//  Created by sourabh on 22/07/13.
//  Copyright (c) 2013 IDEAVATE. All rights reserved.
//

#import "SettingPlist.h"


@implementation SettingPlist
@synthesize path;
NSMutableDictionary *dataValue;;
NSString*path;
NSMutableDictionary* GetplistDict;


#pragma mark---
#pragma mark--CREATE SETTING PLIST


+(NSString*)CreateSettingPlist
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"Setting.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"Setting.plist"] ];
    }
    NSFileManager *fileManager1 = [NSFileManager defaultManager];
    
    if ([fileManager1 fileExistsAtPath: path])
    {
        dataValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    }
    else
    {
        // If the file doesn’t exist, create an empty dictionary
        dataValue = [[NSMutableDictionary alloc] init];
    }
    return path;
    
}
#pragma mark---
#pragma mark--GET SETTING PLIST PPATH
+(NSMutableDictionary*)GetSettingPlistPath
{
    NSString *finalPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Setting.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: finalPath])
    {
        return nil;
    }
    GetplistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:finalPath];
    return GetplistDict;
}
#pragma mark-
#pragma mark-Write PLIST VALUES


+(void)writeEvaToken:(NSString *)strEvaToken
{
    if (strEvaToken)
    {
        path= [self CreateSettingPlist];
        [dataValue setValue:strEvaToken forKey:@"ISEvaToken"];
        
        [dataValue writeToFile: path atomically:YES];
        
        return;
        
    }
    path= [self CreateSettingPlist];
    [dataValue setValue:strEvaToken forKey:@"ISEvaToken"];
    
    [dataValue writeToFile: path atomically:YES];
    
    
}
#pragma mark-
#pragma mark-GET PLIST VALUES

+(NSString*)ReadIsEvaToken
{
    GetplistDict=(NSMutableDictionary*)[self GetSettingPlistPath];
    NSString* value;
    value = [GetplistDict objectForKey:@"ISEvaToken"];
    return value;
}

@end

//
//  SettingPlist.h
//
//  Created by sourabh on 23/06/15.
//

#import <Foundation/Foundation.h>




@interface SettingPlist : NSObject

@property(nonatomic,strong)NSString*path;

+(NSString*)CreateSettingPlist;
+(NSDictionary*)GetSettingPlistPath;


+(void)writeEvaToken:(NSString*)strEvaToken;
+(NSString*)ReadIsEvaToken;

@end

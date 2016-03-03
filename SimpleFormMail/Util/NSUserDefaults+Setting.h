//
//  NSUserDefaults+Setting.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/03/02.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUserSettingGroupName;

@interface NSUserDefaults (Setting)

+ (void)initializeUserSetting;

+ (void)saveMasterVersion:(NSString *)version;
+ (NSString *)loadMasterVersion;

@end

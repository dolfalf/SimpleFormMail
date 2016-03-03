//
//  NSUserDefaults+Setting.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/03/02.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "NSUserDefaults+Setting.h"

NSString * const kUserSettingGroupName = @"group.com.kjcode.dolfalf.SimpleFormMail";

@implementation NSUserDefaults (Setting)

+ (void)initializeUserSetting {
    
    // NSUserDefaultsに初期値を登録する
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:kUserSettingGroupName];
    
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:@"1.0.0" forKey:@"MasterVersion"];
    
    [sharedDefaults registerDefaults:defaults];
    
}

+ (void)saveMasterVersion:(NSString *)version {
    
    // NSUserDefaultsに保存・更新する
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:kUserSettingGroupName];
    [sharedDefaults setObject:version forKey:@"MasterVersion"];
    [sharedDefaults synchronize];
}

+ (NSString *)loadMasterVersion {
    
    // NSUserDefaultsからデータを読み込む
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:kUserSettingGroupName];
    return [sharedDefaults stringForKey:@"MasterVersion"];
}

@end

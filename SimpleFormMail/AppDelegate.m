//
//  AppDelegate.m
//  SimpleFormMail
//
//  Created by kjcode on 2016/02/20.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "AppDelegate.h"
#import "NSUserDefaults+Setting.h"
#import <SFMailKit/CoreDataService.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [NSUserDefaults initializeUserSetting];
    
    //load master
    [self loadMasterData];
    
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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

@implementation AppDelegate (Master)

- (void)loadMasterData {
    
    //タイトル、本文テンプレートをCoreDataへロード
    
    //CoreDataのバージョン
    if ([self isUpdateCoredata]) {
        return;
    }
    
    //Plistから読み込み
    NSArray *title_items = [self readTitlePlist];
    NSArray *content_items = [self readContentPlist];
    
    //CoreDataの更新処理
    [CoreDataService insertMasterData:@{kTitleMasterKey:title_items,
                                        kContentMasterKey:content_items}];
    
    
    
}

#pragma mark - helper methods
- (BOOL)isUpdateCoredata {
    
    NSArray *version_array = [[NSUserDefaults loadMasterVersion] componentsSeparatedByString:@"."];
    
    int version_num = 0;
    for (int i=0; i< version_array.count; i++) {
        version_num = version_num + pow([version_array[i] integerValue],i);
    }
    
    
    NSArray *current_version_array = [@"0.9" componentsSeparatedByString:@"."];
    int current_version_num = 0;
    for (int i=0; i< current_version_array.count; i++) {
        current_version_num = current_version_num + pow([current_version_array[i] integerValue],i);
    }
    
    if (current_version_num  >= version_num) {
        return NO;
    }
    
    return YES;
}

- (NSArray *)readTitlePlist {
    
    NSString* propertyDataFile = [[NSBundle mainBundle]pathForResource:@"TempleteTitles" ofType:@"plist"];
    NSArray *arrayDataList = [NSArray arrayWithContentsOfFile:propertyDataFile];
    
    return arrayDataList;
}

- (NSArray *)readContentPlist {
    
    NSString* propertyDataFile = [[NSBundle mainBundle]pathForResource:@"TempleteContents" ofType:@"plist"];
    NSArray *arrayDataList = [NSArray arrayWithContentsOfFile:propertyDataFile];
    return arrayDataList;
}

@end

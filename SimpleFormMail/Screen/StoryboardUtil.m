//
//  StoryboardUtil.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/24.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "StoryboardUtil.h"
#import "SettingViewController.h"
#import "EditMailViewController.h"

@implementation StoryboardUtil

+ (void)gotoSettingViewController:(id)owner completion:(void(^)(void))completion {
    
    SettingViewController *desc_con = [[SettingViewController alloc] init];
    UINavigationController *desc_navi = [[UINavigationController alloc] initWithRootViewController:desc_con];
    
    [owner presentViewController:desc_navi animated:YES completion:nil];
    
    if (completion) {
        completion();
    }
}

+ (void)gotoEditMailViewController:(id)owner completion:(void(^)(void))completion {
    
    EditMailViewController *desc_con = [[EditMailViewController alloc] init];
    UINavigationController *desc_navi = [[UINavigationController alloc] initWithRootViewController:desc_con];
    
    [owner presentViewController:desc_navi animated:YES completion:nil];
    
    if (completion) {
        completion();
    }
}

@end

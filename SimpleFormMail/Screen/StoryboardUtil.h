//
//  StoryboardUtil.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/24.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SMTPSettingType) {
    SMTPSettingTypeCustom = 0,
    SMTPSettingTypeGmail,
};

@interface StoryboardUtil : NSObject

+ (void)gotoSettingViewController:(id)owner completion:(void(^)(void))completion;
+ (void)gotoSMTPSettingViewController:(id)owner screenType:(SMTPSettingType)screenType completion:(void(^)(void))completion;

+ (void)gotoEditMailViewController:(id)owner param:(NSDictionary *)paramDict completion:(void(^)(void))completion;
@end

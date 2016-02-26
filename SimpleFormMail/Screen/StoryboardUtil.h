//
//  StoryboardUtil.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/24.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryboardUtil : NSObject

+ (void)gotoSettingViewController:(id)owner completion:(void(^)(void))completion;
+ (void)gotoEditMailViewController:(id)owner completion:(void(^)(void))completion;
@end

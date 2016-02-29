//
//  SMTPSettingTableViewController.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/29.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RETableViewManager/RETableViewManager.h>
#import "StoryboardUtil.h"

@interface SMTPSettingTableViewController : UITableViewController <RETableViewManagerDelegate>

- (instancetype)initWithScreenType:(SMTPSettingType)screenType;
@end

//
//  TempleteSelectTableViewController.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/26.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TempleteSelectType) {
    TempleteSelectTypeTitle = 0,
    TempleteSelectTypeContent,
};

@interface TempleteViewCell : UITableViewCell

@end

@interface TempleteSelectTableViewController : UITableViewController

- (instancetype)initWithScreenType:(TempleteSelectType)type;
@end

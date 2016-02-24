//
//  TopViewController.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/23.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *recipientLabel;

- (void)addTarget:(id)target sendButtonTouched:(SEL)action;
- (void)addTarget:(id)target copyButtonTouched:(SEL)action;
- (void)addTarget:(id)target editButtonTouched:(SEL)action;

@end

#pragma mark - TopViewController Class
@interface TopViewController : UIViewController

@end

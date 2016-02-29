//
//  SettingViewController.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/23.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "SettingViewController.h"
#import "SMTPSettingTableViewController.h"

#import "StoryboardUtil.h"
#import "SmtpInfo.h"
#import <MailCore/MCOConstants.h>
#import <SFMailKit/CoreDataService.h>

@interface SettingViewController ()

@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *smtpSection;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initControls];
    
    self.title = @"設定";

    // Create manager
    //
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.smtpSection = [self addSmtpControls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private methods
- (void)initControls {
    
    UIBarButtonItem *close_button = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(closeButtonTouched:)];
    
    self.navigationItem.leftBarButtonItems = @[close_button];
}

#pragma mark - IBAction
- (void)closeButtonTouched:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private methods
- (RETableViewSection *)addSmtpControls
{
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"SMTP設定"];
    [self.manager addSection:section];
    
    // Add items to this section
    //
    ServiceProvidor providor = [CoreDataService serviceProvidorType];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Gmail"
                                      accessoryType:(providor==ServiceProvidorGmail)?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone
                                   selectionHandler:^(RETableViewItem *item) {
                                       [item deselectRowAnimated:YES];
                                       
                                       [StoryboardUtil gotoSMTPSettingViewController:self screenType:SMTPSettingTypeGmail completion:nil];
                                   }]];
    
    [section addItem:[RETableViewItem itemWithTitle:@"Custom"
                                      accessoryType:(providor==ServiceProvidorCustom)?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone
                                   selectionHandler:^(RETableViewItem *item) {
                                       [item deselectRowAnimated:YES];
                                       
                                       [StoryboardUtil gotoSMTPSettingViewController:self screenType:SMTPSettingTypeCustom completion:nil];
                                   }]];
    return section;
}

@end

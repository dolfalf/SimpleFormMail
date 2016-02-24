//
//  SettingViewController.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/23.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *smtpSection;

@property (strong, readwrite, nonatomic) RETextItem *usernameItem;
@property (strong, readwrite, nonatomic) RETextItem *hostnameItem;
@property (strong, readwrite, nonatomic) RENumberItem *portItem;
@property (strong, readwrite, nonatomic) RETextItem *passwordItem;
@property (strong, readwrite, nonatomic) REPickerItem *authTypeItem;
@property (strong, readwrite, nonatomic) RESegmentedItem *connectionTypeItem;

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
    
    UIBarButtonItem *setting_button = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(closeButtonTouched:)];
    
    self.navigationItem.leftBarButtonItems = @[setting_button];
}

#pragma mark - IBAction
- (void)closeButtonTouched:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (RETableViewSection *)addSmtpControls
{
    //__typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"SMTP"];
    [self.manager addSection:section];
    
    // Add items to this section
    //
    self.usernameItem = [RETextItem itemWithTitle:@"User" value:nil placeholder:@"User name"];
    self.hostnameItem = [RETextItem itemWithTitle:@"Host" value:nil placeholder:@"Host name"];
    self.portItem = [RENumberItem itemWithTitle:@"Port" value:@"" placeholder:@"" format:@"XXXXX"];
    self.passwordItem = [RETextItem itemWithTitle:@"Password" value:nil placeholder:@"Password"];
    _passwordItem.secureTextEntry = YES;
    
    self.authTypeItem = [REPickerItem itemWithTitle:@"Auth Type"
                                              value:@[@"None"]
                                        placeholder:nil
                                            options:@[@[@"None",
                                                        @"CRAM-MD5",
                                                        @"PLAIN",
                                                        @"GSSAPI",
                                                        @"DIGEST-MD5",
                                                        @"LOGIN",
                                                        @"Secure Remote Password",
                                                        @"NTLM",
                                                        @"Kerberos 4",
                                                        @"OAuth2",
                                                        @"OAuth2(outlook.com)"]]];
    
    self.authTypeItem.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
    self.connectionTypeItem = [RESegmentedItem itemWithTitle:@"Connection Type"
                                      segmentedControlTitles:@[@"Clear-text", @"Start TLS",@"TLS"]
                                                       value:1
                                    switchValueChangeHandler:^(RESegmentedItem *item) {
                                        NSLog(@"Value: %li", (long)item.value);
                                    }];

    
    [section addItem:self.usernameItem];
    [section addItem:self.hostnameItem];
    [section addItem:self.portItem];
    [section addItem:self.passwordItem];
    [section addItem:self.authTypeItem];
    [section addItem:self.connectionTypeItem];
    
    return section;
}

@end

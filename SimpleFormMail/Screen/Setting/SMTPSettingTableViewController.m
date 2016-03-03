//
//  SMTPSettingTableViewController.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/29.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "SMTPSettingTableViewController.h"

#import "NSData+Extension.h"
#import <MailCore/MCOConstants.h>
#import "CoreDataManager.h"
#import "SIAlertView.h"

@interface SMTPSettingTableViewController ()

@property (assign, nonatomic) SMTPSettingType screenType;

@property (strong, nonatomic) RETableViewManager *manager;
@property (strong, nonatomic) RETableViewSection *smtpSection;

@property (strong, readwrite, nonatomic) RETextItem *usernameItem;
@property (strong, readwrite, nonatomic) RETextItem *hostnameItem;
@property (strong, readwrite, nonatomic) RENumberItem *portItem;
@property (strong, readwrite, nonatomic) RETextItem *passwordItem;
@property (strong, readwrite, nonatomic) REPickerItem *authTypeItem;
@property (strong, readwrite, nonatomic) RESegmentedItem *connectionTypeItem;
@end

@implementation SMTPSettingTableViewController

- (instancetype)initWithScreenType:(SMTPSettingType)screenType {
    self = [super init];

    if (self) {
        //Initialize
        self.screenType = screenType;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SMTP設定";
    
    [self initControls];
    
    // Create manager
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.smtpSection = [self addSmtpControls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    SmtpInfo *model = [SmtpInfo loadModel];
    
    if (model) {
        
        //表示初期化
        if (_screenType != [model.selectProvider integerValue]) {

            _usernameItem.value = @"";
            _passwordItem.value = @"";
            _hostnameItem.value = @"";
            _portItem.value = @"";
            _authTypeItem.value = @[@"None"];
            _connectionTypeItem.value = 0;
                
            return;
        }
        
        _usernameItem.value = model.username;
        NSString *dec_password = [model.password AES256DecryptWithKey:kEncryptKeyString];
        _passwordItem.value = dec_password;
        
        if (_screenType == SMTPSettingTypeCustom) {
            
            _hostnameItem.value = model.hostname;
            _portItem.value = [NSString stringWithFormat:@"%ld",(long)model.port.integerValue];
            
            if (model.selectProvider == SMTPSettingTypeCustom) {
                
                _authTypeItem.value = @[@"None"];
                
                _authTypeItem.value =
                model.authType.integerValue == MCOAuthTypeSASLNone  ?       @[@"None"]:
                model.authType.integerValue == MCOAuthTypeSASLCRAMMD5?      @[@"CRAM-MD5"]:
                model.authType.integerValue == MCOAuthTypeSASLPlain?        @[@"PLAIN"]:
                model.authType.integerValue == MCOAuthTypeSASLGSSAPI?       @[@"GSSAPI"]:
                model.authType.integerValue == MCOAuthTypeSASLDIGESTMD5?    @[@"DIGEST-MD5"]:
                model.authType.integerValue == MCOAuthTypeSASLLogin?        @[@"LOGIN"]:
                model.authType.integerValue == MCOAuthTypeSASLSRP?          @[@"Secure Remote Password"]:
                model.authType.integerValue == MCOAuthTypeSASLNTLM?         @[@"NTLM"]:
                model.authType.integerValue == MCOAuthTypeSASLKerberosV4?   @[@"Kerberos 4"]:
                model.authType.integerValue == MCOAuthTypeXOAuth2?          @[@"OAuth2"]:
                model.authType.integerValue == MCOAuthTypeXOAuth2Outlook?   @[@"OAuth2(outlook.com)"]:@[@"None"];
                
                _connectionTypeItem.value =
                model.connectionType.integerValue == MCOConnectionTypeClear?    0:
                model.connectionType.integerValue == MCOConnectionTypeStartTLS? 1:
                model.connectionType.integerValue == MCOConnectionTypeTLS?      2:0;
            }
        }
        
        [self.tableView reloadData];
    }
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
    
    UIBarButtonItem *back_button = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(backButtonTouched:)];
    
    UIBarButtonItem *save_button = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(saveButtonTouched:)];
    
    self.navigationItem.leftBarButtonItems = @[back_button];
    
    self.navigationItem.rightBarButtonItems = @[save_button];
}

#pragma mark - IBAction
- (void)backButtonTouched:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonTouched:(id)sender {
    
    SmtpInfo *model = [SmtpInfo loadModel];
    if (model == nil) {
        model = [SmtpInfo createModel];
    }
    
    model.username = _usernameItem.value;
    
    NSString *enc_password = [_passwordItem.value AES256EncryptWithKey:kEncryptKeyString];
    model.password = enc_password;
    
    if (_screenType == SMTPSettingTypeCustom) {
        //Custom
        model.hostname = _hostnameItem.value;
        model.port = @(_portItem.value.integerValue);
        
        model.authType =
        [_authTypeItem.value[0] isEqualToString:@"None"]?                   @(MCOAuthTypeSASLNone):
        [_authTypeItem.value[0] isEqualToString:@"CRAM-MD5"]?               @(MCOAuthTypeSASLCRAMMD5):
        [_authTypeItem.value[0] isEqualToString:@"PLAIN"]?                  @(MCOAuthTypeSASLPlain):
        [_authTypeItem.value[0] isEqualToString:@"GSSAPI"]?                 @(MCOAuthTypeSASLGSSAPI):
        [_authTypeItem.value[0] isEqualToString:@"DIGEST-MD5"]?             @(MCOAuthTypeSASLDIGESTMD5):
        [_authTypeItem.value[0] isEqualToString:@"LOGIN"]?                  @(MCOAuthTypeSASLLogin):
        [_authTypeItem.value[0] isEqualToString:@"Secure Remote Password"]? @(MCOAuthTypeSASLSRP):
        [_authTypeItem.value[0] isEqualToString:@"NTLM"]?                   @(MCOAuthTypeSASLNTLM):
        [_authTypeItem.value[0] isEqualToString:@"Kerberos 4"]?             @(MCOAuthTypeSASLKerberosV4):
        [_authTypeItem.value[0] isEqualToString:@"OAuth2"]?                 @(MCOAuthTypeXOAuth2):
        [_authTypeItem.value[0] isEqualToString:@"OAuth2(outlook.com)"]?    @(MCOAuthTypeXOAuth2Outlook):@(-1);
        
        model.connectionType =
        (_connectionTypeItem.value == 0)?@(MCOConnectionTypeClear):
        (_connectionTypeItem.value == 1)?@(MCOConnectionTypeStartTLS):
        (_connectionTypeItem.value == 2)?@(MCOConnectionTypeTLS):@(-1);
        
    }else if(_screenType == SMTPSettingTypeGmail) {
        //Gmail
        model.hostname = @"smtp.gmail.com"; // SMTPサーバのアドレス
        model.port = @(465);
        model.authType = @(MCOAuthTypeSASLPlain);
        model.connectionType = @(MCOConnectionTypeTLS);
    }
    
    model.selectProvider = @(_screenType);

    [model saveModel];
    
    
    //message表示
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"設定" andMessage:@"設定情報を保存しました。"];
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    
    [alertView addButtonWithTitle:@"確認"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              //NSLog(@"Button1 Clicked");
                          }];
    
    [alertView show];
}

#pragma mark - Private methods
- (RETableViewSection *)addSmtpControls
{
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"SMTP"];
    [self.manager addSection:section];
    
    // Add items to this section
    //
    self.usernameItem = [RETextItem itemWithTitle:@"User" value:nil placeholder:@"User name"];
    self.passwordItem = [RETextItem itemWithTitle:@"Password" value:nil placeholder:@"Password"];
    _passwordItem.secureTextEntry = YES;

    [section addItem:self.usernameItem];
    [section addItem:self.passwordItem];
    
    if (_screenType == SMTPSettingTypeCustom) {
        
        self.hostnameItem = [RETextItem itemWithTitle:@"Host" value:nil placeholder:@"Host name"];
        self.portItem = [RENumberItem itemWithTitle:@"Port" value:@"" placeholder:@"" format:@"XXXXX"];
        
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
                                                           value:0
                                        switchValueChangeHandler:^(RESegmentedItem *item) {
                                            NSLog(@"Value: %li", (long)item.value);
                                        }];
        
        
        [section addItem:self.hostnameItem];
        [section addItem:self.portItem];
        [section addItem:self.authTypeItem];
        [section addItem:self.connectionTypeItem];
    }
    
    return section;
}

@end

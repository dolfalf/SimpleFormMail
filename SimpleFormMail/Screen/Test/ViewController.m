//
//  ViewController.m
//  SimpleFormMail
//
//  Created by kjcode on 2016/02/20.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "ViewController.h"
#include <MailCore/MailCore.h>
#import "NSData+Extension.h"
#import "CoreDataManager.h"

#import "SmtpInfo+CoreDataProperties.h"

#import "SIAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //暗号化テスト
    NSString *plaintext = @"dongdong";
    
    //encrypt > base64enc
    NSString *cipher = [plaintext AES256EncryptWithKey: kEncryptKeyString];
    
    NSLog(@"encode: %@", cipher);
    
    //base64dec -> decrypt
    NSString *dec = [cipher AES256DecryptWithKey: kEncryptKeyString];
    NSLog(@"encode: %@", dec);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMail:(id)sender {

    //http://ksksue.hatenablog.com/entry/2015/01/23/022127
    
    [self sendMessage:@"テストです。漢字も表示するか確認するよ。"];
    
}

-(void) sendMessage:(NSString *) message
{
    MCOSMTPSession *smtpSession = [[MCOSMTPSession alloc] init];
    smtpSession.hostname = @"smtp.gmail.com";   // SMTPサーバのアドレス
    smtpSession.port = 465;
    smtpSession.username = @"";           // SMTPサーバのユーザ名
    smtpSession.password = @"";        // SMTPサーバのパスワード
    smtpSession.authType = MCOAuthTypeSASLPlain;
    smtpSession.connectionType = MCOConnectionTypeTLS;
    
    MCOMessageBuilder *builder = [[MCOMessageBuilder alloc] init];
    MCOAddress *from = [MCOAddress addressWithDisplayName:nil
                                                  mailbox:@"@gmail.com"];    // 送信元メールアドレス
    MCOAddress *to = [MCOAddress addressWithDisplayName:nil
                                                mailbox:@"@gmail.com"];        // 送信先メールアドレス
    [[builder header] setFrom:from];
    [[builder header] setTo:@[to]];
    [[builder header] setSubject:@"ここにサブジェクト"];
    [builder setHTMLBody:message];
    NSData * rfc822Data = [builder data];
    
    MCOSMTPSendOperation *sendOperation =
    [smtpSession sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        if(error) {
            NSLog(@"Error sending email: %@", error);
        } else {
            NSLog(@"Successfully sent email!");
        }
    }];
}




- (IBAction)clickAdd:(id)sender {

    SmtpInfo *smtp_info = [NSEntityDescription insertNewObjectForEntityForName:@"SmtpInfo" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
    smtp_info.username = @"test";
    smtp_info.password = @"atst";

    NSError *error = nil;
    
    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }
    
}

- (IBAction)clickFind:(id)sender {

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SmtpInfo" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    NSArray *fetchResult = [[CoreDataManager sharedCoreDataManager].managedObjContext executeFetchRequest:request error:&error];
    
    if (!fetchResult)
    {
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    
    if (fetchResult.count > 0) {
        SmtpInfo *smtp_info = (SmtpInfo *)fetchResult[0];
        
        NSLog(@"name:%@", smtp_info.username);
    }
    
}

- (IBAction)clickChange:(id)sender {

//    [_user setName:self.tfName.text];
//    [_user setSex:self.tfSex.text];
//    [_user setAge:@([self.tfAge.text integerValue])];
//    NSError *error = nil;
//    
//    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
//    if (!isSaveSuccess) {
//        NSLog(@"Error: %@,%@",error,[error userInfo]);
//    }else
//    {
//        NSLog(@"Change successFull");
//    }
    
}

- (IBAction)clickDel:(id)sender {
    
//    [[CoreDataManager sharedCoreDataManager].managedObjContext deleteObject:_user];
//    
//    NSError *error = nil;
//    
//    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
//    if (!isSaveSuccess) {
//        NSLog(@"Error: %@,%@",error,[error userInfo]);
//    }else
//    {
//        NSLog(@"del successFull");
//        
//        _tfName.text = @"";
//        _tfSex.text = @"";
//        _tfAge.text = @"";
//    }
}

- (IBAction)readPlist:(id)sender {

    NSBundle *bundle = [NSBundle mainBundle];

    NSString *path = [bundle pathForResource:@"TempleteContents" ofType:@"plist"];
    //プロパティリストの中身データを取得
    NSArray *items = [NSArray arrayWithContentsOfFile:path];
    
    NSLog(@"%@", items);
}

- (IBAction)alert1:(id)sender
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Title1" andMessage:@"Count down"];
    [alertView addButtonWithTitle:@"Button1"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Button1 Clicked");
                          }];
    [alertView addButtonWithTitle:@"Button2"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Button2 Clicked");
                          }];
    [alertView addButtonWithTitle:@"Button3"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Button3 Clicked");
                          }];
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
    };
    
    //    alertView.cornerRadius = 4;
    //    alertView.buttonFont = [UIFont boldSystemFontOfSize:12];
    [alertView show];
    
    alertView.title = @"3";
    //    double delayInSeconds = 1.0;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        alertView.title = @"2";
    //        alertView.titleColor = [UIColor yellowColor];
    //        alertView.titleFont = [UIFont boldSystemFontOfSize:30];
    //    });
    //    delayInSeconds = 2.0;
    //    popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        alertView.title = @"1";
    //        alertView.titleColor = [UIColor greenColor];
    //        alertView.titleFont = [UIFont boldSystemFontOfSize:40];
    //    });
    //    delayInSeconds = 3.0;
    //    popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        NSLog(@"1=====");
    //        [alertView dismissAnimated:YES];
    //        NSLog(@"2=====");
    //    });
    
}

- (IBAction)alert2:(id)sender
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Title2" andMessage:@"Message2"];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Cancel Clicked");
                          }];
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"OK Clicked");
                              
                              [self alert3:nil];
                              [self alert3:nil];
                          }];
    alertView.titleColor = [UIColor blueColor];
    alertView.cornerRadius = 10;
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler2", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler2", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler2", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler2", alertView);
    };
    
    [alertView show];
}

id observer1,observer2,observer3,observer4;

- (IBAction)alert3:(id)sender
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"Message3"];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Cancel Clicked");
                          }];
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"OK Clicked");
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler3", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler3", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler3", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler3", alertView);
    };
    
    observer1 = [[NSNotificationCenter defaultCenter] addObserverForName:SIAlertViewWillShowNotification
                                                                  object:alertView
                                                                   queue:[NSOperationQueue mainQueue]
                                                              usingBlock:^(NSNotification *note) {
                                                                  NSLog(@"%@, -willShowHandler3", alertView);
                                                              }];
    observer2 =[[NSNotificationCenter defaultCenter] addObserverForName:SIAlertViewDidShowNotification
                                                                 object:alertView
                                                                  queue:[NSOperationQueue mainQueue]
                                                             usingBlock:^(NSNotification *note) {
                                                                 NSLog(@"%@, -didShowHandler3", alertView);
                                                             }];
    observer3 =[[NSNotificationCenter defaultCenter] addObserverForName:SIAlertViewWillDismissNotification
                                                                 object:alertView
                                                                  queue:[NSOperationQueue mainQueue]
                                                             usingBlock:^(NSNotification *note) {
                                                                 NSLog(@"%@, -willDismissHandler3", alertView);
                                                             }];
    observer4 =[[NSNotificationCenter defaultCenter] addObserverForName:SIAlertViewDidDismissNotification
                                                                 object:alertView
                                                                  queue:[NSOperationQueue mainQueue]
                                                             usingBlock:^(NSNotification *note) {
                                                                 NSLog(@"%@, -didDismissHandler3", alertView);
                                                                 
                                                                 [[NSNotificationCenter defaultCenter] removeObserver:observer1];
                                                                 [[NSNotificationCenter defaultCenter] removeObserver:observer2];
                                                                 [[NSNotificationCenter defaultCenter] removeObserver:observer3];
                                                                 [[NSNotificationCenter defaultCenter] removeObserver:observer4];
                                                                 
                                                                 observer1 = observer2 = observer3 = observer4 = nil;
                                                             }];
    
    [alertView show];
}

- (IBAction)alert4:(id)sender
{
    [self alert1:nil];
    [self alert2:nil];
    [self alert3:nil];
}

@end

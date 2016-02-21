//
//  ViewController.m
//  SimpleFormMail
//
//  Created by kjcode on 2016/02/20.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "ViewController.h"
#include <MailCore/MailCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

@end

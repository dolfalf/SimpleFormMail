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
@end

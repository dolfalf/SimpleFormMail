//
//  CoreDataService.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/29.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "CoreDataService.h"
#import "CoreDataManager.h"
#import "NSData+Extension.h"

@implementation CoreDataService

+ (NSDictionary *)smtpInfo {
    
    SmtpInfo *model = [SmtpInfo findModel];
    
    if (model) {
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        
        if (model.username) {
            dict[@"username"] = model.username;
        }
        if (model.hostname) {
            dict[@"username"] = model.hostname;
        }
        if (model.port) {
            dict[@"port"] = model.port;
        }
        if (model.password) {
            NSString *dec_password = [model.password AES256DecryptWithKey:kEncryptKeyString];
            dict[@"password"] = dec_password;
        }
        if (model.authType) {
            dict[@"authType"] = model.authType;
        }else {
            dict[@"authType"] = @(0);
        }
        if (model.connectionType) {
            dict[@"connectionType"] = model.connectionType;
        }else {
            dict[@"connectionType"] = @(0);
        }
        
        if (model.selectProvider) {
            dict[@"selectProvider"] = model.selectProvider;
        }else {
            dict[@"selectProvider"] = @(0);
        }
        return (NSDictionary *)dict;
    }
    
    return nil;
}

+ (void)saveSmtpInfo:(NSDictionary *)info {
    
    SmtpInfo *model = [SmtpInfo findModel];
    
    if (model == nil) {
        model = [SmtpInfo createModel];
    }
    
    model.username = info[@"username"];
    model.hostname = info[@"hostname"];
    model.port = info[@"port"];
    
    NSString *enc_password = [info[@"password"] AES256EncryptWithKey:kEncryptKeyString];
    model.password = enc_password;
    
    model.authType = info[@"authType"];
    model.connectionType = info[@"connectionType"];
    
    [model saveModel];
    
}

+ (ServiceProvidor)serviceProvidorType {
    
    NSDictionary *dict = [[self class] smtpInfo];
    return [dict[@"selectProvider"] integerValue];
}

@end

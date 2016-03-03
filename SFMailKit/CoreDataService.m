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

NSString * const kTitleMasterKey = @"title_items";
NSString * const kContentMasterKey = @"content_items";

@implementation CoreDataService

+ (void)insertMasterData:(NSDictionary *)dict {
    
    if (dict == nil) {
        return;
    }
    
    //Title
    if (dict[kTitleMasterKey] != nil) {
        
        NSArray *title_items = dict[kTitleMasterKey];
        
        NSArray *models = [TitleMaster findDefaultModel];
        for (TitleMaster *model in models) {
            [(TitleMaster *)model deleteModel];
        }
        
        int count = 1;
        for (NSString *title in title_items) {
            TitleMaster *new_model = [TitleMaster createModel];
            new_model.titleId = @(count++);
            new_model.title = title;
            new_model.defaultFlag = @YES;
        }
    }
    
    //Content
    if (dict[kContentMasterKey] != nil) {
        
        NSArray *content_items = dict[kContentMasterKey];
        
        NSArray *models = [ContentMaster findDefaultModel];
        for (ContentMaster *model in models) {
            [(ContentMaster *)model deleteModel];
        }
        
        int count = 1;
        for (NSString *content in content_items) {
            ContentMaster *new_model = [ContentMaster createModel];
            new_model.contentId = @(count++);
            new_model.content = content;
            new_model.defaultFlag = @YES;
        }
    }
    
    //まとめて保存
    [[CoreDataManager sharedCoreDataManager] saveContext];
}

+ (NSDictionary *)smtpInfo {
    
    SmtpInfo *model = [SmtpInfo loadModel];
    
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
    
    SmtpInfo *model = [SmtpInfo loadModel];
    
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

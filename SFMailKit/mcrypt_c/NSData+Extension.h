//
//  NSData+Extension.h
//  SimpleFormMail
//
//  Created by kjcode on 2016/02/20.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kEncryptKeyString = @"simplemail";

@class NSString;

@interface NSString (Extension)

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;

@end
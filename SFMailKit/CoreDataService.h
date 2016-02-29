//
//  CoreDataService.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/29.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ServiceProvidor) {
    ServiceProvidorKnown = -1,
    ServiceProvidorCustom = 0,
    ServiceProvidorGmail,
};

@interface CoreDataService : NSObject

+ (NSDictionary *)smtpInfo;
+ (void)saveSmtpInfo:(NSDictionary *)info;
+ (ServiceProvidor)serviceProvidorType;
@end

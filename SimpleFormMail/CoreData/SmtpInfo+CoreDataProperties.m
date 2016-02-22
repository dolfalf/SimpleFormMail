//
//  SmtpInfo+CoreDataProperties.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/22.
//  Copyright © 2016年 kj-code. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SmtpInfo+CoreDataProperties.h"

@implementation SmtpInfo (CoreDataProperties)

@dynamic username;
@dynamic hostname;
@dynamic password;
@dynamic port;
@dynamic authType;
@dynamic connectionType;

@end

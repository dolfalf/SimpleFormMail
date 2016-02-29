//
//  SmtpInfo+CoreDataProperties.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/29.
//  Copyright © 2016年 kj-code. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SmtpInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SmtpInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *authType;
@property (nullable, nonatomic, retain) NSNumber *connectionType;
@property (nullable, nonatomic, retain) NSString *hostname;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSNumber *port;
@property (nullable, nonatomic, retain) NSNumber *selectProvider;
@property (nullable, nonatomic, retain) NSString *username;

@end

NS_ASSUME_NONNULL_END

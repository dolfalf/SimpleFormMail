//
//  SmtpInfo.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/22.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmtpInfo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (id)createModel;
+ (id)findModel;
- (void)deleteModel;
- (void)saveModel;
@end

NS_ASSUME_NONNULL_END

#import "SmtpInfo+CoreDataProperties.h"

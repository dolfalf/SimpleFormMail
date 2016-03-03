//
//  ContentMaster.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/03/01.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentMaster : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (id)createModel;
+ (NSArray *)findModel;
+ (NSArray *)findDefaultModel;
- (void)deleteModel;
- (void)saveModel;
@end

NS_ASSUME_NONNULL_END

#import "ContentMaster+CoreDataProperties.h"

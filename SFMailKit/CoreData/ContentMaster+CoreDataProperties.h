//
//  ContentMaster+CoreDataProperties.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/03/01.
//  Copyright © 2016年 kj-code. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ContentMaster.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentMaster (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSNumber *contentId;
@property (nullable, nonatomic, retain) NSNumber *defaultFlag;

@end

NS_ASSUME_NONNULL_END

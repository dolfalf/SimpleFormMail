//
//  TitleMaster+CoreDataProperties.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/03/01.
//  Copyright © 2016年 kj-code. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TitleMaster.h"

NS_ASSUME_NONNULL_BEGIN

@interface TitleMaster (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *defaultFlag;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *titleId;

@end

NS_ASSUME_NONNULL_END

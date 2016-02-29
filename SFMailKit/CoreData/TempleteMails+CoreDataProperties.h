//
//  TempleteMails+CoreDataProperties.h
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/22.
//  Copyright © 2016年 kj-code. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TempleteMails.h"

NS_ASSUME_NONNULL_BEGIN

@interface TempleteMails (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *from;
@property (nullable, nonatomic, retain) NSString *to;
@property (nullable, nonatomic, retain) NSString *cc2;
@property (nullable, nonatomic, retain) NSString *cc1;
@property (nullable, nonatomic, retain) NSString *cc3;
@property (nullable, nonatomic, retain) NSString *body;

@end

NS_ASSUME_NONNULL_END

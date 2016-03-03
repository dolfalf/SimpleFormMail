//
//  SmtpInfo.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/22.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "SmtpInfo.h"
#import "CoreDataManager.h"

@implementation SmtpInfo

// Insert code here to add functionality to your managed object subclass
+ (id)createModel {
    
    SmtpInfo *model = [NSEntityDescription insertNewObjectForEntityForName:@"SmtpInfo"
                                                    inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
    
    return model;
}

+ (id)loadModel {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SmtpInfo"
                                              inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
    [request setEntity:entity];
    
    // maybe not needed.  It will still be a fault,
    // but the properties are preloaded
    [request setReturnsObjectsAsFaults:NO];
    
#if 0
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
#endif
    
    NSError *error = nil;
    NSArray *fetchResult = [[CoreDataManager sharedCoreDataManager].managedObjContext executeFetchRequest:request error:&error];
    
    if (!fetchResult)
    {
        NSLog(@"error:%@,%@",error,[error userInfo]);
        return nil;
    }
    
    if (fetchResult.count == 0) {
        NSLog(@"no data");
        return nil;
    }
    
    
    SmtpInfo *model = (SmtpInfo *)fetchResult[0];
    
    return model;
}

- (void)deleteModel {
    
    [[CoreDataManager sharedCoreDataManager].managedObjContext deleteObject:self];

    NSError *error = nil;

    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"del successFull");
    }
}

- (void)saveModel {
    
    NSError *error = nil;
    
    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }
}

@end

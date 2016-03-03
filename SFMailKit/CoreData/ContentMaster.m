//
//  ContentMaster.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/03/01.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "ContentMaster.h"
#import "CoreDataManager.h"

@implementation ContentMaster

// Insert code here to add functionality to your managed object subclass
+ (id)createModel {
    
    ContentMaster *model = [NSEntityDescription insertNewObjectForEntityForName:@"ContentMaster"
                                                       inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
    
    return model;
}

+ (NSArray *)findModel {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoreDataManager"
                                              inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
    [request setEntity:entity];
    
    // maybe not needed.  It will still be a fault,
    // but the properties are preloaded
    [request setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"titleId" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
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
    
    return fetchResult;
}

+ (NSArray *)findDefaultModel {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoreDataManager"
                                              inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
    [request setEntity:entity];
    
    // maybe not needed.  It will still be a fault,
    // but the properties are preloaded
    [request setReturnsObjectsAsFaults:NO];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"titleId" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    //defaultFlag is YES
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"defaultFlag == %@", @(YES)];
    [request setPredicate:predicate];
    
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
    
    return fetchResult;
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

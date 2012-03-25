//
//  User.h
//  SocialFusion
//
//  Created by He Ruoyun on 12-3-24.
//  Copyright (c) 2012年 TJU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NewFeedRootData;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tinyURL;
@property (nonatomic, retain) NSString * pinyinName;
@property (nonatomic, retain) NSString * latestStatus;
@property (nonatomic, retain) NSSet *statuses;
@property (nonatomic, retain) NSSet *newFeed;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addStatusesObject:(NewFeedRootData *)value;
- (void)removeStatusesObject:(NewFeedRootData *)value;
- (void)addStatuses:(NSSet *)values;
- (void)removeStatuses:(NSSet *)values;

- (void)addNewFeedObject:(NewFeedRootData *)value;
- (void)removeNewFeedObject:(NewFeedRootData *)value;
- (void)addNewFeed:(NSSet *)values;
- (void)removeNewFeed:(NSSet *)values;

@end

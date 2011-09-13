//
//  WeiboStatus.h
//  SocialFusion
//
//  Created by Blue Bitch on 11-9-9.
//  Copyright (c) 2011年 TJU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WeiboStatus, WeiboUser;

@interface WeiboStatus : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * bmiddlePicURL;
@property (nonatomic, retain) NSString * commentsCount;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * favorited;
@property (nonatomic, retain) NSString * originalPicURL;
@property (nonatomic, retain) NSString * repostsCount;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * statusID;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * thumbnailPicURL;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) WeiboUser *author;
@property (nonatomic, retain) WeiboUser *favoritedBy;
@property (nonatomic, retain) WeiboUser *isFriendStatuesOf;
@property (nonatomic, retain) NSSet *repostBy;
@property (nonatomic, retain) WeiboStatus *repostStatus;


@end



@interface WeiboStatus (CoreDataGeneratedAccessors)
- (void)addRepostByObject:(WeiboStatus *)value;
- (void)removeRepostByObject:(WeiboStatus *)value;
- (void)addRepostBy:(NSSet *)value;
- (void)removeRepostBy:(NSSet *)value;

@end

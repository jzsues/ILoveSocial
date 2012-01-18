//
//  LNLabelBarViewController.h
//  SocialFusion
//
//  Created by Blue Bitch on 12-1-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNLabelPageViewController.h"

@interface LNLabelBarViewController : UIViewController<LNLabelPageViewControllerDelegate> {
    UIScrollView *_scrollView;
    NSMutableArray *_labelPages;
    NSUInteger _pageCount;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end
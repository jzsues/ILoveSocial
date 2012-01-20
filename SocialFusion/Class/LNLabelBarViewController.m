//
//  LNLabelBarViewController.m
//  SocialFusion
//
//  Created by Blue Bitch on 12-1-19.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "LNLabelBarViewController.h"

@implementation LNLabelBarViewController

@synthesize scrollView = _scrollView;
@synthesize labelInfoArray = _labelInfoArray;
@synthesize pageControl = _pageControl;
@synthesize pageCount = _pageCount;

- (void)dealloc {
    [_scrollView release];
    [_labelPages release];
    [_labelInfoArray release];
    [_pageControl release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.scrollView = nil;
    self.pageControl = nil;
}

- (void)createLabelPageAtIndex:(NSInteger)index {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * index;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    NSMutableArray *labelInfoSubArray = [NSMutableArray arrayWithArray:[self.labelInfoArray subarrayWithRange:
                                                                        NSMakeRange(index * 4, self.labelInfoArray.count < (index + 1) * 4 ? self.labelInfoArray.count - index * 4 : 4)]];
    LNLabelPageViewController *pageView = [[LNLabelPageViewController alloc] initWithInfoSubArray:labelInfoSubArray pageIndex:index];
    
    pageView.view.frame = frame;
    [self.scrollView addSubview:pageView.view];
    [_labelPages addObject:pageView];
    pageView.delegate = self;
    [pageView release];
}

- (void)refreshLabelBarContentSize {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.pageCount + 1, self.scrollView.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageCount = _labelInfoArray.count / 4;
    if(_labelInfoArray.count % 4 != 0)
        self.pageCount = self.pageCount + 1;
    for (int i = 0; i < self.pageCount; i++) {
        [self createLabelPageAtIndex:i];
    }
    self.scrollView.delegate = self;
    [self refreshLabelBarContentSize];
    self.pageControl.numberOfPages = self.pageCount;
}

- (id)init {
    self = [super init];
    if(self) {
        _labelPages = [[NSMutableArray alloc] init];
        _labelInfoArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)createLabelWithInfo:(LabelInfo *)info {
    [self.labelInfoArray addObject:info];
    if(self.labelInfoArray.count % 4 == 1) {
        self.pageCount = self.pageCount + 1;
        [self createLabelPageAtIndex:self.pageCount - 1];
        [self refreshLabelBarContentSize];
        LNLabelPageViewController *page = [_labelPages objectAtIndex:self.pageCount - 1];
        [page selectLastLabel];
    }
    else {
        LNLabelPageViewController *page = [_labelPages objectAtIndex:self.pageCount - 1];
        [page activateLastLabel:info];
    }
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * (self.pageCount - 1), 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
    self.pageControl.currentPage = self.pageCount;
}

#pragma mark -
#pragma mark LNLabelPageViewController delegate

- (void)labelPageView:(LNLabelPageViewController *)pageView didSelectLabelAtIndex:(NSUInteger)index {
    NSUInteger page = pageView.page;
    for (int i = 0; i < self.pageCount; i++) {
        LNLabelPageViewController *pv = (LNLabelPageViewController *)[_labelPages objectAtIndex:i];
        [pv selectOtherPage:page];
    }
}

- (void)labelPageView:(LNLabelPageViewController *)pageView didRemoveLabelAtIndex:(NSUInteger)index {
    NSUInteger labelIndexInPage = index % 4;
    LNLabelViewController *label = [pageView.labelViews objectAtIndex:labelIndexInPage];
    if(label.isSelected) {
        NSUInteger labelToSelectIndex = index - 1;
        NSUInteger labelToSelectPage = labelToSelectIndex / 4;
        NSUInteger labelToSelectIndexInPage = labelToSelectIndex % 4;
        LNLabelPageViewController *labelPageToSelect = [_labelPages objectAtIndex:labelToSelectPage];
        LNLabelViewController *labelToSelect = [labelPageToSelect.labelViews objectAtIndex:labelToSelectIndexInPage];
        [labelToSelect clickTitleButton:nil];
    }
    
    NSUInteger page = pageView.page;
    [self.labelInfoArray removeObjectAtIndex:index];
    
    if(self.labelInfoArray.count % 4 == 0) {
        self.pageCount = self.pageCount - 1;
        LNLabelPageViewController *lastPage = [_labelPages lastObject];
        [lastPage.view removeFromSuperview];
        [_labelPages removeLastObject];
        if(page >= self.pageCount)
            [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * (self.pageCount - 1), 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
        else 
            [self refreshLabelBarContentSize];
    }
    
    for(int i = page; i < self.pageCount; i++) {
        NSMutableArray *labelInfoSubArray = [NSMutableArray arrayWithArray:[self.labelInfoArray subarrayWithRange:
                                                                            NSMakeRange(i * 4, self.labelInfoArray.count < (i + 1) * 4 ? self.labelInfoArray.count - i * 4 : 4)]];
        LNLabelPageViewController *pageView = [_labelPages objectAtIndex:i];
        pageView.labelInfoSubArray = labelInfoSubArray;
    }
    for(int i = 0; i < self.pageCount; i++) {
        for(int j = 0; j < 4; j++) {
            LNLabelPageViewController *page = [_labelPages objectAtIndex:i];
            LNLabelViewController *label = [page.labelViews objectAtIndex:j];
            if(label.isSelected) {
                [label clickTitleButton:nil];
            }
        }
    }
}

- (void)labelPageView:(LNLabelPageViewController *)pageView didOpenLabelAtIndex:(NSUInteger)index {
    
}

- (void)labelPageView:(LNLabelPageViewController *)pageView didCloseLabelAtIndex:(NSUInteger)index {
    
}

- (void)setPageCount:(NSUInteger)pageCount {
    _pageCount = pageCount;
    self.pageControl.numberOfPages = pageCount;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
     [self refreshLabelBarContentSize];
}

#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
}

@end

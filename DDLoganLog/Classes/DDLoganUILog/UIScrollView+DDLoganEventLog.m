//
//  UIScrollView+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/1.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIScrollView+DDLoganEventLog.h"
#import "NSObject+DDSwizzlingMethods.h"

@implementation UIScrollView (DDLoganEventLog)

+ (void)load {
    [NSObject loganInit];
    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
                             swizzledSel:@selector(dd_scrollview_setDelegate:)];
}

- (void)dd_scrollview_setDelegate:(id<UIScrollViewDelegate>)delegate {
    [self dd_scrollview_setDelegate:delegate];
    
    dd_exchangeMethod([delegate class], @selector(scrollViewDidEndDecelerating:), [self class], @selector(dd_replace_scrollViewDidEndDecelerating:),@selector(dd_add_scrollViewDidEndDecelerating:));
}

- (void)dd_add_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.contentOffset = NSStringFromCGPoint(scrollView.contentOffset) ;
    model.des = @"scroll DidEndDecelerating";
    model.frame = NSStringFromCGRect(scrollView.frame);
    logan(DDEventScrollviewDidScroll, [@"" objectToJson:model.mj_keyValues]);
}

- (void)dd_replace_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.contentOffset = NSStringFromCGPoint(scrollView.contentOffset) ;
    model.des = @"scroll DidEndDecelerating";
    model.frame = NSStringFromCGRect(scrollView.frame);
    logan(DDEventScrollviewDidScroll, [@"" objectToJson:model.mj_keyValues]);
    [self dd_replace_scrollViewDidEndDecelerating:scrollView];
}

@end

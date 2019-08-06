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
    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
                             swizzledSel:@selector(dd_scrollview_setDelegate:)];
}

- (void)dd_scrollview_setDelegate:(id<UIScrollViewDelegate>)delegate {
    [self dd_scrollview_setDelegate:delegate];
    
    dd_exchangeMethod([delegate class], @selector(scrollViewDidEndDecelerating:), [self class], @selector(dd_replace_scrollViewDidEndDecelerating:),@selector(dd_add_scrollViewDidEndDecelerating:));
}

- (void)dd_add_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    logan(DDEventScrollviewDidScroll, [NSString stringWithFormat:@"scroll:x=%f,y=%f,frame.x=%f,frame.y=%f",scrollView.contentOffset.x,scrollView.contentOffset.y,scrollView.frame.origin.x,scrollView.frame.origin.y]);
}

- (void)dd_replace_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    logan(DDEventScrollviewDidScroll, [NSString stringWithFormat:@"scroll:x=%f,y=%f,frame.x=%f,frame.y=%f",scrollView.contentOffset.x,scrollView.contentOffset.y,scrollView.frame.origin.x,scrollView.frame.origin.y]);
}

@end

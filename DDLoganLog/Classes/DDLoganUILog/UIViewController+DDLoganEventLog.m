//
//  UIViewController+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/1.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIViewController+DDLoganEventLog.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation UIViewController (DDLoganEventLog)

+ (void)load {
    [self swizzlingMethodWithOriginalSel:@selector(viewDidAppear:)
                             swizzledSel:@selector(dd_viewDidAppear:)];
    [self swizzlingMethodWithOriginalSel:@selector(viewDidDisappear:)
                             swizzledSel:@selector(dd_viewDidDisappear:)];
}

- (void)dd_viewDidAppear:(BOOL)animated {
    logan(DDEventViewControllerDidAppear, [NSString stringWithFormat:@"AppearVCClass=%@",NSStringFromClass([self class])]);
    loganFlush();
    [self dd_viewDidAppear:animated];
}

- (void)dd_viewDidDisappear:(BOOL)animated {
    logan(DDEventViewControllerDidDisappear, [NSString stringWithFormat:@"DisappearVCClass=%@",NSStringFromClass([self class])]);
    loganFlush();
    [self dd_viewDidDisappear:animated];
}

@end

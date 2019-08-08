//
//  UIAlertController+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/2.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIAlertController+DDLoganEventLog.h"
#import "NSObject+DDSwizzlingMethods.h"

@implementation UIAlertController (DDLoganEventLog)

+ (void)load {
    [self swizzlingMethodWithOriginalSel:@selector(viewDidAppear:)
                             swizzledSel:@selector(dd_alertController_viewDidAppear:)];
    [self swizzlingMethodWithOriginalSel:@selector(viewDidDisappear:)
                             swizzledSel:@selector(dd_alertController_viewDidDisappear:)];
}

- (void)dd_alertController_viewDidAppear:(BOOL)animated {
    logan(DDEventAlertControllerDidAppear, [NSString stringWithFormat:@"AppearVCClass=%@,title=%@,message=%@",NSStringFromClass([self class]),self.title,self.message]);
    loganFlush();
    [self dd_alertController_viewDidAppear:animated];
}

- (void)dd_alertController_viewDidDisappear:(BOOL)animated {
    logan(DDEventAlertControllerDidDisappear, [NSString stringWithFormat:@"DisappearVCClass=%@,title=%@,message=%@",NSStringFromClass([self class]),self.title,self.message]);
    loganFlush();
    [self dd_alertController_viewDidDisappear:animated];
}

@end

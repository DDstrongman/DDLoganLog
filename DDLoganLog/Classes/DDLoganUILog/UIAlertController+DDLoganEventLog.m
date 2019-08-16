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
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.des = @"AppearVCClass";
    model.alertControllerTitle = self.title;
    model.alertControllerMessage = self.message;
    logan(DDEventAlertControllerDidAppear, [@"" objectToJson:model.mj_keyValues]);
    [self dd_alertController_viewDidAppear:animated];
}

- (void)dd_alertController_viewDidDisappear:(BOOL)animated {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.des = @"DisappearVCClass";
    model.alertControllerTitle = self.title;
    model.alertControllerMessage = self.message;
    logan(DDEventAlertControllerDidDisappear, [@"" objectToJson:model.mj_keyValues]);
    [self dd_alertController_viewDidDisappear:animated];
}

@end

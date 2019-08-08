//
//  UIResponder+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/1.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIResponder+DDLoganEventLog.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation UIResponder (DDLoganEventLog)

+ (void)load {
    NSError *error;
    [self swizzlingMethodWithOriginalSel:@selector(becomeFirstResponder)
                             swizzledSel:@selector(dd_becomeFirstResponder)];
    [self swizzlingMethodWithOriginalSel:@selector(resignFirstResponder)
                             swizzledSel:@selector(dd_resignFirstResponder)];
//    [self aspect_hookSelector:@selector(touchesBegan:withEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,NSSet<UITouch *> *touches,UIEvent *event) {
//        logan(DDEventTouchBegin, [NSString stringWithFormat:@"UIResponder touch begin=%@",touches]);
//    }
//                        error:&error];
//    [self aspect_hookSelector:@selector(touchesEnded:withEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,NSSet<UITouch *> *touches,UIEvent *event) {
//        logan(DDEventTouchEnd, [NSString stringWithFormat:@"UIResponder touch end=%@",touches]);
//    }
//                        error:&error];
}

- (BOOL)dd_becomeFirstResponder {
    BOOL result = [self dd_becomeFirstResponder];
    if (![self isKindOfClass:[UIViewController class]]) {
        logan(DDEventBecomeFirstResponder, [NSString stringWithFormat:@"className=%@",NSStringFromClass([self class])]);
        loganFlush();
    }
    return result;
}

- (BOOL)dd_resignFirstResponder {
    BOOL result = [self dd_resignFirstResponder];
    if (![self isKindOfClass:[UIViewController class]]) {
        logan(DDEventResignFirstResponder, [NSString stringWithFormat:@"className=%@",NSStringFromClass([self class])]);
        loganFlush();
    }
    return result;
}

@end

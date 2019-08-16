//
//  UIGestureRecognizer+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/2.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIGestureRecognizer+DDLoganEventLog.h"
#import "NSObject+DDSwizzlingMethods.h"

@implementation UIGestureRecognizer (DDLoganEventLog)

+ (void)load {
    NSError *error;
//    [self swizzlingMethodWithOriginalSel:@selector(initWithTarget:action:)
//                             swizzledSel:@selector(dd_initWithTarget:action:)];
//    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
//                             swizzledSel:@selector(dd_UIGestureRecognizer_setDelegate:)];
//    [self swizzlingMethodWithOriginalSel:@selector(addTarget:action:)
//                             swizzledSel:@selector(dd_addTarget:action:)];
    [self aspect_hookSelector:@selector(initWithTarget:action:)
                  withOptions:AspectPositionBefore
                   usingBlock:^(id<AspectInfo> aspectInfo,id target,SEL action) {
                       [target aspect_hookSelector:action withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                           DDLoganLogModel *model = [DDLoganLogModel new];
                           model.className = NSStringFromClass([self class]);
                           model.targetClassName = target;
                           model.des = @"UIGestureRecognizer initWithTarget";
                           model.selectorName = NSStringFromSelector(action);
                           logan(DDEventGestureTargetAction, [@"" objectToJson:model.mj_keyValues]);
                       } error:nil];
                   }
                        error:&error];
    [self aspect_hookSelector:@selector(addTarget:action:)
                  withOptions:AspectPositionBefore
                   usingBlock:^(id<AspectInfo> aspectInfo,id target,SEL action) {
                       [target aspect_hookSelector:action withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
                           DDLoganLogModel *model = [DDLoganLogModel new];
                           model.className = NSStringFromClass([self class]);
                           model.targetClassName = target;
                           model.des = @"UIGestureRecognizer addTarget";
                           model.selectorName = NSStringFromSelector(action);
                           logan(DDEventGestureTargetAction, [@"" objectToJson:model.mj_keyValues]);
                       } error:nil];
                   } error:&error];
}

//- (instancetype)dd_initWithTarget:(nullable id)target
//                           action:(nullable SEL)action {
//    dd_exchangeMethod([target class], action, [self class], @selector(dd_action), @selector(dd_action));
//    return [self dd_initWithTarget:target
//                            action:action];
//}
//
//- (void)dd_UIGestureRecognizer_setDelegate:(id<UIGestureRecognizerDelegate>)delegate {
//    [self dd_UIGestureRecognizer_setDelegate:delegate];
//    dd_exchangeMethod([delegate class], @selector(gestureRecognizerShouldBegin:), [self class], @selector(dd_replace_gestureRecognizerShouldBegin:), @selector(dd_add_gestureRecognizerShouldBegin:));
//}
//
//- (void)dd_addTarget:(id)target action:(SEL)action {
//    [self dd_addTarget:target action:action];
//    dd_exchangeMethod([target class], action, [self class], @selector(dd_action), @selector(dd_action));
//}
//
//- (void)dd_action {
//    [self dd_action];
//    logan(DDEventGestureTarget, [NSString stringWithFormat:@"uigesture target class=%@",NSStringFromClass([self class])]);
//}
//#pragma mark - delegates
//- (BOOL)dd_replace_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    logan(DDEventGestureBegin, [NSString stringWithFormat:@"uigesture begin class=%@,getture=%@",NSStringFromClass([self class]),NSStringFromClass([gestureRecognizer class])]);
//    return [self dd_replace_gestureRecognizerShouldBegin:gestureRecognizer];
//}
//
//- (BOOL)dd_add_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    logan(DDEventGestureBegin, [NSString stringWithFormat:@"uigesture begin class=%@,getture=%@",NSStringFromClass([self class]),NSStringFromClass([gestureRecognizer class])]);
//    return [self dd_add_gestureRecognizerShouldBegin:gestureRecognizer];
//}

@end

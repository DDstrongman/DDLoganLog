//
//  UIControl+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/1.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIControl+DDLoganEventLog.h"
#import "NSObject+DDSwizzlingMethods.h"

@implementation UIControl (DDLoganEventLog)

+ (void)load {
    NSError *error;
    [self aspect_hookSelector:@selector(addTarget:action:forControlEvents:)
                  withOptions:AspectPositionBefore
                   usingBlock:^(id<AspectInfo> aspectInfo,id target,SEL action,UIControlEvents controlEvents) {
                       [target aspect_hookSelector:action withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
                           DDLoganLogModel *model = [DDLoganLogModel new];
                           model.className = NSStringFromClass([self class]);
                           model.targetClassName = target;
                           model.des = @"UIControl addTargetFunc";
                           model.selectorName = NSStringFromSelector(action);
                           model.info = [NSString stringWithFormat:@"controlEvents=%ld",controlEvents];
                           logan(DDEventControlTargetAction, [@"" objectToJson:model.mj_keyValues]);
                       } error:nil];
                   } error:&error];
}

@end

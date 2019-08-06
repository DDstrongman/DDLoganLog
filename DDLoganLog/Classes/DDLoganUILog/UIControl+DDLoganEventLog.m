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
                           logan(DDEventControlTargetAction, [NSString stringWithFormat:@"uicontrol  class=%@,target=%@,sel=%@,events=%ld",self,target,NSStringFromSelector(action),controlEvents]);
                       } error:nil];
                   }
                        error:&error];
}

@end

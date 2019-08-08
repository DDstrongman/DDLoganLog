//
//  UIApplication+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/2.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIApplication+DDLoganEventLog.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation UIApplication (DDLoganEventLog)

+ (void)load {
    NSError *error;
    [self aspect_hookSelector:@selector(openURL:options:completionHandler:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,NSURL *url ,NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *options,void(^completion)(BOOL success)) {
        logan(DDEventApplicationOpenUrl, [NSString stringWithFormat:@"UIApplication open Url=%@,options=%@",url,options]);
        loganFlush();
    }
                        error:&error];
    [[[UIApplication sharedApplication].delegate class] aspect_hookSelector:@selector(application:openURL:options:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,UIApplication *app,NSURL *url ,NSDictionary<UIApplicationOpenURLOptionsKey, id> *options){
        logan(DDEventApplicationOpenUrl, [NSString stringWithFormat:@"UIApplication open Url=%@,options=%@,app=%@",url,options,app]);
        loganFlush();
    } error:&error];
}

@end

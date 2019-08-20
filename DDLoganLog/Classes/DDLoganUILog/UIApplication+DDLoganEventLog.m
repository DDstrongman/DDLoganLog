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
    [NSObject loganInit];
    NSError *error;
    [self aspect_hookSelector:@selector(openURL:options:completionHandler:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,NSURL *url ,NSDictionary<UIApplicationOpenExternalURLOptionsKey, id> *options,void(^completion)(BOOL success)) {
        DDLoganLogModel *model = [DDLoganLogModel new];
        model.url = url.absoluteString;
        model.des = @"UIApplication OpenUrl";
        model.info = options;
        logan(DDEventApplicationOpenUrl, [@"" objectToJson:model.mj_keyValues]);
    } error:&error];
    [[[UIApplication sharedApplication].delegate class] aspect_hookSelector:@selector(application:openURL:options:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,UIApplication *app,NSURL *url ,NSDictionary<UIApplicationOpenURLOptionsKey, id> *options){
        DDLoganLogModel *model = [DDLoganLogModel new];
        model.url = url.absoluteString;
        model.des = @"UIApplication OpenUrl";
        model.info = options;
        logan(DDEventApplicationOpenUrl, [@"" objectToJson:model.mj_keyValues]);
    } error:&error];
}

@end

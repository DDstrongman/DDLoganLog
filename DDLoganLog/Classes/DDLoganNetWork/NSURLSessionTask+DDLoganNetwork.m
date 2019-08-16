//
//  NSURLSessionTask+DDLoganNetwork.m
//  DDCardView
//
//  Created by DDLi on 2019/8/5.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "NSURLSessionTask+DDLoganNetwork.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation NSURLSessionTask (DDLoganNetwork)

+ (void)load {
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wnonnull"
    NSURLSessionDataTask *localDataTask = [session dataTaskWithURL:nil];
    [[localDataTask class] aspect_hookSelector:@selector(resume) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSURLSessionTask *task = [aspectInfo instance];
        
        DDLoganLogModel *model = [DDLoganLogModel new];
        model.url = [task.currentRequest.URL absoluteString];
        model.des = @"NSURLSessionTask resume";
        logan(DDNetLogBegin, [@"" objectToJson:model.mj_keyValues]);
        if (task.error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        }
    } error:&error];
    [[localDataTask class] aspect_hookSelector:@selector(suspend) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSURLSessionTask *task = [aspectInfo instance];
        DDLoganLogModel *model = [DDLoganLogModel new];
        model.url = [task.currentRequest.URL absoluteString];
        model.des = @"NSURLSessionTask suspend";
        logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
    } error:&error];
}

@end

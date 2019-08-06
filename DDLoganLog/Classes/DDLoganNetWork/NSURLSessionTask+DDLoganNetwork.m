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
        logan(DDNetLogBegin,[NSString stringWithFormat:@"NSURLSessionTask resume url=%@",[task.currentRequest.URL absoluteString]]);
        if (task.error) {
            logan(DDNetLogFailed,[NSString stringWithFormat:@"NSURLSessionTask error url=%@,error=%@",[task.currentRequest.URL absoluteString],task.error]);
        }
    } error:&error];
    [[localDataTask class] aspect_hookSelector:@selector(suspend) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSURLSessionTask *task = [aspectInfo instance];
        logan(DDNetLogFailed,[NSString stringWithFormat:@"NSURLSessionTask suspend url=%@",[task.currentRequest.URL absoluteString]]);
    } error:&error];
}

@end

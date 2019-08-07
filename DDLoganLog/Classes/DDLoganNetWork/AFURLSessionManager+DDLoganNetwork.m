//
//  AFURLSessionManager+DDLoganNetwork.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/6.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "AFURLSessionManager+DDLoganNetwork.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation AFURLSessionManager (DDLoganNetwork)

+ (void)load {
    [self swizzlingMethodWithOriginalSel:@selector(dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:) swizzledSel:@selector(dd_dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:)];
}

- (NSURLSessionDataTask *)dd_dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                            completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    return [self dd_dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(response,responseObject,error);
        }
    }];
}

@end

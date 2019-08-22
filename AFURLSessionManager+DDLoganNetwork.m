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
        DDLoganLogModel *model = [DDLoganLogModel new];
        model.url = request.URL.absoluteString;
        if (model.url && model.url.length > 0) {
            NSString *httpUUID = [NSString httpUUID];
            model.httpUUID = httpUUID;
        }
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
//            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
//            loganFlush();
//            [[DDDBSearchHisManager ShareInstance]directInsertTableObjQueue:dd_tableName
//                                                                 dataModel:[DDSqlTableModel modelType:DDNetLogFailed describe:[NSString stringWithFormat:@"NSURLSession failed=%@",error.description]]
//                                                                    result:^(BOOL result) {
//
//                                                                    }];
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            if (model.url && model.url.length > 0) {
                NSInteger requestTime = [[[NSUserDefaults standardUserDefaults]objectForKey:model.url] integerValue];
                NSInteger currentTime = [[@"" currentTime] integerValue];
                model.httpTime = [NSString stringWithFormat:@"%ld",currentTime - requestTime];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:model.url];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:[model.url stringByAppendingString:@"_uuid"]];
            }
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
//            [[DDDBSearchHisManager ShareInstance]directInsertTableObjQueue:dd_tableName
//                                                                 dataModel:[DDSqlTableModel modelType:DDNetLogSuccess describe:[NSString stringWithFormat:@"NSURLSession response=%@",response.description]]
//                                                                    result:^(BOOL result) {
//                                                                        
//                                                                    }];
        }
        if (completionHandler) {
            completionHandler(response,responseObject,error);
        }
    }];
}

@end

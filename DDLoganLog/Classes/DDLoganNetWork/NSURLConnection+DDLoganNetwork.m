//
//  NSURLConnection+DDLoganNetwork.m
//  Unity-iPhone
//
//  Created by DDLi on 2019/7/29.
//

#import "NSObject+DDSwizzlingMethods.h"

#import "NSURLConnection+DDLoganNetwork.h"

@implementation NSURLConnection (DDLoganNetwork)

+ (void)load {
    [NSObject loganInit];
    [self swizzlingClassMethodWithOriginalSel:@selector(sendSynchronousRequest:returningResponse:error:)
                                  swizzledSel:@selector(dd_sendSynchronousRequest:returningResponse:error:)];
    [self swizzlingClassMethodWithOriginalSel:@selector(sendAsynchronousRequest:queue:completionHandler:)
                                  swizzledSel:@selector(dd_sendAsynchronousRequest:queue:completionHandler:)];
}
    
+ (nullable NSData *)dd_sendSynchronousRequest:(NSURLRequest *)request
                             returningResponse:(NSURLResponse * _Nullable * _Nullable)response
                                         error:(NSError **)error {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = request.URL.absoluteString;
    model.des = @"NSURLConnection sendSynchronous";
    if (model.url && model.url.length > 0) {
        NSString *httpUUID = [NSString httpUUID];
        model.httpUUID = httpUUID;
    }
    NSString *startTime = [@"" currentTime];
    logan(DDNetLogBegin, [@"" objectToJson:model.mj_keyValues]);
    NSData *tempData = [self dd_sendSynchronousRequest:request
                                     returningResponse:response
                                                 error:error];
    if (error) {
        model.code = [NSString stringWithFormat:@"%ld",(*error).code];
        model.des = (*error).description;
        logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
    } else {
        if (response) {
            if ([(*response) isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)(*response)).statusCode];
            }
            model.des = (*response).description;
            NSString *endTime = [@"" currentTime];
            model.httpTime = [NSString stringWithFormat:@"%ld",[endTime integerValue] - [startTime integerValue]];
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
    }
    return tempData;
}
    
+ (void)dd_sendAsynchronousRequest:(NSURLRequest*) request
                          queue:(NSOperationQueue*) queue
              completionHandler:(void (^)(NSURLResponse* _Nullable response, NSData* _Nullable data, NSError* _Nullable connectionError)) handler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = request.URL.absoluteString;
    model.des = @"NSURLConnection sendAsynchronous";
    if (model.url && model.url.length > 0) {
        NSString *httpUUID = [NSString httpUUID];
        model.httpUUID = httpUUID;
    }
    NSString *startTime = [@"" currentTime];
    logan(DDNetLogBegin, [@"" objectToJson:model.mj_keyValues]);
    [self dd_sendAsynchronousRequest:request
                               queue:queue
                   completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                       if (connectionError) {
                           model.code = [NSString stringWithFormat:@"%ld",connectionError.code];
                           model.des = connectionError.description;
                           logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
                       } else {
                           if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                               model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
                           }
                           model.des = response.description;
                           NSString *endTime = [@"" currentTime];
                           model.httpTime = [NSString stringWithFormat:@"%ld",[endTime integerValue] - [startTime integerValue]];
                           logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
                       }
                       if (handler) {
                           handler(response,data,connectionError);
                       }
                   }];
}

- (void)dd_connection:(NSURLConnection *)connection
     didFailWithError:(NSError *)error {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = self.currentRequest.URL.absoluteString;
    model.des = error.description;
    model.method = self.currentRequest.HTTPMethod;
    logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
    [self dd_connection:connection
       didFailWithError:error];
}

- (void)dd_connection:(NSURLConnection *)connection
   didReceiveResponse:(NSURLResponse *)response {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = self.currentRequest.URL.absoluteString;
    model.des = response.description;
    model.method = self.currentRequest.HTTPMethod;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
    [self dd_connection:connection
     didReceiveResponse:response];
}

@end

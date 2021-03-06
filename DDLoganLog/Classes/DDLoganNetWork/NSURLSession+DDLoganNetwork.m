//
//  NSURLSession+DDLoganNetwork.m
//  Unity-iPhone
//
//  Created by DDLi on 2019/7/29.
//

#import "NSObject+DDSwizzlingMethods.h"

#import "NSURLSession+DDLoganNetwork.h"

@implementation NSURLSession (DDLoganNetwork)

+ (void)load {
    [NSObject loganInit];
    [self swizzlingClassMethodWithOriginalSel:@selector(sessionWithConfiguration:delegate:delegateQueue:) swizzledSel:@selector(dd_sessionWithConfiguration:delegate:delegateQueue:)];
    [self swizzlingMethodWithOriginalSel:@selector(dataTaskWithURL:completionHandler:) swizzledSel:@selector(dd_dataTaskWithURL:completionHandler:)];
    [self swizzlingMethodWithOriginalSel:@selector(dataTaskWithRequest:completionHandler:) swizzledSel:@selector(dd_dataTaskWithRequest:completionHandler:)];
    
    [self swizzlingMethodWithOriginalSel:@selector(uploadTaskWithRequest:fromData:completionHandler:) swizzledSel:@selector(dd_uploadTaskWithRequest:fromData:completionHandler:)];
    [self swizzlingMethodWithOriginalSel:@selector(uploadTaskWithRequest:fromFile:completionHandler:) swizzledSel:@selector(dd_uploadTaskWithRequest:fromFile:completionHandler:)];
    
    [self swizzlingMethodWithOriginalSel:@selector(downloadTaskWithURL:completionHandler:) swizzledSel:@selector(dd_downloadTaskWithURL:completionHandler:)];
    [self swizzlingMethodWithOriginalSel:@selector(downloadTaskWithRequest:completionHandler:) swizzledSel:@selector(dd_downloadTaskWithRequest:completionHandler:)];
    [self swizzlingMethodWithOriginalSel:@selector(downloadTaskWithResumeData:completionHandler:) swizzledSel:@selector(dd_downloadTaskWithResumeData:completionHandler:)];
#warning special for AFNetwork or other third-partys that change NSUrlSession's block
    [self swizzlingMethodWithOriginalSel:@selector(dataTaskWithURL:) swizzledSel:@selector(dd_dataTaskWithURL:)];
    [self swizzlingMethodWithOriginalSel:@selector(dataTaskWithRequest:) swizzledSel:@selector(dd_dataTaskWithRequest:)];
    
    [self swizzlingMethodWithOriginalSel:@selector(uploadTaskWithRequest:fromData:) swizzledSel:@selector(dd_uploadTaskWithRequest:fromData:)];
    [self swizzlingMethodWithOriginalSel:@selector(uploadTaskWithRequest:fromFile:) swizzledSel:@selector(dd_uploadTaskWithRequest:fromFile:)];
    
    [self swizzlingMethodWithOriginalSel:@selector(downloadTaskWithURL:) swizzledSel:@selector(dd_downloadTaskWithURL:)];
    [self swizzlingMethodWithOriginalSel:@selector(downloadTaskWithRequest:) swizzledSel:@selector(dd_downloadTaskWithRequest:)];
    [self swizzlingMethodWithOriginalSel:@selector(downloadTaskWithResumeData:) swizzledSel:@selector(dd_downloadTaskWithResumeData:)];
}

+ (NSURLSession *)dd_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue {
    dd_exchangeMethod([delegate class], @selector(URLSession:task:didCompleteWithError:), self, @selector(dd_replace_URLSession:task:didCompleteWithError:), @selector(dd_add_URLSession:task:didCompleteWithError:));
    dd_exchangeMethod([delegate class], @selector(URLSession:dataTask:didReceiveResponse:completionHandler:), self, @selector(dd_replace_URLSession:dataTask:didReceiveResponse:completionHandler:), @selector(dd_add_URLSession:dataTask:didReceiveResponse:completionHandler:));
    dd_exchangeMethod([delegate class], @selector(URLSession:downloadTask:didFinishDownloadingToURL:), self, @selector(dd_replace_URLSession:downloadTask:didFinishDownloadingToURL:), @selector(dd_add_URLSession:downloadTask:didFinishDownloadingToURL:));
    dd_exchangeMethod([delegate class], @selector(URLSession:streamTask:didBecomeInputStream:outputStream:), self, @selector(dd_replace_URLSession:streamTask:didBecomeInputStream:outputStream:), @selector(dd_add_URLSession:streamTask:didBecomeInputStream:outputStream:));
    return [self dd_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
}
#pragma mark - data task init methods
- (NSURLSessionDataTask *)dd_dataTaskWithURL:(NSURL *)url {
    return [self dd_dataTaskWithURL:url completionHandler:nil];
}

- (NSURLSessionDataTask *)dd_dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [url absoluteString];
    model.des = @"NSURLSessionDataTask init";
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
    return [self dd_dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}

- (NSURLSessionDataTask *)dd_dataTaskWithRequest:(NSURLRequest *)request {
    return [self dd_dataTaskWithRequest:request completionHandler:nil];
}

- (NSURLSessionDataTask *)dd_dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [request.URL absoluteString];
    model.des = @"NSURLSessionDataTask init";
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
    return [self dd_dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}
#pragma mark - upload task methods
- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL {
    return [self dd_uploadTaskWithRequest:request fromFile:fileURL completionHandler:nil];
}

- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [request.URL absoluteString];
    model.des = @"NSURLSessionUploadTask init";
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
    return [self dd_uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}

- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData {
    return [self dd_uploadTaskWithRequest:request fromData:bodyData completionHandler:nil];
}

- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [request.URL absoluteString];
    model.des = @"NSURLSessionUploadTask init";
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
    return [self dd_uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}
#pragma mark - download task methods
- (NSURLSessionDownloadTask *)dd_downloadTaskWithRequest:(NSURLRequest *)request {
    return [self dd_downloadTaskWithRequest:request completionHandler:nil];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [request.URL absoluteString];
    model.des = @"NSURLSessionDownloadTask init";
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
    return [self dd_downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
        if (completionHandler) {
            completionHandler(location,response,error);
        }
    }];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithURL:(NSURL *)url {
    return [self dd_downloadTaskWithURL:url completionHandler:nil];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = url.absoluteString;
    model.des = @"NSURLSessionDownloadTask init";
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
    return [self dd_downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
        if (completionHandler) {
            completionHandler(location,response,error);
        }
    }];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithResumeData:(NSData *)resumeData {
    return [self dd_downloadTaskWithResumeData:resumeData completionHandler:nil];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    __block DDLoganLogModel *model = [DDLoganLogModel new];
    model.des = resumeData.description;
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
    return [self dd_downloadTaskWithResumeData:resumeData completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            model.code = [NSString stringWithFormat:@"%ld",error.code];
            model.des = error.description;
            logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
            }
            model.des = response.description;
            logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
        }
        if (completionHandler) {
            completionHandler(location,response,error);
        }
    }];
}
#pragma mark - dd delegate
- (void)dd_add_URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 didCompleteWithError:(nullable NSError *)error {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.code = [NSString stringWithFormat:@"%ld",error.code];
    model.des = error.description;
    logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
}

- (void)dd_replace_URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
     didCompleteWithError:(nullable NSError *)error {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.code = [NSString stringWithFormat:@"%ld",error.code];
    model.des = error.description;
    logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
    [self dd_replace_URLSession:session task:task didCompleteWithError:error];
}

- (void)dd_add_URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
           didReceiveResponse:(NSURLResponse *)response
            completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = response.URL.absoluteString;
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
    }
    model.des = response.description;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
}

- (void)dd_replace_URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = response.URL.absoluteString;
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)response).statusCode];
    }
    model.des = response.description;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
    [self dd_replace_URLSession:session dataTask:dataTask didReceiveResponse:response completionHandler:completionHandler];
}

- (void)dd_add_URLSession:(NSURLSession *)session
         downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = downloadTask.response.URL.absoluteString;
    if ([downloadTask.response isKindOfClass:[NSHTTPURLResponse class]]) {
        model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)downloadTask.response).statusCode];
    }
    model.des = downloadTask.response.description;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
}

- (void)dd_replace_URLSession:(NSURLSession *)session
         downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = downloadTask.response.URL.absoluteString;
    if ([downloadTask.response isKindOfClass:[NSHTTPURLResponse class]]) {
        model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)downloadTask.response).statusCode];
    }
    model.des = downloadTask.response.description;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
    [self dd_replace_URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
}

- (void)dd_add_URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask
 didBecomeInputStream:(NSInputStream *)inputStream
         outputStream:(NSOutputStream *)outputStream {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = streamTask.response.URL.absoluteString;
    if ([streamTask.response isKindOfClass:[NSHTTPURLResponse class]]) {
        model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)streamTask.response).statusCode];
    }
    model.des = streamTask.response.description;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
}

- (void)dd_replace_URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask
didBecomeInputStream:(NSInputStream *)inputStream
      outputStream:(NSOutputStream *)outputStream {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = streamTask.response.URL.absoluteString;
    if ([streamTask.response isKindOfClass:[NSHTTPURLResponse class]]) {
        model.code = [NSString stringWithFormat:@"%ld",((NSHTTPURLResponse *)streamTask.response).statusCode];
    }
    model.des = streamTask.response.description;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
    [self dd_replace_URLSession:session streamTask:streamTask didBecomeInputStream:inputStream outputStream:outputStream];
}

@end

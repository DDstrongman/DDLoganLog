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
    [self swizzlingClassMethodWithOriginalSel:@selector(sessionWithConfiguration:delegate:delegateQueue:) swizzledSel:@selector(dd_sessionWithConfiguration:delegate:delegateQueue:)];
    
//    void(^completionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//    };
    
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
    dd_exchangeMethod([delegate class], @selector(URLSession:task:didCompleteWithError:), self, @selector(dd_URLSession:task:didCompleteWithError:), @selector(dd_URLSession:task:didCompleteWithError:));
    dd_exchangeMethod([delegate class], @selector(URLSession:dataTask:didReceiveResponse:completionHandler:), self, @selector(dd_URLSession:dataTask:didReceiveResponse:completionHandler:), @selector(dd_URLSession:dataTask:didReceiveResponse:completionHandler:));
    dd_exchangeMethod([delegate class], @selector(URLSession:downloadTask:didFinishDownloadingToURL:), self, @selector(dd_URLSession:downloadTask:didFinishDownloadingToURL:), @selector(dd_URLSession:downloadTask:didFinishDownloadingToURL:));
    dd_exchangeMethod([delegate class], @selector(URLSession:streamTask:didBecomeInputStream:outputStream:), self, @selector(dd_URLSession:streamTask:didBecomeInputStream:outputStream:), @selector(dd_URLSession:streamTask:didBecomeInputStream:outputStream:));
    return [self dd_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
}
#pragma mark - data task init methods
- (NSURLSessionDataTask *)dd_dataTaskWithURL:(NSURL *)url {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[url absoluteString]]);
    return [self dd_dataTaskWithURL:url completionHandler:nil];
}

- (NSURLSessionDataTask *)dd_dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[url absoluteString]]);
    return [self dd_dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}

- (NSURLSessionDataTask *)dd_dataTaskWithRequest:(NSURLRequest *)request {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_dataTaskWithRequest:request completionHandler:nil];
}

- (NSURLSessionDataTask *)dd_dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}
#pragma mark - upload task methods
- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_uploadTaskWithRequest:request fromFile:fileURL completionHandler:nil];
}

- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}

- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_uploadTaskWithRequest:request fromData:bodyData completionHandler:nil];
}

- (NSURLSessionUploadTask *)dd_uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(data,response,error);
        }
    }];
}
#pragma mark - download task methods
- (NSURLSessionDownloadTask *)dd_downloadTaskWithRequest:(NSURLRequest *)request {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_downloadTaskWithRequest:request completionHandler:nil];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",[request.URL absoluteString]]);
    return [self dd_downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(location,response,error);
        }
    }];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithURL:(NSURL *)url {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",url.absoluteString]);
    return [self dd_downloadTaskWithURL:url completionHandler:nil];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",url.absoluteString]);
    return [self dd_downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(location,response,error);
        }
    }];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithResumeData:(NSData *)resumeData {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",resumeData]);
    return [self dd_downloadTaskWithResumeData:resumeData completionHandler:nil];
}

- (NSURLSessionDownloadTask *)dd_downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    logan(DDNetLogInit, [NSString stringWithFormat:@"NSURLSession init=%@",resumeData]);
    return [self dd_downloadTaskWithResumeData:resumeData completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
        } else {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
        }
        if (completionHandler) {
            completionHandler(location,response,error);
        }
    }];
}
#pragma mark - dd delegate
- (void)dd_URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 didCompleteWithError:(nullable NSError *)error {
    logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLSession failed=%@",error.description]);
    [self dd_URLSession:session task:task didCompleteWithError:error];
}

- (void)dd_URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",response.description]);
    [self dd_URLSession:session dataTask:dataTask didReceiveResponse:response completionHandler:completionHandler];
}

- (void)dd_URLSession:(NSURLSession *)session
         downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",downloadTask.response.description]);
    [self dd_URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
}

- (void)dd_URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask
didBecomeInputStream:(NSInputStream *)inputStream
      outputStream:(NSOutputStream *)outputStream {
    logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLSession response=%@",streamTask.response.description]);
    [self dd_URLSession:session streamTask:streamTask didBecomeInputStream:inputStream outputStream:outputStream];
}

@end

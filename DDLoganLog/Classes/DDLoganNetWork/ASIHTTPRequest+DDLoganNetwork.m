//
//  ASIHTTPRequest+DDLoganNetwork.m
//  Unity-iPhone
//
//  Created by DDLi on 2019/7/29.
//

#import "NSObject+DDSwizzlingMethods.h"

#import "ASIHTTPRequest+DDLoganNetwork.h"

@implementation ASIHTTPRequest (DDLoganNetwork)

+ (void)load {
    [self swizzlingMethodWithOriginalSel:@selector(initWithURL:)
                             swizzledSel:@selector(dd_initWithURL:)];
    [self swizzlingMethodWithOriginalSel:@selector(startSynchronous)
                             swizzledSel:@selector(dd_startSynchronous)];
    [self swizzlingMethodWithOriginalSel:@selector(start)
                             swizzledSel:@selector(dd_start)];
    [self swizzlingMethodWithOriginalSel:@selector(startAsynchronous)
                             swizzledSel:@selector(dd_startAsynchronous)];
    [self swizzlingMethodWithOriginalSel:@selector(readResponseHeaders)
                             swizzledSel:@selector(dd_readResponseHeaders)];
    [self swizzlingMethodWithOriginalSel:@selector(failWithError:)
                             swizzledSel:@selector(dd_failWithError:)];
}

- (id)dd_initWithURL:(NSURL *)newURL {
    DDLog(@"asi生成网络请求");
    logan(DDNetLogInit, [NSString stringWithFormat:@"%@%@",@"asi initWithURL:",[newURL absoluteString]]);
//    loganFlush();
    return [self dd_initWithURL:newURL];
}

- (void)dd_startSynchronous {
    DDLog(@"asi同步发起网络请求");
    logan(DDNetLogBegin, [NSString stringWithFormat:@"asi start Synchronous=%@,method=%@",[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    return [self dd_startSynchronous];
}

- (void)dd_start {
    DDLog(@"asi发起网络请求");
    logan(DDNetLogBegin, [NSString stringWithFormat:@"asi start=%@,method=%@",[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    return [self dd_start];
}

- (void)dd_startAsynchronous {
    DDLog(@"asi异步发起网络请求");
    logan(DDNetLogBegin, [NSString stringWithFormat:@"asi start Asynchronous=%@,method=%@",[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    return [self dd_startAsynchronous];
}

- (void)dd_readResponseHeaders {
    DDLog(@"asi处理http返回头");
    [self dd_readResponseHeaders];
    logan(DDNetLogSuccess,[NSString stringWithFormat:@"asi response http header code=%d,message=%@,url=%@,method=%@",self.responseStatusCode,self.responseStatusMessage,[self.url absoluteString],self.requestMethod]);
//    loganFlush();
}

- (void)dd_failWithError:(NSError *)theError {
    DDLog(@"asi error");
    logan(DDNetLogFailed,[NSString stringWithFormat:@"asi error=%@,url=%@,method=%@",theError.description,[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    [self dd_failWithError:theError];
}

@end

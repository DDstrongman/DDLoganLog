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
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = newURL.absoluteString;
    model.des = @"asi initWithURL";
    logan(DDNetLogInit, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDNetLogInit, [NSString stringWithFormat:@"%@%@",@"asi initWithURL:",[newURL absoluteString]]);
//    loganFlush();
    return [self dd_initWithURL:newURL];
}

- (void)dd_startSynchronous {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [self.url absoluteString];
    model.des = @"asi start Synchronous";
    model.method = self.requestMethod;
    logan(DDNetLogBegin, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDNetLogBegin, [NSString stringWithFormat:@"asi start Synchronous=%@,method=%@",[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    return [self dd_startSynchronous];
}

- (void)dd_start {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [self.url absoluteString];
    model.des = @"asi start Synchronous";
    model.method = self.requestMethod;
    logan(DDNetLogBegin, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDNetLogBegin, [NSString stringWithFormat:@"asi start=%@,method=%@",[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    return [self dd_start];
}

- (void)dd_startAsynchronous {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [self.url absoluteString];
    model.des = @"asi start Asynchronous";
    model.method = self.requestMethod;
    logan(DDNetLogBegin, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDNetLogBegin, [NSString stringWithFormat:@"asi start Asynchronous=%@,method=%@",[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    return [self dd_startAsynchronous];
}

- (void)dd_readResponseHeaders {
    [self dd_readResponseHeaders];
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [self.url absoluteString];
    model.des = @"asi response";
    model.method = self.requestMethod;
    model.code = self.responseStatusCode;
    model.message = self.responseStatusMessage;
    logan(DDNetLogSuccess, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDNetLogSuccess,[NSString stringWithFormat:@"asi response http header code=%d,message=%@,url=%@,method=%@",self.responseStatusCode,self.responseStatusMessage,[self.url absoluteString],self.requestMethod]);
//    loganFlush();
}

- (void)dd_failWithError:(NSError *)theError {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = [self.url absoluteString];
    model.des = theError.description;
    model.method = self.requestMethod;
    logan(DDNetLogFailed, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDNetLogFailed,[NSString stringWithFormat:@"asi error=%@,url=%@,method=%@",theError.description,[self.url absoluteString],self.requestMethod]);
//    loganFlush();
    [self dd_failWithError:theError];
}

@end

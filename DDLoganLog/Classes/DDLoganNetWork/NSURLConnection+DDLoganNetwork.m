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
    [self swizzlingClassMethodWithOriginalSel:@selector(sendSynchronousRequest:returningResponse:error:)
                                  swizzledSel:@selector(dd_sendSynchronousRequest:returningResponse:error:)];
    [self swizzlingClassMethodWithOriginalSel:@selector(sendAsynchronousRequest:queue:completionHandler:)
                                  swizzledSel:@selector(dd_sendAsynchronousRequest:queue:completionHandler:)];
}
    
+ (nullable NSData *)dd_sendSynchronousRequest:(NSURLRequest *)request
                             returningResponse:(NSURLResponse * _Nullable * _Nullable)response
                                         error:(NSError **)error {
    logan(DDNetLogBegin, @"NSURLConnection sendSynchronous");
    NSData *tempData = [self dd_sendSynchronousRequest:request
                                     returningResponse:response
                                                 error:error];
    if (error) {
        logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLConnection failed=%@",(*error).description]);
    } else {
        if (response) {
            logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLConnection succes=%@",(*response).description]);
        }
    }
    return tempData;
}
    
+ (void)dd_sendAsynchronousRequest:(NSURLRequest*) request
                          queue:(NSOperationQueue*) queue
              completionHandler:(void (^)(NSURLResponse* _Nullable response, NSData* _Nullable data, NSError* _Nullable connectionError)) handler {
    logan(DDNetLogBegin, @"NSURLConnection sendAsynchronous");
    [self dd_sendAsynchronousRequest:request
                               queue:queue
                   completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                       if (connectionError) {
                           logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLConnection failed=%@",connectionError.description]);
                       } else {
                           logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLConnection succes=%@",response.description]);
                       }
                       if (handler) {
                           handler(response,data,connectionError);
                       }
                   }];
}

- (void)dd_connection:(NSURLConnection *)connection
     didFailWithError:(NSError *)error {
    logan(DDNetLogFailed, [NSString stringWithFormat:@"NSURLConnection failed=%@,url=%@,method=%@",error.description,[self.currentRequest.URL absoluteString],self.currentRequest.HTTPMethod]);
    [self dd_connection:connection
       didFailWithError:error];
}

- (void)dd_connection:(NSURLConnection *)connection
   didReceiveResponse:(NSURLResponse *)response {
    logan(DDNetLogSuccess, [NSString stringWithFormat:@"NSURLConnection response=%@,url=%@,method=%@",response.description,[self.currentRequest.URL absoluteString],self.currentRequest.HTTPMethod]);
    [self dd_connection:connection
     didReceiveResponse:response];
}

@end

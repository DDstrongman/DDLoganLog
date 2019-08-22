//
//  SRWebSocket+DDLoganNetwork.m
//  Unity-iPhone
//
//  Created by DDLi on 2019/8/7.
//

#import "SRWebSocket+DDLoganNetwork.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation SRWebSocket (DDLoganNetwork)

+ (void)load {
    [NSObject loganInit];
    NSError *error;
    [self aspect_hookSelector:@selector(initWithURLRequest:protocols:allowsUntrustedSSLCertificates:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,NSURLRequest *request,NSArray *protocols,BOOL allowsUntrustedSSLCertificates) {
        DDLoganLogModel *model = [DDLoganLogModel new];
        model.url = request.URL.absoluteString;
        model.des = @"socket init";
        if (model.url && model.url.length > 0) {
            NSString *httpUUID = [NSString httpUUID];
            [[NSUserDefaults standardUserDefaults] setObject:httpUUID
                                                      forKey:[model.url stringByAppendingString:@"_uuid"]];
            model.httpUUID = httpUUID;
        }
        logan(DDSocketInit, [@"" objectToJson:model.mj_keyValues]);
    } error:&error];
    
//    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
//                             swizzledSel:@selector(set_dd_SRWebSocket_delegate:)];
}

- (void)set_dd_SRWebSocket_delegate:(id <SRWebSocketDelegate>)delegate {
    dd_exchangeMethod([delegate class], @selector(webSocket:didReceiveMessage:),[self class], @selector(dd_replace_webSocket:didReceiveMessage:), @selector(dd_add_webSocket:didReceiveMessage:));
    dd_exchangeMethod([delegate class], @selector(webSocketDidOpen:),[self class], @selector(dd_replace_webSocketDidOpen:), @selector(dd_add_webSocketDidOpen:));
    dd_exchangeMethod([delegate class], @selector(webSocket:didFailWithError:),[self class], @selector(dd_replace_webSocket:didFailWithError:), @selector(dd_add_webSocket:didFailWithError:));
    dd_exchangeMethod([delegate class], @selector(webSocket:didCloseWithCode:reason:wasClean:),[self class], @selector(dd_replace_webSocket:didCloseWithCode:reason:wasClean:), @selector(dd_add_webSocket:didCloseWithCode:reason:wasClean:));
    [self set_dd_SRWebSocket_delegate:delegate];
}
#pragma mark - dd delegates
- (void)dd_add_webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.des = @"socket success";
    model.message = message;
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
        NSString *startTime = [[NSUserDefaults standardUserDefaults]objectForKey:model.url];
        NSString *endTime = [@"" currentTime];
        model.httpTime = [NSString stringWithFormat:@"%ld",[endTime integerValue] - [startTime integerValue]];
    }
    logan(DDSocketSuccess, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketSuccess, [NSString stringWithFormat:@"socket success=%@",message]);
//    loganFlush();
}

- (void)dd_replace_webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.des = @"socket success";
    model.message = message;
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
        NSString *startTime = [[NSUserDefaults standardUserDefaults]objectForKey:model.url];
        NSString *endTime = [@"" currentTime];
        model.httpTime = [NSString stringWithFormat:@"%ld",[endTime integerValue] - [startTime integerValue]];
    }
    logan(DDSocketSuccess, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketSuccess, [NSString stringWithFormat:@"socket success=%@",message]);
//    loganFlush();
    [self dd_replace_webSocket:webSocket didReceiveMessage:message];
}

- (void)dd_add_webSocketDidOpen:(SRWebSocket *)webSocket {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.des = @"socket begin";
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
        [[NSUserDefaults standardUserDefaults] setObject:[@"" currentTime]
                                                  forKey:model.url];
    }
    logan(DDSocketBegin, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketBegin, [NSString stringWithFormat:@"socket begin url=%@",webSocket.url.absoluteString]);
//    loganFlush();
}

- (void)dd_replace_webSocketDidOpen:(SRWebSocket *)webSocket {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.des = @"socket begin";
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
        [[NSUserDefaults standardUserDefaults] setObject:[@"" currentTime]
                                                  forKey:model.url];
    }
    logan(DDSocketBegin, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketBegin, [NSString stringWithFormat:@"socket begin url=%@",webSocket.url.absoluteString]);
//    loganFlush();
    [self dd_replace_webSocketDidOpen:webSocket];
}

- (void)dd_add_webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.des = error.description;
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
    }
    logan(DDSocketFailed, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketFailed, [NSString stringWithFormat:@"socket failed error=%@",error.description]);
//    loganFlush();
}

- (void)dd_replace_webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.des = error.description;
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
    }
    logan(DDSocketFailed, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketFailed, [NSString stringWithFormat:@"socket failed error=%@",error.description]);
//    loganFlush();
    [self dd_replace_webSocket:webSocket didFailWithError:error];
}

- (void)dd_add_webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.code = [NSString stringWithFormat:@"%ld",code];
    model.des = reason;
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
    }
    logan(DDSocketClosed, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketClosed, [NSString stringWithFormat:@"socket closed reason=%@",reason]);
//    loganFlush();
}

- (void)dd_replace_webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.url = webSocket.url.absoluteString;
    model.code = [NSString stringWithFormat:@"%ld",code];
    model.des = reason;
    if (model.url && model.url.length > 0) {
        model.httpUUID = [[NSUserDefaults standardUserDefaults]objectForKey:[model.url stringByAppendingString:@"_uuid"]];
    }
    logan(DDSocketClosed, [@"" objectToJson:model.mj_keyValues]);
//    logan(DDSocketClosed, [NSString stringWithFormat:@"socket closed reason=%@",reason]);
//    loganFlush();
    [self dd_replace_webSocket:webSocket didCloseWithCode:code reason:reason wasClean:wasClean];
}

@end

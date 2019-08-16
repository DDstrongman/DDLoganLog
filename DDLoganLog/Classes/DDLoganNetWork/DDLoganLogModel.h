//
//  DDLoganLogModel.h
//  Unity-iPhone
//
//  Created by DDLi on 2019/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    DDActionEventLogType = 0,
    DDNetLogInit,
    DDNetLogBegin,
    DDNetLogProgress,
    DDNetLogSuccess,
    DDNetLogFailed,
    DDSocketInit,
    DDSocketBegin,
    DDSocketSuccess,
    DDSocketFailed,
    DDSocketClosed,
    DDEventBecomeFirstResponder = 100,
    DDEventResignFirstResponder,
    DDEventScrollviewDidScroll,
    DDEventTableviewDidSelect,
    DDEventCollectionviewDidSelect,
    DDEventControlTargetAction,
    DDEventTouchBegin,
    DDEventTouchEnd,
    DDEventGestureTargetAction,
    DDEventAlertActionClick,
    DDEventViewControllerDidAppear = 1000,
    DDEventViewControllerDidDisappear,
    DDEventApplicationOpenUrl,
    DDEventAlertControllerDidAppear,
    DDEventAlertControllerDidDisappear
}DDLoganLogType;

@interface DDLoganLogModel : NSObject

#pragma mark - 初始必然存在的string
@property (nonatomic, strong) NSString *uuid;///< 设备uuid
@property (nonatomic, strong) NSString *gkid_no;///< 用户账户id

#pragma mark - http
@property (nonatomic, strong) NSString *url;///< 请求url
@property (nonatomic, strong) NSString *des;///< 此实例详细描述
@property (nonatomic, strong) NSString *code;///< 分类code
@property (nonatomic, strong) NSString *method;///< 请求方法类型
@property (nonatomic, strong) NSString *message;///< 返回的信息
@property (nonatomic, strong) NSString *httpTime;///< http请求从发起到完成的时间，仅统计完成的请求时间
@property (nonatomic, strong) NSString *httpUUID;///< http请求从生成、发起到完成的唯一对应uuid

@end

NS_ASSUME_NONNULL_END

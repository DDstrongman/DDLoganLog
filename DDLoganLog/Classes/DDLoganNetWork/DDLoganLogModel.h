//
//  DDLoganLogModel.h
//  Unity-iPhone
//
//  Created by DDLi on 2019/8/12.
//

#import <Foundation/Foundation.h>

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

NS_ASSUME_NONNULL_BEGIN

@interface DDLoganLogModel : NSObject

#pragma mark - network log
@property (nonatomic, strong) NSString *url;///< 请求url
@property (nonatomic, strong) NSString *des;///< 此实例详细描述
@property (nonatomic, assign) NSInteger code;///< 分类code
@property (nonatomic, strong) NSString *method;///< 请求方法类型
@property (nonatomic, strong) NSString *message;///< 返回的信息
#pragma mark - ui event log

@end

NS_ASSUME_NONNULL_END

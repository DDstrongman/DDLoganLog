//
//  NSObject+DDSwizzlingMethods.h
//  Unity-iPhone
//
//  Created by DDLi on 2019/7/29.
//

#import <Foundation/Foundation.h>

#import <Logan/Logan.h>
#import <Aspects/Aspects.h>

#import <objc/runtime.h>

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

static void inline dd_exchangeMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL addReplaceSel){
    // 原方法
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    // 替换方法
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    // 如果类没有实现方法，则手动动态添加
    if (!originalMethod) {
        Method orginReplaceMethod = class_getInstanceMethod(replacedClass, addReplaceSel);
        BOOL didAddOriginMethod = class_addMethod(originalClass, originalSel, method_getImplementation(orginReplaceMethod), method_getTypeEncoding(orginReplaceMethod));
        if (didAddOriginMethod) {
//            DDLog(@"===================did Add Origin Replace Method=%@===================",NSStringFromClass(originalClass));
        }
        return;
    }
    // 向实现类中添加新的方法
    // 这里是向 originalClass 的 replaceSel（@selector(replace_webViewDidFinishLoad:)） 添加 replaceMethod
    BOOL didAddMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (didAddMethod) {
        // 添加成功
//        DDLog(@"===================class_addMethod_success --> (%@)class=%@===================", NSStringFromSelector(replacedSel),NSStringFromClass(originalClass));
        // 重新拿到添加被添加的 method,这里是关键(注意这里 originalClass, 不是replacedClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    } else {
//        IMP classOriIMP = method_getImplementation(class_getInstanceMethod(originalClass, originalSel));
//        IMP classReplaceIMP = method_getImplementation(class_getInstanceMethod(originalClass, replacedSel));
//        if (classOriIMP != classReplaceIMP) {
//            Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
//            // 实现交换
//            method_exchangeImplementations(originalMethod, newMethod);
//        }
        // 添加失败，则说明已经 hook 过该类的方法，防止多次交换。
        
//        DDLog(@"===================Already hook class --> (%@)===================",NSStringFromClass(originalClass));
    }
}

@interface NSObject (DDSwizzlingMethods)
/**
 实例方法的方法替换

 @param originalSel 原实例方法sel
 @param swizzledSel 替换的实例方法sel
 */
+ (void)swizzlingMethodWithOriginalSel:(SEL)originalSel
                           swizzledSel:(SEL)swizzledSel;
/**
 类方法的方法替换

 @param originalSel 原类方法sel
 @param swizzledSel 替换的类方法sel
 */
+ (void)swizzlingClassMethodWithOriginalSel:(SEL)originalSel
                                swizzledSel:(SEL)swizzledSel;

/**
 上传本地所有日志目录

 @param uploadBlock 上传日志block,此处调用http上传即可，filePath会遍历返回所有文件路径,最好用nsurlsession异步上传
 */
+ (void)uploadLogan:(void(^)(NSString *filePath))uploadBlock;

/**
 上传成功则可以选择删除本地日志

 @param filePath 日志路径
 */
+ (void)deleteLoganFile:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END

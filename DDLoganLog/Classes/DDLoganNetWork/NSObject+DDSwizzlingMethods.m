//
//  NSObject+DDSwizzlingMethods.m
//  Unity-iPhone
//
//  Created by DDLi on 2019/7/29.
//

#import "NSObject+DDSwizzlingMethods.h"

@implementation NSObject (DDSwizzlingMethods) 

+ (void)load {
    NSData *keydata = [@"3211231231321312" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivdata = [@"1232132132131231" dataUsingEncoding:NSUTF8StringEncoding];
    uint64_t file_max = 100 * 1024 * 1024;
    // logan init，incoming 16-bit key，16-bit iv，largest written to the file size(byte)
    loganInit(keydata, ivdata, file_max);
    loganSetMaxReversedDate(14);
#if DEBUG
    loganUseASL(YES);
#endif
//        DDWS(weakSelf)
//        [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            DDSS(strongSelf)
//            [strongSelf uploadLogan];
//        }];
}

+ (void)swizzlingMethodWithOriginalSel:(SEL)originalSel
                           swizzledSel:(SEL)swizzledSel {
//    DDLog(@"交换实例方法");
    Class class = [self class];
    
    SEL originalSelector = originalSel;
    SEL swizzledSelector = swizzledSel;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)swizzlingClassMethodWithOriginalSel:(SEL)originalSel
                                swizzledSel:(SEL)swizzledSel {
//    DDLog(@"交换类方法");
    Class class = [self class];
    
    SEL originalSelector = originalSel;
    SEL swizzledSelector = swizzledSel;
    
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)uploadLogan:(void(^)(NSString *filePath))uploadBlock {
    loganFlush();
    NSDictionary <NSString *,NSString *> *map = loganAllFilesInfo();
    [map enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        loganUploadFilePath(key, ^(NSString * _Nullable filePath) {
            if (uploadBlock) {
                uploadBlock(filePath);
            }
        });
    }];
    
    NSLog(@"uploadLogan=====%@",map);
}
#pragma mark - support methods
+ (void)deleteLoganFile:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

+ (NSString *)loganLogDirectory {
    static NSString *dir = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dir = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"LoganLoggerv3"];
    });
    return dir;
}



@end

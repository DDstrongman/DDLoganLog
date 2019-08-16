//
//  UIAlertAction+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/2.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UIAlertAction+DDLoganEventLog.h"
#import "NSObject+DDSwizzlingMethods.h"

@implementation UIAlertAction (DDLoganEventLog)

+ (void)load {
    [self swizzlingClassMethodWithOriginalSel:@selector(actionWithTitle:style:handler:)
                                  swizzledSel:@selector(dd_actionWithTitle:style:handler:)];
}

+ (instancetype)dd_actionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler {
    return [self dd_actionWithTitle:title
                              style:style
                            handler:^(UIAlertAction *action) {
                                DDLoganLogModel *model = [DDLoganLogModel new];
                                model.className = NSStringFromClass([self class]);
                                model.alertActionTitle = title;
                                model.alertActionStyle = [NSString stringWithFormat:@"alertAction Style=%ld",style];
                                model.des = @"eventAlertActionClick";
                                logan(DDEventAlertActionClick, [@"" objectToJson:model.mj_keyValues]);
                                if (handler) {
                                    handler(action);
                                }
                            }];
}

@end

//
//  NSString+DDLoganNetwork.h
//  Unity-iPhone
//
//  Created by DDLi on 2019/8/12.
//

#import <Foundation/Foundation.h>
#import <DDDeviceInfo/DDDeviceInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DDLoganNetwork)

/**
 将数组或者字典转为json
 
 @param object 转化的对象，数组或字典。
 @return 返回json字符串
 */
- (NSString *)objectToJson:(id)object;
- (NSString *)currentTime;///< since1970的毫秒数
- (NSString *)deviceUUID;///< 设备的uuid

+ (NSString *)httpUUID;///< 获取唯一id
+ (NSString *)loganLogDirectory;///< logan日志路径

@end

NS_ASSUME_NONNULL_END

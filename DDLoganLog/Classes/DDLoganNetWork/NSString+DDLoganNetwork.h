//
//  NSString+DDLoganNetwork.h
//  Unity-iPhone
//
//  Created by DDLi on 2019/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DDLoganNetwork)

/**
 将数组或者字典转为json
 
 @param object 转化的对象，数组或字典。
 @return 返回json字符串
 */
- (NSString *)objectToJson:(id)object;

@end

NS_ASSUME_NONNULL_END

//
//  NSString+DDLoganNetwork.m
//  Unity-iPhone
//
//  Created by DDLi on 2019/8/12.
//

#import "NSString+DDLoganNetwork.h"

@implementation NSString (DDLoganNetwork)

- (NSString *)objectToJson:(id)object {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

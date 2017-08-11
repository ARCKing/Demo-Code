//
//  HiTVNetParams.m
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/9.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import "HiTVNetParams.h"

@implementation HiTVNetParams

- (instancetype)initWithBaseURLString:(NSString *)baseURLString
{
    self = [super init];
    if (self) {
        _baseURLString = [baseURLString copy];
    }
    return self;
}

- (NSDictionary *)urlParameters
{
    return [self mj_keyValuesWithIgnoredKeys:@[@"baseURLString"]];
}

- (NSDictionary *)postParameters
{
    return nil;
}

- (NSError *)validate
{
    return nil;
}

- (NSString *)url
{
    return [NSString urlString:[_baseURLString copy] addParams:[self urlParameters]];
}

@end


@implementation NSString (HiTVURLEncode)

/**
 *  将URL地址和需要拼接的参数传入，获取到处理后的地址
 *
 *  @param url    基础url地址
 *  @param params 需要拼接的参数
 *
 *  @return 处理后的URL地址
 */
+ (NSString *)urlString:(NSString *)url addParams:(NSDictionary *)params
{
    NSArray *allKeys = [params allKeys];
    for (int i = 0; i < allKeys.count; i++) {
        NSString *key = allKeys[i];
        NSString *flag = (i == 0) ? @"?" : @"&";
        id value = params[key];
        url = [url stringByAppendingFormat:@"%@%@=%@", flag, key, value];
    }
    return [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end

//
//  HiTVNetParams.h
//  HiTVNetwork
//
//  Created by Ningmeng on 16/9/9.
//  Copyright © 2016年 Ningmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MJExtension/MJExtension.h>

@interface HiTVNetParams : NSObject

/**
 基础地址
 */
@property (copy, readonly, nonatomic) NSString *baseURLString;

/*
 例如：要请求的地址为：http://hitv.lxsky.com/Home/HiTVV2/get_splash_info?device_type=iphone&app_version=1.0
 则基础地址即为问号之前的内容，即http://hitv.lxsky.com/Home/HiTVV2/get_splash_info，问号后面的内容则通过添加属性来实现
 */

/**
 *  传入基础地址来初始化
 *
 *  @param baseURLString 基础地址
 *
 *  @return 实例
 */
- (instancetype)initWithBaseURLString:(NSString *)baseURLString;

/**
 *  网络请求时url地址中需要拼接的参数，子类可重载具体实现
 *
 *  @return 参数字典
 */
- (NSDictionary *)urlParameters;

/**
 *  网络请求时上传的参数，子类可重载具体实现
 *
 *  @return 参数字典
 */
- (NSDictionary *)postParameters;

/**
 *  验证参数的有效性，参数不符合时返回对应错误，默认为nil，子类可重载具体实现
 *
 *  @return 错误信息
 */
- (NSError *)validate;

/**
 *  网络请求的地址，子类可按需重载具体实现
 *
 *  @return url地址
 */
- (NSString *)url;

@end


@interface NSString (HiTVURLEncode)

/**
 *  将URL地址和需要拼接的参数传入，获取到处理后的地址
 *
 *  @param url    基础url地址
 *  @param params 需要拼接的参数
 *
 *  @return 处理后的URL地址
 */
+ (NSString *)urlString:(NSString *)url addParams:(NSDictionary *)params;

@end

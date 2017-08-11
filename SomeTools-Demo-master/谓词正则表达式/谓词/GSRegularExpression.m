//
//  GSRegularExpression.m
//  谓词
//
//  Created by Apple on 16/8/8.
//  Copyright © 2016年 张国森. All rights reserved.
//

#import "GSRegularExpression.h"

@implementation GSRegularExpression

/*!
 *  是否为电话号码【简单写法】
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+(BOOL)GS_isPhoneNumber:(NSString *)phoneNum
{
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phoneNum];
}

/*!
 *  是否为电话号码【复杂写法】
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
//    
//    //验证方法2
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//    
//    /**
//     * 中国移动：China Mobile
//     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     */
//    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"; // China Mobile phoneNum
//    
//    /**
//     * 中国联通：China Unicom
//     * 130,131,132,152,155,156,185,186
//     */
//    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$"; // China Unicom phoneNum
//    
//    
//    /**
//     * 中国电信：China Telecom
//     * 133,1349,153,180,189
//     */
//    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$"; // China Telecom phoneNum
//    
//    /**
//     *  The following 4 predicate can tell which carrier the number is from.
//     */
//    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    
//    //Only Check if the string is a valid telephone number, ignoring the carrier info.
//    
//    NSString *isMobileRegex = @"^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0,5-9]{1}))+\\d{8})$";
//    
//    
//    //    NSString *isMobileRegex = @"^((\\+86)|(\\(\\+86\\)))?(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0,5-9]{1}))+\\d{8})$";
//    
//    
//    NSPredicate *mobileRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isMobileRegex];
//    
//    if (([mobileRegex evaluateWithObject:telephoneNum] == YES))
//    {
//        return YES;
//        
//    }else{
//        return NO;
//    }
//    

}

/*!
 *  判断是否是：移动手机号
 *
 *  @param phoneNum 手机号码
 *
 *  @return 移动手机号
 */
+ (BOOL)GS_isChinaMobile:(NSString *)phoneNum
{
    /*!
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [regextestcm evaluateWithObject:phoneNum];
}

/*!
 *  判断是否是：联通手机号
 *
 *  @param phoneNum 手机号码
 *
 *  @return 联通手机号
 */
+ (BOOL)GS_isChinaUnicom:(NSString *)phoneNum
{
    /*!
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    return [regextestcm evaluateWithObject:phoneNum];
}

/*!
 *  判断是否是：电信手机号
 *
 *  @param phoneNum 手机号码
 *
 *  @return 电信手机号
 */
+ (BOOL)GS_isChinaTelecom:(NSString *)phoneNum
{
    /*!
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    return [regextestcm evaluateWithObject:phoneNum];
}

/*!
 *  判断具体是哪个运营商的手机号
 *
 *  @param phoneNum 传入需要检测的字符串
 *
 *  @return 返回：中国移动、中国联通、中国电信、未知
 */
+ (NSString *)GS_getPhoneNumType:(NSString *)phoneNum
{
    return [GSRegularExpression GS_isChinaMobile:phoneNum]? @"中国移动": ([GSRegularExpression GS_isChinaUnicom:phoneNum]? @"中国联通":([GSRegularExpression GS_isChinaTelecom:phoneNum]? @"中国电信": @"未知号码"));
}

/*!
 *  检测是否为邮箱
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isEmailQualified:(NSString *)emailStr
{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:emailStr options:0 range:NSMakeRange(0, emailStr.length)];
    return results.count > 0;
}

/*!
 *  检测用户输入密码是否以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 *
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isPasswordQualified:(NSString *)passwordStr
{
    //    NSString *pattern = @"^[a-zA-Z]\\w.{5,17}$";
    //    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    //    NSArray *results = [regex matchesInString:passwordStr options:0 range:NSMakeRange(0, passwordStr.length)];
    //    return results.count > 0;
    
    NSString *passWordRegex = @"^[a-zA-Z]\\w.{5,17}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passwordStr];
}

/*!
 *  验证身份证号（15位或18位数字）【最全的身份证校验，带校验位】
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isIdCardNumberQualified:(NSString *)idCardNumberStr
{
    //    NSString *pattern = @"^\\d{15}|\\d{18}$";
    //    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    //    NSArray *results = [regex matchesInString:idCardNumberStr options:0 range:NSMakeRange(0, idCardNumberStr.length)];
    //    return results.count > 0;
    
    idCardNumberStr = [idCardNumberStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!idCardNumberStr)
    {
        return NO;
    }
    else
    {
        length = idCardNumberStr.length;
        if (length != 15 && length !=18)
        {
            return NO;
        }
    }
    /*! 省份代码 */
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [idCardNumberStr substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray)
    {
        if ([areaCode isEqualToString:valueStart2])
        {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag)
    {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    NSInteger year = 0;
    switch (length)
    {
        case 15:
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        case 18:
            
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                NSInteger S = ([idCardNumberStr substringWithRange:NSMakeRange(0,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([idCardNumberStr substringWithRange:NSMakeRange(1,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([idCardNumberStr substringWithRange:NSMakeRange(2,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([idCardNumberStr substringWithRange:NSMakeRange(3,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([idCardNumberStr substringWithRange:NSMakeRange(4,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([idCardNumberStr substringWithRange:NSMakeRange(5,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([idCardNumberStr substringWithRange:NSMakeRange(6,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(16,1)].intValue) *2 + [idCardNumberStr substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumberStr substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCardNumberStr substringWithRange:NSMakeRange(9,1)].intValue *3;
                NSInteger Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                /*! 判断校验位 */
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                if ([M isEqualToString:[idCardNumberStr substringWithRange:NSMakeRange(17,1)]])
                {
                    /*! 检测ID的校验位 */
                    return YES;
                }
                else
                {
                    return NO;
                }
                
            }
            else
            {
                return NO;
            }
            break;
        default:
            return NO;
            break;
    }
}

/*!
 *  验证IP地址（15位或18位数字）
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isIPAddress:(NSString *)iPAddressStr
{
    
    NSString *pattern = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:iPAddressStr options:0 range:NSMakeRange(0, iPAddressStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否全为数字
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isAllNumber:(NSString *)allNumberStr
{
    NSString *pattern = @"^[0-9]*$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:allNumberStr options:0 range:NSMakeRange(0, allNumberStr.length)];
    return results.count > 0;
}

/*!
 *  验证由26个英文字母组成的字符串
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isEnglishAlphabet:(NSString *)englishAlphabetStr
{
    NSString *pattern = @"^[A-Za-z]+$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:englishAlphabetStr options:0 range:NSMakeRange(0, englishAlphabetStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否是URL地址
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isUrl:(NSString *)urlStr
{
    //    NSString* verifyRules=@"^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    //    NSPredicate *verifyRulesPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyRules];
    //    return [verifyRulesPre evaluateWithObject:urlStr];
    
    NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:urlStr options:0 range:NSMakeRange(0, urlStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否是中文
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isChinese:(NSString *)chineseStr
{
    NSString *pattern = @"[\u4e00-\u9fa5]+";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:chineseStr options:0 range:NSMakeRange(0, chineseStr.length)];
    return results.count > 0;
}

/*!
 *  验证输入的是否是高亮显示
 *  @param pattern 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isNormalText:(NSString *)normalStr WithHighLightText:(NSString *)HighLightStr
{
    NSString *pattern = [NSString stringWithFormat:@"%@",HighLightStr];
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:normalStr options:0 range:NSMakeRange(0, normalStr.length)];
    for (NSTextCheckingResult *resltText in results) {
        NSLog(@"----------------%zd",resltText.range.length);
    }
    return results.count > 0;
}

/*!
 *  是否为常用用户名（根据自己需求改）
 *
 *  @param userNameStr userNameStr
 *
 *  @return 返回检测结果 是或者不是（6-20位数字+字母组合）
 */
+ (BOOL)GS_isUserNameInGeneral:(NSString *)userNameStr
{
    NSString* verifyRules = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *verifyRulesPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verifyRules];
    return [verifyRulesPre evaluateWithObject:userNameStr];
}

/*!
 *  车牌号验证
 *
 *  @param carNumber carNumber
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isValidateCarNumber:(NSString *)carNumber
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *catTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carRegex];
    return [catTest evaluateWithObject:carNumber];
}

/*!
 *  车型验证
 *
 *  @param CarType CarType
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isValidateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

/*!
 *  昵称验证
 *
 *  @param nickname nickname
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)GS_isValidateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}



@end

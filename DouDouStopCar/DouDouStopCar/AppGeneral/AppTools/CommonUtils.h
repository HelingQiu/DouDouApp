//
//  CommonUtils.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/9.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CompletionWithObjectBlock) (BOOL finish, id obj);

@interface CommonUtils : NSObject

+ (void)setExtraCellLineHidden:(UITableView *)tableView;

+ (void)deselectTableViewCell:(UITableView *)tableView;

+ (BOOL)isBlankString:(NSString *)string;

+ (BOOL)isContainsQuote:(NSString *)string;

+ (BOOL)validateEmail:(NSString *)candidate;

+ (void)storageDataWithObject:(id)obj Key:(NSString *)key Completion:(CompletionWithObjectBlock)completion;

+ (void)getDataWithKey:(NSString *)key Completion:(CompletionWithObjectBlock)completion;

+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGRect)size;

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;

+ (NSDateFormatter*)getDateFormatWithStyle:(NSString *)style;
/*
 获取字符串的宽度
 */
+ (float)widthForString:(NSString *)value Font:(UIFont *)font andWidth:(float)width;
+ (float)heightForString:(NSString *)value Font:(UIFont *)font andWidth:(float)width;

+ (CGRect)stringWithFont:(UIFont *)font withWidth:(CGFloat)width withContent:(NSString *)string;

+ (NSString *)copyDataBaseWithFileFullName:(NSString *)name CustomerDir:(NSString *)dir Override:(BOOL)ovrid;

// Show information message at window
+ (void)showHUDWithMessage:(NSString*)message autoHide:(BOOL)needAutoHide;

+ (void)changeHUDMessage:(NSString*)message;

+ (void)hideHUD;

+ (void)showHUDWithWaitingMessage:(NSString *)message;

// Check if the input text contains non-English character
+ (BOOL)isEnglishCharacterOnly:(NSString*)input;

// Capture the current screenshot
+ (UIImage*)captureScreen;

/**
 *  Description:flatten html tag and blank
 *
 *  @param  str  string by your self
 *  @param  trim flatten blank string
 *
 *  @return string after flatten
 */
+ (NSString *)flattenHTML:(NSString *)str trimBlank:(BOOL)trim;

/**
 *  Description: Append more arguments(尚未使用阶段，应修订)
 *
 *  @param  firstObjects first object
 *
 *  @return append result
 */
+ (NSString *)appendMoreArguments:(NSString *)firstObjects,...NS_REQUIRES_NIL_TERMINATION;
/**
 *  Description:去除地址中括号里的内容
 */
+ (NSString *)flattenAddress:(NSString *)address;

/**
 *  Description: Generator separator view
 *
 *  @param color separator background color
 *  @param frame separator frame
 *
 *  @return separator view
 */
+ (UIView *)getSeparator:(UIColor *)color frame:(CGRect)frame;

/**
 *  Description: Validate mobile phone number
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  Description: Validate digitnumber with length
 */
+ (BOOL)isDigitNumber:(NSString *)string Length:(NSInteger)length;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;
//
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  验证身份证位数
 */
+ (BOOL)easyVerifyIDCardNumber:(NSString *)value;

+ (BOOL)verifyIDCardNumber:(NSString *)value;

+ (NSString *)getDigitsOnly:(NSString*)string;

+ (BOOL)isValidBankCardNumber:(NSString *)cardNumber;

+ (NSString *)getTypeWithString:(id)data;

+ (NSUInteger)numberOfMatchesInString:(NSString *)string RegexString:(NSString *)regexString;

+ (NSString * ) jsonStringWithDictionary:(NSDictionary *) dic;

+ (void)circleFilledWithOutline:(UIView *)circleView fillColor:(UIColor *)fillColor outlineColor:(UIColor*)outlinecolor;

+ (NSString *)encryptionString:(NSString *)string;

+ (NSString *)encryptionStringByIndex:(int)length;

+ (NSString *)stringByReversed:(NSString *)str;

+ (NSString *)changeFloat:(NSString *)stringFloat;

+ (instancetype)getClassObjectFormNib:(NSString *)nibString;

+ (NSString *)timeDateFormatter:(NSDate *)date type:(int)type;

+ (NSString *)deviceString;

+ (NSDictionary *)parseResponseStringToJson:(NSString *)response;

+ (UIButton *)generateCommonButtonWithFrame:(CGRect)frame andColor:(UIColor *)color;

@end

//
//  CommonUtils.m
//  DouDouStopCar
//
//  Created by Rainer on 17/2/9.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#import "CommonUtils.h"
#import "sys/utsname.h"
#import "MBProgressHUD.h"

@implementation CommonUtils

+ (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (void)deselectTableViewCell:(UITableView *)tableView
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark string is blank
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"] ) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isContainsQuote:(NSString *)string
{
    if ([string rangeOfString:@"'"].location != NSNotFound)
        return YES;
    if ([string rangeOfString:@"‘"].location != NSNotFound)
        return YES;
    if ([string rangeOfString:@"’"].location != NSNotFound)
        return YES;
    if ([string rangeOfString:@"”"].location != NSNotFound)
        return YES;
    if ([string rangeOfString:@"“"].location != NSNotFound)
        return YES;
    if ([string rangeOfString:@"\""].location != NSNotFound)
        return YES;
    return NO;
}

#pragma mark -
#pragma mark validate email address
+ (BOOL)validateEmail: (NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (void)storageDataWithObject:(id)obj Key:(NSString *)key Completion:(CompletionWithObjectBlock)completion
{
    
    if (obj) {
        
        [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        completion(YES,obj);
        
    }
    
}

+ (void)getDataWithKey:(NSString *)key Completion:(CompletionWithObjectBlock)completion
{
    
    id data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    completion(YES,data);
    
}

+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGRect)size
{
    CGRect rect = size;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSDateFormatter*)getDateFormatWithStyle:(NSString *)style
{
    static NSDateFormatter *format;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        format = [[NSDateFormatter alloc]init];
        if (style)
            format.dateFormat = style;
        else
            format.dateFormat = @"yyyy-MM-dd";
    });
    
    if ([format dateFormat] != style) {
        
        format.dateFormat = style;
        
    }
    return format;
}
/*
 获取字符串的宽度
 */
+ (float)widthForString:(NSString *)value Font:(UIFont *)font andWidth:(float)width
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return retSize.width;
}
/**
 *  獲取制定情況下的字符串的高度
 *
 *  @param value    待計算的字符串
 *  @param font     字體
 *  @param width    字符串顯示區域的寬度
 *
 *  @return 返回的高度
 */
+ (float)heightForString:(NSString *)value Font:(UIFont *)font andWidth:(float)width
{
    
    //    if (mIsIOS7OrLater) {
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return retSize.height;
    
    //    }
    //    // For ios 6
    //    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    //    return sizeToFit.height;
    
}

+ (CGRect)stringWithFont:(UIFont *)font withWidth:(CGFloat)width withContent:(NSString *)string
{
    if (![CommonUtils isBlankString:string]) {
        NSDictionary * bodyDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        
        NSAttributedString *attrString =[[NSAttributedString alloc] initWithString:string attributes:bodyDic];
        CGRect rect = [attrString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        return rect;
    }
    return CGRectZero;
}

/**
 *  @brief  Copy sqlite file
 *
 *  @param path Copy to destination location
 *
 *  @return Copy result
 *
 *  @since 1.0.0
 */
+ (NSString *)copyDataBaseWithFileFullName:(NSString *)name CustomerDir:(NSString *)dir Override:(BOOL)ovrid
{
    
    BOOL success;
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath;
    if (dir && ![self isBlankString:dir]) {
        
        NSString *subDir = [NSString stringWithFormat:@"%@/%@", documentsDirectory, dir];
        BOOL isDir = NO;
        BOOL existed = [fm fileExistsAtPath:subDir isDirectory:&isDir];
        if (!(isDir == YES && existed == YES)) {
            [fm createDirectoryAtPath:subDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        writableDBPath = [[documentsDirectory stringByAppendingPathComponent:dir] stringByAppendingPathComponent:name];
        
    } else
        writableDBPath = [documentsDirectory stringByAppendingPathComponent:name];
    
    //    NSLog(@"writableDBPath:%@",writableDBPath);
    
    success = [fm fileExistsAtPath:writableDBPath];
    
    if (ovrid && success) {
        
        NSError *error;
        if ([fm removeItemAtPath:writableDBPath error:&error])
            NSLog(@"Ovrride database file success");
        
    }
    
    if (ovrid || !success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
        success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSLog(@"copy database file error:%@",[error localizedDescription]);
            success = NO;
        }
        
    }
    
    
    if (success) {
        
        return writableDBPath;
        
    }
    
    return nil;
    
}

+ (void)showHUDWithMessage:(NSString*)message autoHide:(BOOL)needAutoHide {
    [self hideHUD];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.layer.zPosition = 9999;
    hud.margin = 16.f;
    //    hud.yOffset = mScreenHeight / 2 - 40;
    hud.removeFromSuperViewOnHide = YES;
    
    if (needAutoHide)
        [hud hide:YES afterDelay:1.3];
}

+ (void)changeHUDMessage:(NSString*)message {
    
    [self hideHUD];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.layer.zPosition = 9999;
    hud.margin = 16.f;
    //    hud.yOffset = mScreenHeight / 2 - 40;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.3];
}

+ (void)hideHUD {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}

+ (void)showHUDWithWaitingMessage:(NSString *)message {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    if (![self isBlankString:message]) {
        hud.detailsLabelText = message;
    }
    hud.layer.zPosition = 9999;
    hud.margin = 16.f;
    //    hud.yOffset = mScreenHeight / 2 - 40;
    hud.removeFromSuperViewOnHide = YES;
    
}

+ (BOOL)isEnglishCharacterOnly:(NSString*)input {
    //    NSString *nameRegex = @"[a-zA-Z0-9~@#\\^\\$&\\*\\(\\)-_\\+=\\[\\]\\{\\}\\|\\\\,\\.\\?\\s]+";
    NSString *nameRegex = @"[\x20-\x7E]*";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    
    return [nameTest evaluateWithObject:input];
}

+ (UIImage*)captureScreen {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(window.bounds.size);
    
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

+ (NSString *)flattenHTML:(NSString *)str trimBlank:(BOOL)trim{
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:str];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (trim)
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([self isBlankString:[str substringToIndex:1]]) {
        
        str = [str substringFromIndex:1];
        
    }
    
    return str;
    
}

+ (NSString *)appendMoreArguments:(NSString *)firstObjects, ...
{
    
    NSString *earchObj;
    va_list args;
    
    NSMutableString *appendResult = [[NSMutableString alloc] initWithCapacity:10];
    
    if (firstObjects) {
        
        [appendResult appendString:firstObjects];
        
        va_start(args, firstObjects);
        
        while ((earchObj = va_arg(args, id))) {
            [appendResult appendFormat:@" %@",earchObj];
        }
        
        va_end(args);
        
    }
    
    return [NSString stringWithString:appendResult];
    
}

+ (NSString *)flattenAddress:(NSString *)address
{
    NSRange range = [address rangeOfString:@"（"];
    if (range.location != NSNotFound) {
        address = [address substringToIndex:range.location];
    }
    
    return address;
}

+ (UIView *)getSeparator:(UIColor *)color frame:(CGRect)frame
{
    
    UIView *separatorView = [[UIView alloc] initWithFrame:frame];
    [separatorView setBackgroundColor:color];
    return separatorView;
    
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *mobile = @"^1([3-9][0-9])\\d{8}$";
    NSPredicate * regexNoMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobile];
    
    if ([regexNoMobile evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isDigitNumber:(NSString *)string Length:(NSInteger)length
{
    
    NSString *regex = @"^[0-9]*$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [predicate evaluateWithObject:string];
    
    if (result && string.length == length)
        return YES;
    
    return NO;
    
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//验证身份证
//必须满足以下规则
//1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
//2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
//3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
//4. 第17位表示性别，双数表示女，单数表示男
//5. 第18位为前17位的校验位
//算法如下：
//（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
//（2）余数 ＝ 校验和 % 11
//（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
//6. 出生年份的前两位必须是19或20
+ (BOOL)easyVerifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!(([value length] == 18) || ([value length] == 15))) {
        return NO;
    }
    NSString *regex = [NSString stringWithFormat:@"^(\\d{18,18}|\\d{15,15}|\\d{17,17}x)"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regexTest evaluateWithObject:value];
    
}

+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

//得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证
+ (NSString *)getIDCardBirthday:(NSString *)card {
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([card length] != 18) {
        return nil;
    }
    NSString *birthady = [NSString stringWithFormat:@"%@年%@月%@日",[card substringWithRange:NSMakeRange(6,4)], [card substringWithRange:NSMakeRange(10,2)], [card substringWithRange:NSMakeRange(12,2)]];
    return birthady;
}

//得到身份证的性别（1男0女）****这个方法中不做身份证校验，请确保传入的是正确身份证
+ (NSInteger)getIDCardSex:(NSString *)card {
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger defaultValue = 0;
    if ([card length] != 18) {
        return defaultValue;
    }
    NSInteger number = [[card substringWithRange:NSMakeRange(16,1)] integerValue];
    if (number % 2 == 0) {  //偶数为女
        return 0;
    } else {
        return 1;
    }
}

+ (NSString *)getTypeWithString:(id)data {
    
    NSNumber *number = (NSNumber *)data;
    
    int minThreshold = [number intValue];
    NSString *type = @"Unknow";
    if ((int)minThreshold < 1 )
        type = @"Unknow";
    else{
        
        if (strcmp([number objCType], @encode(BOOL)) == 0)
            type = @"BOOL";
        else if (strcmp([number objCType], @encode(int)) == 0) type = @"int";
        else if (strcmp([number objCType], @encode(float)) == 0)
            type = @"float";
        else if (strcmp([number objCType], @encode(double)) == 0)
            type = @"double";
    }
    
    return type;
    
}

// 剔除卡号里的非法字符
+ (NSString *)getDigitsOnly:(NSString*)string {
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < string.length; i++)
    {
        c = [string characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}

// 检查银行卡是否合法 － Luhn算法
+ (BOOL)isValidBankCardNumber:(NSString *)cardNumber {
    NSString *digitsOnly = [self getDigitsOnly:cardNumber];
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (int i = (int)digitsOnly.length - 1; i >= 0; i--) {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

+ (NSUInteger)numberOfMatchesInString:(NSString *)string RegexString:(NSString *)regexString
{
    
    if ([self isBlankString:string])
        return 0;
    else {
        
        NSArray *array = [string componentsSeparatedByString:regexString];
        return [array count] - 1;
        
    }
    
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *) dic
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil ];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+ (void)circleFilledWithOutline:(UIView *)circleView fillColor:(UIColor *)fillColor outlineColor:(UIColor*)outlinecolor
{
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    float width = circleView.frame.size.width;
    float height = circleView.frame.size.height;
    [circleLayer setBounds:CGRectMake(2.0f, 2.0f, width-2.0f, height-2.0f)];
    [circleLayer setPosition:CGPointMake(width/2, height/2)];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.0f, 2.0f, width-2.0f, height-2.0f)];
    [circleLayer setPath:[path CGPath]];
    [circleLayer setFillColor:fillColor.CGColor];
    [circleLayer setStrokeColor:outlinecolor.CGColor];
    [circleLayer setLineWidth:1.0f];
    [[circleView layer] addSublayer:circleLayer];
    
}

/**
 *  加密 备忘id
 *
 *  @param cid 原id
 *
 *  @return 加密后id
 */
+ (NSString *)encryptionString:(NSString *)string
{
    if (![self isBlankString:string]) {
        NSString *rStr = [self stringByReversed:string];
        NSString *subText = [rStr substringToIndex:1];
        NSString *fromText = [rStr substringFromIndex:1];
        return [[self encryptionStringByIndex:1] stringByAppendingFormat:@"%@%@%@%@",subText,[self encryptionStringByIndex:2],fromText,[self encryptionStringByIndex:3]];
    }else{
        return [[self encryptionStringByIndex:1] stringByAppendingFormat:@"%@%@",string,[self encryptionStringByIndex:2]];
    }
    
    return nil;
}

/**
 *  生成随机数
 *
 *  @param length 随机数生成字符串长度
 *
 *  @return 随机数字符串
 */
+ (NSString *)encryptionStringByIndex:(int)length
{
    NSString *base = @"abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSString *returnString = @"";
    for (int i = 0; i< length; i++) {
        //生成0-i之间的正整数
        int value = arc4random_uniform(base.length + 1);
        if (value == base.length) {
            value = base.length-1;
        }
        
        NSString *ks = @"";
        ks = [base substringFromIndex:value];
        ks = [ks substringToIndex:1];
        
        returnString = [returnString stringByAppendingString:ks];
    }
    
    return returnString;
}

/**
 *  返转字符串
 *
 *  @return 返转后的字符串
 */
+ (NSString *)stringByReversed:(NSString *)str
{
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i=str.length; i>0; i--) {
        [s appendString:[str substringWithRange:NSMakeRange(i-1, 1)]];
    }
    return s;
}

+ (NSString *)changeFloat:(NSString *)stringFloat
{
    if ([stringFloat isKindOfClass:[NSNull class]]) {
        return @"0";
    }
    CGFloat floatValue = [stringFloat floatValue];
    NSMutableString *returnString =[NSMutableString stringWithFormat:@"%.2f",roundf(floatValue * 100)/100];
    NSString *lastStr = [returnString substringFromIndex:returnString.length - 1];
    while ([lastStr isEqualToString:@"0"]) {
        [returnString deleteCharactersInRange:NSMakeRange(returnString.length - 1, 1)];
        lastStr = [returnString substringFromIndex:returnString.length - 1];
        if ([lastStr isEqualToString:@"."]) {
            [returnString deleteCharactersInRange:NSMakeRange(returnString.length - 1, 1)];
            break;
        }
    }
    return returnString;
}

+ (instancetype)getClassObjectFormNib:(NSString *)nibString
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nibString owner:nil options:nil];
    for (id anyObject in nibs) {
        if ([anyObject isKindOfClass:NSClassFromString(nibString)]) {
            return anyObject;
        }
    }
    return nil;
}
/**
 @brief 时间格式转化
 */
+ (NSString *)timeDateFormatter:(NSDate *)date type:(int)type {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (type) {
        case 1:
            [dateFormatter setDateFormat:@"yyyy"];
            break;
        case 2:
            [dateFormatter setDateFormat:@"yyyy年MM月"];
            break;
        case 3:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case 4:
            [dateFormatter setDateFormat:@"hh"];
            break;
        case 5:
            [dateFormatter setDateFormat:@"mm"];
            break;
        case 6:
            [dateFormatter setDateFormat:@"ss"];
            break;
        case 7:
            [dateFormatter setDateFormat:@"a"];
            break;
        case 8:
            [dateFormatter setDateFormat:@"MM"];
            break;
        case 9:
            [dateFormatter setDateFormat:@"dd"];
            break;
        case 10:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case 11:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        case 12:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case 13:
            [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
            break;
        case 14:
            [dateFormatter setDateFormat:@"MM-dd"];
            break;
        case 15:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            break;
        case 16:
            [dateFormatter setDateFormat:@"yyyyMMdd"];
            break;
        case 17:
            [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
            break;
        case 18:
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            break;
        case 19:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH"];
            break;
        case 20:
            [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
            break;
        case 21:
            [dateFormatter setDateFormat:@"MM月dd日"];
            break;
        case 22:
            [dateFormatter setDateFormat:@"MM月dd日 EEEE"];
            break;
        default:
            break;
    }
    NSString *timeString = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    
    return timeString;
}

+ (NSString *)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone3,1"] || [deviceString isEqualToString:@"iPhone3,2"]){
        return @"iPhone 4";
    }
    if ([deviceString isEqualToString:@"iPhone4,1"]){
        return @"iPhone 4S";
    }
    if ([deviceString isEqualToString:@"iPhone5,2"] || [deviceString isEqualToString:@"iPhone6,1"]){
        return @"iPhone 5";
    }
    if ([deviceString isEqualToString:@"iPhone5,3"] || [deviceString isEqualToString:@"iPhone5,4"]){
        return @"iPhone 5C";
    }
    if ([deviceString isEqualToString:@"iPhone6,2"]){
        return @"iPhone 5S";
    }
    if ([deviceString isEqualToString:@"iPhone7,2"]){
        return @"iPhone 6";
    }
    if([deviceString isEqualToString:@"iPhone7,1"]){
        return @"iPhone 6 Plus";
    }
    if([deviceString isEqualToString:@"iPhone8,1"]){
        return @"iPhone 6S";
    }
    if([deviceString isEqualToString:@"iPhone8,2"]){
        return @"iPhone 6S Plus";
    }
    if([deviceString isEqualToString:@"iPhone8,4"]){
        return @"iPhone SE";
    }
    return deviceString;
}

+ (NSDictionary *)parseResponseStringToJson:(NSString *)response
{
    if ([self isBlankString:response])
        return nil;
    NSError *error;
    NSDictionary *jsonBody = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    return jsonBody;
}

#pragma mark- 创建红色背景底部黑色阴影button

+ (UIButton *)generateCommonButtonWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setBackgroundColor:color];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    //shadow
    btn.layer.shadowColor = [UIColor colorWithRed:((float)((0x440000 & 0xFF0000) >> 16))/255.0 green:((float)((0x440000 & 0xFF00) >> 8))/255.0 blue:((float)(0x440000 & 0xFF))/255.0 alpha:1.0].CGColor;
    btn.layer.shadowOffset = CGSizeMake(0, 2);
    btn.layer.shadowOpacity = 0.58;
    btn.layer.shadowRadius = 0;
    
    return btn;
}

@end

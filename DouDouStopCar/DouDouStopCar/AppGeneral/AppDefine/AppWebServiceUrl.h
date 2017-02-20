//
//  AppWebServiceUrl.h
//  DouDouStopCar
//
//  Created by Rainer on 17/2/20.
//  Copyright © 2017年 Rainer. All rights reserved.
//

#ifndef AppWebServiceUrl_h
#define AppWebServiceUrl_h

//服务器地址
#define Host @"http://120.76.242.66:8080"

//接口地址

/*登录
 userId:
 用户名
 password:
 登录密码
 deviceType:
 登录类型：1.手机登录 2.微信登录
 deviceType:
 设备类型：1安卓，2苹果
 */
#define LoginApi [NSString stringWithFormat:@"%@%@",Host,@"/user/login"]

/*验证码
 mobile:
 required
 
 手机号
 */
#define SendCodeApi [NSString stringWithFormat:@"%@%@",Host,@"/user/sendCode"]

/*注册
 userId:
 用户名
 checkCode:
 验证码
 password:
 登录密码
 */
#define RegistApi [NSString stringWithFormat:@"%@%@",Host,@"/user/register"]

/*忘记密码
 userId:
 用户名
 checkCode:
 验证码
 newPassword:
 新密码
 */
#define FinePasswordApi [NSString stringWithFormat:@"%@%@",Host,@"/user/findPassword"]


#endif /* AppWebServiceUrl_h */

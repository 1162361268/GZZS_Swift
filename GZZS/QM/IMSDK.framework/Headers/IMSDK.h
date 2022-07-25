//
//  IMSDK.h
//  IMSDK
//
//  Created by HCF on 16/6/17.
//  Copyright © 2016年 HCF. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for IMSDK.
FOUNDATION_EXPORT double IMSDKVersionNumber;

//! Project version string for IMSDK.
FOUNDATION_EXPORT const unsigned char IMSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <IMSDK/PublicHeader.h>


#import <Qiniu/Qiniu.h>
#import <FMDB/FMDB.h>

/**
 *  注册accessId成功通知
 */
#define CUSTOM_LOGIN_SUCCEED @"customLoginSucceed"

/**
 *  注册accessId失败通知
 */
#define CUSTOM_LOGIN_ERROR_USER @"customLoginErrorUser"

/**
 *  新消息通知
 */
#define CHATMSG_RELOAD @"chatMsgReload"

/**
 *  机器人客服通知
 */
#define ROBOT_SERVICE @"robotService"

/**
 *  客服在线
 */
#define CUSTOMSRV_ONLINE @"CustomOnline"

/**
 *  客服不在线
 */
#define CUSTOMSRV_OFFLINE @"CustomOffline"

/**
 *  在线领取消息
 */
#define CUSTOMSRV_CLAIM @"customClaim"

/**
 *  后台主动推送满意度调查
 */
#define CUSTOMSRV_INVESTIGATE @"customsrvInvestigate"

/**
 *  排队人数通知
 */
#define CUSTOMSRV_QUEUENUM @"customsrvqueuenum"

/**
 *  结束会话通知
 */
#define CUSTOMSRV_FINISH @"customsrvfinish"

/**
 *  坐席信息通知
 */
#define CUSTOMSRV_AGENT @"customagent"


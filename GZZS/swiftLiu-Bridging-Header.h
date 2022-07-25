//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "RNBridgeModule.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import <RCTRootView.h>
#import "QRCodeReaderView.h"
#import "WXApi.h"
#import "WXApiObject.h"

#import "QMChatRoomViewController.h"
#import "QMChatTileView.h"
#import "QMChatRoomGuestBookViewController.h"
//#import <IMSDK/IMSDK-Swift.h>
//#import <IMSDK/IMSDK.h>
//#import "QMDateManager.h"
//#import "UIImageView+WebCache.h"

#import <IMSDK/IMSDK-Swift.h>
#import <FMDB/FMDB.h>
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "MLEmojiLabel.h"
#import "QMDateManager.h"
#import "QMProfileManager.h"
#import "UMessage.h"
#import "UMMobClick/MobClick.h"
#import <AdSupport/AdSupport.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "LocationDemoViewController.h"

#import "TZImagePickerController.h"
#import "TZImageManager.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kMainCellColor [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1]

#define kInputViewHeight 50



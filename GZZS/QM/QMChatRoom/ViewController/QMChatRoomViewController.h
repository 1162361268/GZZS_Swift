//
//  QMChatRoomViewController.h
//  IMSDK-OC
//
//  Created by HCF on 16/3/9.
//  Copyright © 2016年 HCF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMChatRoomInputView;
@class TCMessageManagerFaceView;
@class addBackgroudView;
@class QMChatRoomMoreView;
@class QMRecordIndicatorView;

@interface QMChatRoomViewController : UIViewController

@property (nonatomic, strong) UITableView *chatTableView; // 消息列表

@property (nonatomic, strong) QMChatRoomInputView *chatInputView; // 输入工具条

@property (nonatomic, strong) TCMessageManagerFaceView *faceView; // 表情面板

@property (nonatomic, strong) QMChatRoomMoreView *addView; // 扩展面板

@property (nonatomic, strong) QMRecordIndicatorView *indicatorView; // 录音动画

@property (nonatomic, strong) UIButton *manualButotn; // 转人工

@property (nonatomic, strong) UIButton *logoutButton; // 返回

@property (nonatomic, copy) NSString *peerId; // 技能组ID

@property (nonatomic, copy) NSString *avaterStr; // 用户头像

@property (nonatomic, assign) BOOL isAutoBreak; // 是否开启定时关闭会话功能

@property (nonatomic, assign) NSInteger breakDuration; // 访客无响应断开时长

@property (nonatomic, assign) NSInteger breakTipsDuration; // 断开前提示时长

@property (nonatomic, copy) NSString *tips; // 断开提示语

@property (nonatomic, copy) NSString *msg; // 未开启留言提示

@property (nonatomic, copy) NSString *leaveMsg; // 留言提示语 后台未配置显示默认

@property (nonatomic, assign) BOOL isPush; // 判断是否为正常页面跳转

- (void)sendFileMessageWithName: (NSString *)fileName AndSize: (NSString *)fileSize AndPath: (NSString *)filePath;

@end

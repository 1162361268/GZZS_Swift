//
//  QMHomeViewController.m
//  IMSDK-OC
//
//  Created by haochongfeng on 2017/8/7.
//  Copyright © 2017年 HCF. All rights reserved.
//

#import "QMHomeViewController.h"
#import <IMSDK/IMSDK-Swift.h>
#import <IMSDK/IMSDK.h>
#import "QMChatRoomViewController.h"

#define kIphone6sScaleWidth [UIScreen mainScreen].bounds.size.width/375

@interface QMHomeViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *headLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign) BOOL isPushed;

@property (nonatomic, assign) BOOL isConnecting;

@end

@implementation QMHomeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccess:) name:CUSTOM_LOGIN_SUCCEED object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerFailure:) name:CUSTOM_LOGIN_ERROR_USER object:nil];
    }
    return self;
}

- (void)registerSuccess:(NSNotification *)sender {
    NSLog(@"注册成功");
    if (self.isPushed) {
        return;
    }
    [self getPeers];
}

- (void)registerFailure:(NSNotification *)sender {
    NSLog(@"注册失败::%@", sender.object);
    self.isConnecting = NO;
    [self.indicatorView stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isConnecting = NO;
    self.isPushed = NO;
    [self layoutView];
}

//- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = YES;
//    self.isPushed = NO;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    self.navigationController.navigationBarHidden = NO;
//    self.isPushed = YES;
//}

- (void)layoutView {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 236 * kIphone6sScaleWidth)/2, 55 * kIphone6sScaleWidth, 236 * kIphone6sScaleWidth, 250 * kIphone6sScaleWidth);
    self.imageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:self.imageView];
    
    self.headLabel = [[UILabel alloc] init];
    self.headLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 35 * kIphone6sScaleWidth, [UIScreen mainScreen].bounds.size.width, 25 * kIphone6sScaleWidth);
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    self.headLabel.text = @"好客服 用七陌";
    self.headLabel.textColor = [UIColor blackColor];
    self.headLabel.font = [UIFont systemFontOfSize:25 * kIphone6sScaleWidth];
    [self.view addSubview:self.headLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.frame = CGRectMake(0, CGRectGetMaxY(self.headLabel.frame) + 15 * kIphone6sScaleWidth, [UIScreen mainScreen].bounds.size.width, 65 * kIphone6sScaleWidth);
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.attributedText = [self setSpace:4 kern:[NSNumber numberWithInt:1] font:[UIFont systemFontOfSize:15 * kIphone6sScaleWidth] text:@"即时联系在线客服\n视频、语音、文字、表情、图片、\n统统都不是事儿"];
    self.detailLabel.textColor = [UIColor grayColor];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:15 * kIphone6sScaleWidth];
    [self.view addSubview:self.detailLabel];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 150 * kIphone6sScaleWidth)/2, [UIScreen mainScreen].bounds.size.height - 105 * kIphone6sScaleWidth, 150 * kIphone6sScaleWidth, 40 * kIphone6sScaleWidth);
    [self.button setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.button setTitle:@"联系客服" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor colorWithRed:0/255.0 green:183/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    // 建议使用网络指示器
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView.layer.cornerRadius = 5;
    self.indicatorView.layer.masksToBounds = YES;
    self.indicatorView.frame = CGRectMake((kScreenWidth-100)/2, (kScreenHeight-100)/2-64, 100, 100);
    self.indicatorView.backgroundColor = [UIColor blackColor];
    self.indicatorView.color = [UIColor whiteColor];
    self.indicatorView.alpha = 0.7;
    [self.view addSubview:self.indicatorView];
}

- (void)buttonAction:(UIButton *)sender {
    [self.indicatorView startAnimating];
    
    if (self.isConnecting) {
        return;
    }
    self.isConnecting = YES;
    
    // userId  只能使用  数字 字母(包括大小写) 下划线
    [QMConnect registerSDKWithAppKey:@"" userName:@"" userId:@""];
}

#pragma mark - 技能组选择
- (void)getPeers {
    [QMConnect sdkGetPeers:^(NSArray * _Nonnull peerArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", peerArray);
            NSArray *peers = peerArray;
            self.isConnecting = NO;
            [_indicatorView stopAnimating];
            if (peers.count == 1 && peers.count != 0) {
                [self showChatRoomViewController:[peers.firstObject objectForKey:@"id"]];
            }else {
                [self showPeersWithAlert:peers];
            }
        });
    } failureBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.isConnecting = NO;
        });
    }];
}

- (void)showPeersWithAlert: (NSArray *)peers {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择您咨询的类型或业务部门(对应技能组)" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.isConnecting = NO;
    }];
    [alertController addAction:cancelAction];
    for (NSDictionary *index in peers) {
        UIAlertAction *surelAction = [UIAlertAction actionWithTitle:[index objectForKey:@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showChatRoomViewController:[index objectForKey:@"id"]];
        }];
        [alertController addAction:surelAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 跳转聊天界面
- (void)showChatRoomViewController:(NSString *)peerId {
    QMChatRoomViewController *chatRoomViewController = [[QMChatRoomViewController alloc] init];
    chatRoomViewController.peerId = peerId;
    chatRoomViewController.isPush = NO;
    chatRoomViewController.avaterStr = @"";
    [self.navigationController pushViewController:chatRoomViewController animated:YES];
}

- (NSMutableAttributedString *)setSpace:(CGFloat)line kern:(NSNumber *)kern font:(UIFont *)font text:(NSString *)text {
    NSMutableParagraphStyle * paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = line;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: paraStyle,
                                 NSKernAttributeName: kern
                                 };
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    return attributeStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  QMChatRoomGuestBookViewController.m
//  IMSDK-OC
//
//  Created by HCF on 16/3/10.
//  Copyright © 2016年 HCF. All rights reserved.
//

#import "QMChatRoomGuestBookViewController.h"

@interface QMChatRoomGuestBookViewController ()<UITextViewDelegate> {
    UIScrollView *_scrollView;
}

@end

@implementation QMChatRoomGuestBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"留言板";
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:246/255.0 alpha:1];
    
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
    
    self.leaveMsg = [QMConnect leaveMessagePlaceholder];
    if ([self.leaveMsg isEqualToString:@""]) {
        self.leaveMsg = @"请留言~";
    }
    
    [self createUI];
}

- (void)createUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-64);
    [self.view addSubview:_scrollView];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth-40, 30)];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.textColor = [UIColor blackColor];
    self.messageLabel.font = [UIFont systemFontOfSize:14];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    self.messageLabel.text = @"请留言, 我们将尽快联系您!";
    [_scrollView addSubview:self.messageLabel];
    
    self.messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.messageLabel.frame)+10, kScreenWidth-40, 120)];
    self.messageTextView.font = [UIFont systemFontOfSize:16];
    self.messageTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.messageTextView.layer.borderWidth = 1;
    self.messageTextView.layer.cornerRadius = 3;
    self.messageTextView.layer.masksToBounds = true;
    self.messageTextView.delegate = self;
    [_scrollView addSubview:self.messageTextView];
    
    self.messageLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.messageTextView.frame)+10, kScreenWidth-40, 30)];
    self.messageLabel2.backgroundColor = [UIColor clearColor];
    self.messageLabel2.textColor = [UIColor blackColor];
    self.messageLabel2.font = [UIFont systemFontOfSize:14];
    self.messageLabel2.text = @"请务必留下您的联系方式, 方便我们联系您!";
    [_scrollView addSubview:self.messageLabel2];
    
    self.phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.messageLabel2.frame)+10, 35, 35)];
    self.phoneIcon.image = [UIImage imageNamed:@"leave_message_phone"];
    [_scrollView addSubview:self.phoneIcon];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.messageLabel2.frame)+10, kScreenWidth-80, 35)];
    self.phoneTextField.backgroundColor = [UIColor whiteColor];
    self.phoneTextField.font = [UIFont systemFontOfSize:16];
    self.phoneTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.phoneTextField.layer.borderWidth = 1;
    self.phoneTextField.layer.cornerRadius = 3;
    self.phoneTextField.layer.masksToBounds = true;
    self.phoneTextField.placeholder = @"联系电话 ~";
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [_scrollView addSubview:self.phoneTextField];
    
    self.emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.phoneIcon.frame)+10, 35, 35)];
    self.emailIcon.image = [UIImage imageNamed:@"leave_message_email"];
    [_scrollView addSubview:self.emailIcon];
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(self.phoneIcon.frame)+10, kScreenWidth-80, 35)];
    self.emailTextField.backgroundColor = [UIColor whiteColor];
    self.emailTextField.font = [UIFont systemFontOfSize:16];
    self.emailTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.emailTextField.layer.borderWidth = 1;
    self.emailTextField.layer.cornerRadius = 3;
    self.emailTextField.layer.masksToBounds = true;
    self.emailTextField.placeholder = @"邮箱 ~";
    [_scrollView addSubview:self.emailTextField];
    
    
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.messageTextView.frame), CGRectGetMinY(self.messageTextView.frame), CGRectGetWidth(self.messageTextView.frame),  [self calcLabelHeight:self.leaveMsg ?: @"请留言 ~" font:[UIFont systemFontOfSize:15] width:CGRectGetWidth(self.messageTextView.frame)])];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor lightGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.numberOfLines = 0;
    self.textLabel.text = self.leaveMsg ?: @"请留言 ~";
    [_scrollView addSubview:self.textLabel];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.submitBtn.frame = CGRectMake(20, CGRectGetMaxY(self.emailTextField.frame)+30, kScreenWidth-40, 35);
    [self.submitBtn setTitle:@"留  言" forState:UIControlStateNormal];
    self.submitBtn.backgroundColor = [UIColor colorWithRed:32/255.0 green:218/255.0 blue:155/255.0 alpha:1.0];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.submitBtn];
}

- (void)tapAction {
    [self.messageTextView resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

- (void)keyboardShow {
    [UIView animateWithDuration:0.25 animations:^{
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-216-64);
        _scrollView.contentOffset = CGPointMake(0, 60);
    }];
}

- (void)keyboardHide {
    [UIView animateWithDuration:0.25 animations:^{
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.textLabel.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        self.textLabel.text = self.leaveMsg ?: @"请留言 ~";
    }
}

- (BOOL)checkPhoneNumber: (NSString *)phoneNumber {
    NSString *number = phoneNumber;
    NSString *regex = @"[0-9]{8,15}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:number];
}

- (BOOL)checkEmailName: (NSString *)emailName {
    NSString *name = emailName;
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:name];
}

- (void)submitAction: (UIButton *)sender {
    if ([self.messageTextView.text isEqualToString:@""]) {
        [self showAlertViewControllerWithTitle:@"留言内容不能为空"];
        return;
    }
    
    if ([self.phoneTextField.text isEqualToString:@""] && [self.emailTextField.text isEqualToString:@""]) {
        [self showAlertViewControllerWithTitle:@"联系方式(电话、邮箱)至少填写一项"];
        return;
    }
    
    if (![self.phoneTextField.text isEqualToString:@""]) {
        if (![self checkPhoneNumber:self.phoneTextField.text]) {
            [self showAlertViewControllerWithTitle:@"您输入的号码有误,请重新输入"];
            return;
        }
    }
    
    if (![self.emailTextField.text isEqualToString:@""]) {
        if (![self checkEmailName:self.emailTextField.text]) {
            [self showAlertViewControllerWithTitle:@"您的邮箱格式不正确,请重新输入"];
            return;
        }
    }
    if (([self checkPhoneNumber:self.phoneTextField.text] || [self checkEmailName:self.emailTextField.text]) && ![self.messageTextView.text isEqualToString:@""]) {
        
        [QMConnect sdkSubmitLeaveMessage:self.peerId phone: self.phoneTextField.text Email:self.emailTextField.text message:self.messageTextView.text successBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertViewControllerWithTitle:@"留言成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            });
        } failBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertViewControllerWithTitle:@"留言失败"];
            });
        }];
    }
}

- (CGFloat)calcLabelHeight: (NSString *)text font: (UIFont *)font width: (CGFloat)width {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGRect labelRect = [text boundingRectWithSize:CGSizeMake(width, CGRectGetHeight(self.messageTextView.frame)) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return labelRect.size.height;
}

- (void)showAlertViewControllerWithTitle: (NSString *)title {
    [self.view endEditing:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:title preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

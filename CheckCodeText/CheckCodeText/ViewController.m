//
//  ViewController.m
//  CheckCodeText
//
//  Created by 劳景醒 on 16/5/5.
//  Copyright © 2016年 laojingxing. All rights reserved.
//

#import "ViewController.h"
#import "LJXCeckCodeView.h"

@interface ViewController ()<UITextFieldDelegate>
{
    LJXCeckCodeView *_checkCodeView;
    UITextField *_inputTextField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self _initSubViews];
}

- (void)_initSubViews
{
    // 输入框
    _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 100, 35)];
    _inputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _inputTextField.layer.borderWidth = 1.0;
    _inputTextField.layer.cornerRadius = 5.0;
    _inputTextField.font = [UIFont systemFontOfSize:15];
    _inputTextField.placeholder = @"请输入验证码!";
    _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _inputTextField.backgroundColor = [UIColor clearColor];
    _inputTextField.textAlignment = NSTextAlignmentCenter;
    _inputTextField.returnKeyType = UIReturnKeyDone;
    _inputTextField.delegate = self;
    [self.view addSubview:_inputTextField];
    
    // 显示验证码界面
    _checkCodeView = [[LJXCeckCodeView alloc] initWithFrame:CGRectMake(_inputTextField.frame.origin.x + _inputTextField.frame.size.width + 10, _inputTextField.frame.origin.y, 100, 35)];
    [self.view addSubview:_checkCodeView];
    
    // 提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_checkCodeView.frame.origin.x + _checkCodeView.frame.size.width + 10, _checkCodeView.frame.origin.y, 100, 40)];
    label.text = @"点击图片换验证码";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //判断输入的是否为验证图片显示的验证码， 不区分大小写
    if ([_inputTextField.text compare:_checkCodeView.changeString options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        //正确弹出警告款提示正确
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"胜💎⚽💣🔫利" message:@"验证成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alview show];
    }
    else
    {
        //验证不匹配，验证码和输入框晃动
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"哎错了💩好烦" message:@"验证失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alview show];

    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

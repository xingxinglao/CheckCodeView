//
//  LJXCeckCodeView.h
//  CheckCodeText
//
//  Created by 劳景醒 on 16/5/5.
//  Copyright © 2016年 laojingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJXCeckCodeView : UIView
@property (nonatomic, copy) NSArray *changeArray; // 字符素材数组
@property (nonatomic, strong) NSMutableString *changeString;  // 验证码的字符串
@end

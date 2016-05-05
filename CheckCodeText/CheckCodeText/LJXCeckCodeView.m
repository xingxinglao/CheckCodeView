//
//  LJXCeckCodeView.m
//  CheckCodeText
//
//  Created by 劳景醒 on 16/5/5.
//  Copyright © 2016年 laojingxing. All rights reserved.
//

#import "LJXCeckCodeView.h"

@implementation LJXCeckCodeView
#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define kLineCount 7
#define kLineWidth 1.0
#define kCharCount 6
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 5.0; //设置layer圆角半径
        self.layer.masksToBounds = YES; //隐藏边界
        self.backgroundColor = kRandomColor;
        
        //显示一个随机验证码
        [self changeCaptcha];
    }
    
    return self;
}
#pragma mark - 更换验证码,得到更换的验证码的字符串
-(void)changeCaptcha
{
    
    // 从网络获取字符串，然后把得到的字符串在本地绘制出来
    //  获取方法.........
        self.changeString = [NSMutableString stringWithString:@"L1J2X3"];
    // 本地生成
    NSString *string = [NSString stringWithFormat:@"%d%d%d%d", arc4random() % 2, arc4random() % 2, arc4random() % 10, arc4random() % 2];
    self.changeString = [NSMutableString stringWithString:string];
}

#pragma mark - 点击view时调用，因为当前类自身就是UIView，点击更换验证码可以直接写到这个方法中，不用再额外添加手势
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 点击界面，切换验证码
    [self changeCaptcha];
    
    // setNeedsDisplay调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];
}

#pragma mark 绘制界面
//（1.UIView初始化后自动调用； 2.调用setNeedsDisplay方法时会自动调用）
- (void)drawRect:(CGRect)rect {
    // 重写父类方法，首先要调用父类的方法
    [super drawRect:rect];
    
    // 设置随机背景颜色
    self.backgroundColor = kRandomColor;
    
    // 获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    // 每个字最大字号20，算出每个最多所占的位置
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    // 每个格子除了字的大小后剩下的位置，用来计算每个字的x、y坐标。
    NSInteger width = rect.size.width / text.length - cSize.width;
    NSInteger height = rect.size.height - cSize.height;
    CGPoint point;
    
    // 依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    float pX, pY;
    for (NSInteger i = 0; i < text.length; i++)
    {
        // 随机位置
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        
        NSRange rang = NSMakeRange(i, 1);
        NSString *textWord = [text substringWithRange:rang];
        
        // 随机设置字体，每个字随机颜色
        UIColor *textColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
        [textWord drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize, NSForegroundColorAttributeName:textColor}];
        
    }
    
    // 调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置画线宽度
    CGContextSetLineWidth(context, kLineWidth);
    
    // 绘制干扰的彩色直线
    for(NSInteger i = 0; i < kLineCount; i++)
    {
        // 设置线的随机颜色
        UIColor *color = kRandomColor;
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        // 设置线的起点
        pX = arc4random() % (NSInteger)rect.size.width;
        pY = arc4random() % (NSInteger)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        // 设置线终点
        pX = arc4random() % (NSInteger)rect.size.width;
        pY = arc4random() % (NSInteger)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        // 画线
        CGContextStrokePath(context);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

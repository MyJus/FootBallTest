//
//  FootBallView.m
//  FootBallTest
//
//  Created by peony on 2017/7/26.
//  Copyright © 2017年 peony. All rights reserved.
//

#import "FootBallView.h"


@interface FootBallView()

@end

@implementation FootBallView

//使用该方法进行获取足球场的view
+ (instancetype)getFootBallView:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    self.backgroundColor = [UIColor colorWithRed:97 / 255.0 green:178 / 255.0 blue:2 / 255.0 alpha:1.0];
}

- (void)drawRect:(CGRect)rect {
    BOOL isVertical = YES;//是否是竖向画足球场
    if (rect.size.width > rect.size.height) {
        isVertical = NO;
    }
    CGFloat w = rect.size.width - 16;
    CGFloat h = rect.size.height - 16;
    CGFloat scale = (w / (isVertical ? 75.0 : 110.0)) > (h / (isVertical ? 110.0 : 75)) ? (h / (isVertical ? 110.0 : 75)) : (w / (isVertical ? 75.0 : 110.0));
    CGFloat width = (isVertical ? 75.0 : 110.0) * scale;
    CGFloat height = (isVertical ? 110.0 : 75) * scale;
    CGFloat x = 8 + (w - width) / 2;
    CGFloat y = 8 + (h - height) / 2;
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context,1,0,1,1.0);//画笔线的颜色
    CGContextSetRGBStrokeColor(context,1,1,1,1.0);
    CGContextSetLineWidth(context, 1.0);//设置线条宽度
    
    
    //边框线
    CGPoint aPoints[5];//坐标点
    aPoints[0] =CGPointMake(x, y);//坐标1
    aPoints[1] =CGPointMake(width + x, y);//坐标2
    aPoints[2] = CGPointMake(width + x, height + y);
    aPoints[3] = CGPointMake(x, height + y);
    aPoints[4] = CGPointMake(x, y - 0.5);
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 5);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    
    //中间横线
    aPoints[0] =isVertical ? CGPointMake(x, y + height / 2) : CGPointMake(x + width / 2, y);//坐标1
    aPoints[1] =isVertical ? CGPointMake(width + x, y + height / 2) : CGPointMake(width / 2 + x, y + height);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    
    //中心的圆
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, x + width / 2, y + height / 2, 9.15 * scale, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    //中心点
    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
    CGContextAddArc(context, x + width / 2, y + height / 2, 2, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    
    //球门区域
    //上球门区域
    aPoints[0] =isVertical ? CGPointMake(x + width / 2 - 20.16 * scale, y ) : CGPointMake(x, y + height / 2 - 20.16 * scale);//坐标1
    aPoints[1] =isVertical ? CGPointMake(x + width / 2 - 20.16 * scale, y + 16.5 * scale) : CGPointMake(x + 16.5 * scale, y + height / 2 - 20.16 * scale);//坐标2
    aPoints[2] = isVertical ? CGPointMake(x + width / 2 + 20.16 * scale, y + 16.5 * scale) : CGPointMake(x + 16.5 * scale, y + height / 2 + 20.16 * scale);
    aPoints[3] = isVertical ? CGPointMake(x + width / 2 + 20.16 * scale, y) : CGPointMake(x, y + height / 2 + 20.16 * scale);
    CGContextAddLines(context, aPoints, 4);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    aPoints[0] =isVertical ? CGPointMake(x + width / 2 - 9.16 * scale, y ) : CGPointMake(x, y + height / 2 - 9.16 * scale);//坐标1
    aPoints[1] =isVertical ? CGPointMake(x + width / 2 - 9.16 * scale, y + 5.5 * scale) : CGPointMake(x + 5.5 * scale, y + height / 2 - 9.16 * scale);//坐标2
    aPoints[2] = isVertical ? CGPointMake(x + width / 2 + 9.16 * scale, y + 5.5 * scale) : CGPointMake(x + 5.5 * scale, y + height / 2 + 9.16 * scale);
    aPoints[3] = isVertical ? CGPointMake(x + width / 2 + 9.16 * scale, y) : CGPointMake(x, y + height / 2 + 9.16 * scale);
    CGContextAddLines(context, aPoints, 4);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
//    CGContextAddArc(context, x + width / 2, y + 11 * scale, 9.15 * scale, asin(5.5 /9.15),M_PI - asin(5.5 /9.15), 0); //添加一个圆弧
    isVertical ? CGContextAddArc(context, x + width / 2, y + 11 * scale, 9.15 * scale, asin(5.5 /9.15),M_PI - asin(5.5 /9.15), 0) : CGContextAddArc(context, x + 11 * scale, y + height / 2, 9.15 * scale,-M_PI_2 + asin(5.5 /9.15),M_PI_2 - asin(5.5 /9.15), 0);
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    //添加圆弧的圆心
    isVertical ? CGContextAddArc(context, x + width / 2, y + 11 * scale, 1, 0, M_PI*2, 0) : CGContextAddArc(context, x + 11 * scale, y + height / 2, 1, 0, M_PI*2, 0);
    CGContextSetRGBFillColor (context,  1, 1, 1, 1.0);//设置填充颜色
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    //下球门区域
    aPoints[0] =isVertical ? CGPointMake(x + width / 2 - 20.16 * scale, y + height ) : CGPointMake(x + width, y + height / 2 - 20.16 * scale);//坐标1
    aPoints[1] =isVertical ? CGPointMake(x + width / 2 - 20.16 * scale, y + height - 16.5 * scale) : CGPointMake(x + width - 16.5 * scale, y + height / 2 - 20.16 * scale);//坐标2
    aPoints[2] = isVertical ? CGPointMake(x + width / 2 + 20.16 * scale, y + height - 16.5 * scale) : CGPointMake(x + width - 16.5 * scale, y + height / 2 + 20.16 * scale);
    aPoints[3] = isVertical ? CGPointMake(x + width / 2 + 20.16 * scale, y + height) : CGPointMake(x + width, y + height / 2 + 20.16 * scale);
    CGContextAddLines(context, aPoints, 4);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    
    aPoints[0] =isVertical ? CGPointMake(x + width / 2 - 9.16 * scale, y + height ) : CGPointMake(x + width, y + height / 2 - 9.16 * scale);//坐标1
    aPoints[1] =isVertical ? CGPointMake(x + width / 2 - 9.16 * scale, y + height - 5.5 * scale) : CGPointMake(x + width - 5.5 * scale, y + height / 2 - 9.16 * scale);//坐标2
    aPoints[2] = isVertical ? CGPointMake(x + width / 2 + 9.16 * scale, y + height - 5.5 * scale) : CGPointMake(x + width - 5.5 * scale, y + height / 2 + 9.16 * scale);
    aPoints[3] = isVertical ? CGPointMake(x + width / 2 + 9.16 * scale, y + height) : CGPointMake(x + width, y + height / 2 + 9.16 * scale);
    CGContextAddLines(context, aPoints, 4);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    //弧线
    isVertical ? CGContextAddArc(context, x + width / 2, y + height - 11 * scale, 9.15 * scale, -asin(5.5 /9.15),-M_PI + asin(5.5 /9.15), 1) : CGContextAddArc(context, x + width - 11 * scale, y + height / 2, 9.15 * scale,-M_PI_2 - asin(5.5 /9.15),M_PI_2 + asin(5.5 /9.15), 1);
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    isVertical ? CGContextAddArc(context, x + width / 2, y + height - 11 * scale, 1, 0, 2 * M_PI, 1) : CGContextAddArc(context, x + width - 11 * scale, y + height / 2, 1, 0, 2 * M_PI, 1);
    CGContextSetRGBFillColor (context,  1, 1, 1, 1.0);//设置填充颜色
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    
    //四个角的圆弧
    CGContextAddArc(context, x, y, 1 * scale, M_PI_2, 0, 1);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextAddArc(context, x + width, y, 1 * scale, M_PI, M_PI_2, 1);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextAddArc(context, x + width, y + height, 1 * scale, - M_PI_2, -M_PI, 1);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextAddArc(context, x, y + height, 1 * scale, 0, -M_PI_2, 1);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
}








@end

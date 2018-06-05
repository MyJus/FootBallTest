//
//  ViewController.m
//  FootBallTest
//
//  Created by peony on 2017/7/26.
//  Copyright © 2017年 peony. All rights reserved.
//

#import "ViewController.h"
#import "FootBallView.h"

/**
 *  获取屏幕的宽度
 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
/**
 *  获取屏幕的高度度
 */
#define kScreenHight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (weak,nonatomic) FootBallView *footBallView;

@property (assign,nonatomic) BOOL isVertical;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isVertical = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 60, 30, 50, 30);
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 2.0;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(refershUI:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 120, 30, 50, 30);
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 2.0;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"横向" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(chagedFootBallView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    FootBallView *footBallView = [FootBallView getFootBallView:CGRectMake(10, 70, kScreenWidth - 20, kScreenHight -160)];
    [self.view addSubview:self.footBallView = footBallView];
    [self addFootBallMember];
    
}

- (void)refershUI:(UIButton *)button {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag > 100) {
            [obj removeFromSuperview];
        }
    }];
    [self addFootBallMember];
}
- (void)chagedFootBallView:(UIButton *)button {
    if (self.footBallView) {
        [self.footBallView removeFromSuperview];
    }
    self.isVertical = !self.isVertical;
    [button setTitle:self.isVertical ? @"横向" : @"竖向" forState:UIControlStateNormal];
    if (self.isVertical) {
        FootBallView *footBallView = [FootBallView getFootBallView:CGRectMake(10, 70, kScreenWidth - 20, kScreenHight -160)];
        [self.view addSubview:self.footBallView = footBallView];
        [self refershUI:nil];
    }else {
        FootBallView *footBallView = [FootBallView getFootBallView:CGRectMake(10, 70, kScreenWidth - 20, (kScreenWidth - 20) * (75.0 / 110.0) + 40)];
        [self.view addSubview:self.footBallView = footBallView];
        [self refershUI:nil];
    }
}
- (void)addFootBallMember {
    
    CGFloat height = (kScreenHight - CGRectGetMaxY(self.footBallView.frame) - 4);
    CGFloat width = 50.0;
    
    int a = (int)((kScreenWidth - 4) / (width + 4));
    float aW = (kScreenWidth - a * width - (a + 1) * 4) / (a + 1) + 4;
    
    int b = (int)(height / width);
    float bW = (height - b * width - (b - 1) * 2) / (b + 1);
    while (1) {
        if (a * b < 11) {
            b = b + 1;
            width = (height - (b - 1) * 2) / b;
            a = (int)((kScreenWidth - 4) / (width + 4));
            aW = (kScreenWidth - a * width - (a + 1) * 4) / (a + 1) + 4;
            bW = (height - b * width - (b - 1) * 2) / (b + 1);
        }else {
            break;
        }
    }
    if (width < 10.0) {
        return;
    }else {
        if (a * (b - 1) >= 11) {
            b = b - 1;
            bW = (height - b * width - (b - 1) * 2) / (b + 1);
        }
    }
    
    for (int i = 0; i < b; i ++) {
        for (int j = 0; j < a; j ++) {
            if (i * a + j >= 11 ) {
                return;
            }
            UIView *snakeView = [[UIView alloc] initWithFrame:CGRectMake(aW + j * (width + aW), CGRectGetMaxY(self.footBallView.frame) + 2 * (1 + i) + bW * (1 + i) + i * width, width, width)];
            snakeView.tag = 100 + i * a + j + 1;
            snakeView.backgroundColor = [UIColor clearColor];
            snakeView.layer.borderColor = [UIColor grayColor].CGColor;
            snakeView.layer.borderWidth = 1.0;
            snakeView.layer.masksToBounds = YES;
            snakeView.layer.cornerRadius = CGRectGetWidth(snakeView.frame) / 2;;
            UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handlePan:)];
            [snakeView addGestureRecognizer:panGestureRecognizer];
            [self.view addSubview:snakeView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(snakeView.frame), CGRectGetHeight(snakeView.frame))];
            titleLabel.adjustsFontSizeToFitWidth = YES;
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = [NSString stringWithFormat:@"%d",i * a + j + 1];
            [snakeView addSubview:titleLabel];
            
        }
    }
    
    
    
}
- (void) handlePan:(UIPanGestureRecognizer*) recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

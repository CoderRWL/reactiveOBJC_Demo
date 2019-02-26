//
//  ViewController.m
//  reactiveOBJC_Demo
//
//  Created by  RWLi on 2019/2/26.
//  Copyright © 2019  RWLi. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)RACSignal *timerSingle;
@property(nonatomic,assign)NSInteger times;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor =  [UIColor cyanColor];
    _times = 10;
    
    // 监听按钮点击
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 40, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    _btn = btn;
    __weak typeof(self) weakSelf = self;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        __strong typeof(self) strongSelf = weakSelf;
//        x.backgroundColor = [UIColor yellowColor];
        
        //传一个参数
//        [strongSelf.btnClickSingle sendNext:@"按钮被点击了"];
        
        // 传多个参数,在注册回调里去接收
//        [strongSelf doSome1:@"111" S2:@"2222"];
        
        
        //添加倒计时
        [(UIButton*)x setTitle:[NSString stringWithFormat:@"%ld",weakSelf.times] forState:UIControlStateDisabled ];
       
        weakSelf.btn.enabled = NO;
      weakSelf.timerSingle =  [[RACSignal interval:1 onScheduler:[RACScheduler scheduler]]subscribeNext:^(NSDate * _Nullable x) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = weakSelf.times >0?[NSString stringWithFormat:@"%ld",weakSelf.times]:@"重新发送";
              
                [weakSelf.btn setTitle:title forState:UIControlStateDisabled];
                if (weakSelf.times<= 0) {
                    weakSelf.btn.enabled = YES;
                    
                    
// 怎么销毁?
                    [weakSelf.timerSingle rac_deallocDisposable];
                }
                  weakSelf.times--;
            });
        }];
        
    }];
    
//    RAC(self.view, backgroundColor) = RACObserve(btn, backgroundColor);
    
    //kvo
    [[btn rac_valuesAndChangesForKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
    
    
    //监听内容变化
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 300, 50)];
    tf.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tf];
    [tf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
        [weakSelf.btn setTitle:x forState:UIControlStateNormal];
       
    }];
    
    //,系统的通知 /监听键盘弹出
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil ]takeUntil:[self rac_willDeallocSignal]]subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x.userInfo[UIKeyboardFrameEndUserInfoKey]);
    }];
   
    
    //timer //一直存在的情况
//    [[RACSignal interval:1 onScheduler:[RACScheduler scheduler]]subscribeNext:^(NSDate * _Nullable x) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.btn setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1]];
//        });
//    }];
}


-(void)doSome1:(NSString*)s1 S2:(NSString*)s2{
    
}

-(RACSubject *)btnClickSingle{
    if (!_btnClickSingle) {
        _btnClickSingle = [RACSubject subject];
    }
    return _btnClickSingle;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end

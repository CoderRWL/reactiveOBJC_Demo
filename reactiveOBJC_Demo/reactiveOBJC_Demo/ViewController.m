//
//  ViewController.m
//  reactiveOBJC_Demo
//
//  Created by  RWLi on 2019/2/26.
//  Copyright © 2019  RWLi. All rights reserved.
//

#import "ViewController.h"
#import "RACSignal_SampleUse.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor =  [UIColor cyanColor];
    
    
    
    
    //简单使用
    NSDictionary *dict = @{@"key1":@"value1",@"key2":@"value2",};
    RACSignal_SampleUse *m1 = [[RACSignal_SampleUse alloc]initWithId:dict];
    [m1 dataWith:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
}
@end

//
//  RACSignal_SampleUse.m
//  reactiveOBJC_Demo
//
//  Created by  RWLi on 2019/2/28.
//  Copyright © 2019  RWLi. All rights reserved.
//

#import "RACSignal_SampleUse.h"

@interface RACSignal_SampleUse()

@property(nonatomic,strong)RACSignal*signal;

@end



@implementation RACSignal_SampleUse


- (instancetype)initWithId:(id)obj{
    self = [super init];
    if (self) {
        _signal  =  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:obj];
            [subscriber sendCompleted];
            return nil;
        }];
    }
    return self;
}


-(void)dataWith:(void(^)(id _Nullable))back{
    [_signal subscribeNext:^(id  _Nullable x) {
        return back(x);
    }];
}





-(void)block{
    
    //d变量定义
    NSString*(^study)(NSString*) = ^NSString*(NSString* str){
        return [NSString stringWithFormat:@"------%@",str];
    };
    
    NSString * str =  study(@"study");
    NSLog(@"%@",str);
    
    
    
    
    
    
    //    typedef
    typedef NSString*(^study1)(NSString*);
    typedef void (^dosth)(void);
    study1 s1 = ^NSString*(NSString* str){
        return [NSString stringWithFormat:@"------%@",str];
    };
    dosth do1 = ^{
        //
    };
    
    NSString *str2 =  s1(@"s1");
    NSLog(@"%@",str2);
    do1();
    
    
    
    
    
    
    BOOL is = [self testbolck:^BOOL(NSString *str) {
        return [str isEqualToString:@"YES"];
    }];
}


//函数申明
-(BOOL)testbolck:(BOOL(^)(NSString*))block{
    if (block) {
        return block(@"test");
    }
    return NO;
}


-(void)dealloc{
    NSLog(@"RACSignal_SampleUse--->dealloc");
}

@end


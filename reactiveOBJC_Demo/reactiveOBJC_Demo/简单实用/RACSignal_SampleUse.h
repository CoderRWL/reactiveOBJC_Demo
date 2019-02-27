//
//  RACSignal_SampleUse.h
//  reactiveOBJC_Demo
//
//  Created by  RWLi on 2019/2/28.
//  Copyright © 2019  RWLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface RACSignal_SampleUse : NSObject

- (instancetype)initWithId:(id)obj;
-(void)dataWith:(void(^)(id _Nullable))back;

@end

NS_ASSUME_NONNULL_END

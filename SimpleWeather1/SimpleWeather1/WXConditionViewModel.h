//
//  WXConditionViewModel.h
//  SimpleWeather1
//
//  Created by 王享 on 16/3/22.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXConditionModel.h"
#import "ReactiveCocoa.h"

@interface WXConditionViewModel : NSObject

@property (nonatomic, strong) NSURLSession *session;


@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) WXConditionModel *currentCondition;

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;


@end

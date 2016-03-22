//
//  WXClient.h
//  SimpleWeather1
//
//  Created by 王享 on 16/3/22.
//  Copyright © 2016年 王享. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"


@interface WXClient : NSObject

@property (nonatomic, strong) NSURLSession *session;

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;

@end

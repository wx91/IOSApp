//
//  WXClient.m
//  SimpleWeather1
//
//  Created by 王享 on 16/3/22.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "WXClient.h"
#import "WXConditionModel.h"

@implementation WXClient

-(instancetype )init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

-(RACSignal *)fetchJSONFromURL:(NSURL *)url{
    NSLog(@"Fetching:%@",url.absoluteString);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask =
        [self.session dataTaskWithURL:url
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        // TODO: Handle retrieved data
                        if (! error) {
                            NSError *jsonError = nil;
                            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                            if (!jsonError) {
                                [subscriber sendNext:json];
                            }else{
                                [subscriber sendError:jsonError];
                            }
                        }else{
                            [subscriber sendError:error];
                        }
                        [subscriber sendCompleted];
                    }];
        [dataTask resume];
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
    return signal;
}
- (RACSignal *)fetchCurrentConditionCityName:(NSString *)name {
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=b1b15e88fa797225412429c1c50c122a",name];
    NSURL *url = [NSURL URLWithString:urlString];
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[WXConditionModel class] fromJSONDictionary:json error:nil];
    }];
}

@end

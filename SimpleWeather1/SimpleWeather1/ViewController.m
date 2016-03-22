//
//  ViewController.m
//  SimpleWeather1
//
//  Created by 王享 on 16/3/22.
//  Copyright © 2016年 王享. All rights reserved.
//

#import "ViewController.h"
#import "TSMessage.h"
#import "ReactiveCocoa.h"
#import "WXConditionViewModel.h"
#import "WXWeatherModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (weak, nonatomic) IBOutlet UILabel *hiloLabel;

@property (nonatomic, strong) WXConditionViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TSMessage setDefaultViewController:self];
    self.viewModel = [[WXConditionViewModel alloc]init];
    RAC(self.viewModel,name) = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"chengdu"];
        return nil;
    }];
    [self bindViewModel];
}

-(void)bindViewModel{
    [[RACObserve(self.viewModel, currentCondition)
        deliverOn:[RACScheduler mainThreadScheduler]]subscribeNext:^(WXConditionModel *model) {
        _temperatureLabel.text = [NSString stringWithFormat:@"%.0f°",model.temperature.floatValue];
        _cityLabel.text = [model.locationName capitalizedString];
        WXWeatherModel *weather = [self.viewModel.currentCondition.weather objectAtIndex:0];
        _conditionsLabel.text = [weather.weatherDescription capitalizedString];
        _iconView.image = [UIImage imageNamed:[weather imageName]];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

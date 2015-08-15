//
//  NearWeiboMapViewController.m
//  CustomWeibo
//
//  Created by wangx on 15/8/14.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "NearWeiboMapViewController.h"
#import "Constant.h"
#import "Status.h"
#import "MJExtension.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"

@implementation NearWeiboMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager=[[CLLocationManager alloc]init];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    self.locationManager.delegate=self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

#pragma  mark - CLLocationDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [manager stopUpdatingLocation];
    CLLocation *newLocation=[locations lastObject];
    
    MKCoordinateSpan span = {0.1,0.2};
    MKCoordinateRegion region = {newLocation.coordinate,span};
    [self.mapView setRegion:region animated:YES];
    
    if (self.data==nil) {
        float longitude=newLocation.coordinate.longitude;
        float latitude=newLocation.coordinate.latitude;
        
        NSString *longitudeString=[NSString stringWithFormat:@"%f",longitude];
        NSString *latitudeString=[NSString stringWithFormat:@"%f",latitude];
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:longitudeString ,@"long" ,latitudeString ,@"lat",nil];
        [WBHttpRequest requestWithURL:WB_nearByWeibo httpMethod:@"GET" params:params delegate:self withTag:@"nearByWeibo"];
    }
}
#pragma mark WBHttpRequestDelegate
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
    NSDictionary *weiboDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *WeiboInfo = [weiboDIC objectForKey:@"statuses"];
    
    NSMutableArray *weibos = [ NSMutableArray arrayWithCapacity:WeiboInfo.count];
    int i = 0;
    for (NSDictionary *statuesDic in WeiboInfo) {
        i++;
        Status *weibo=[Status objectWithKeyValues:statuesDic];
        [weibos addObject:weibo];
        
        //创建Annotation对象，添加到地图上去
        WeiboAnnotation *weiboAnnotation=[[WeiboAnnotation alloc]initWithWeibo:weibo];
        [self.mapView performSelector:@selector(addAnnotation:) withObject:weiboAnnotation afterDelay:i*0.1];
        [self.mapView addAnnotation:weiboAnnotation];
     }
    
}

#pragma mark - MKAnnotationView delegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identifier=@"WeiboAnnotionView";
    WeiboAnnotationView *annotationView=(WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView==nil) {
         annotationView = [[WeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{

    for (UIView *annotationView in views) {
        CGAffineTransform transform = annotationView.transform;
        annotationView.transform = CGAffineTransformScale(transform, 0.7, 0.7);
        annotationView.alpha = 0;
        
        [UIView animateWithDuration:0.3 animations:^{
            annotationView.transform = CGAffineTransformScale(transform, 1.2, 1.2);
            annotationView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                annotationView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

#pragma mark-system Method
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

//
//  ViewController.m
//  MYbaiduMap
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 zhiyou. All rights reserved.
//

#import "ViewController.h"
#import "Global.h"
@interface ViewController ()<BMKMapViewDelegate,CLLocationManagerDelegate>
{
    BMKMapView* mapView;
    CLLocationManager *_cllocation;
    //BMKClusterManager *_clusterManager;//点聚合管理类
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden=NO;
     mapView = [[BMKMapView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    mapView.mapType=BMKMapTypeStandard;
    //[mapView setTrafficEnabled:YES];
    self.view = mapView;
    
    //_clusterManager = [[BMKClusterManager alloc] init];
    _cllocation=[[CLLocationManager alloc]init];
    _cllocation.delegate=self;
    [_cllocation requestWhenInUseAuthorization];
    [_cllocation startUpdatingLocation];
    
    
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{

    [locations enumerateObjectsUsingBlock:^(CLLocation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CLLocationCoordinate2D coors[4] = {0};
     
        coors[0].latitude = 39.315;
        coors[0].longitude = 116.304;
//        coors[1].latitude = 39.925;
//        coors[1].longitude = 116.454;
//        coors[2].latitude = 39.955;
//        coors[2].longitude = 116.494;
        coors[1].latitude = obj.coordinate.latitude;
        coors[1].longitude = obj.coordinate.longitude;
        NSLog(@"%f----%f",obj.coordinate.latitude,obj.coordinate.longitude);
//        NSArray *textureIndex = [NSArray arrayWithObjects:
//       [NSNumber numberWithInt:0],
//       [NSNumber numberWithInt:1],
//       [NSNumber numberWithInt:2],
//       [NSNumber numberWithInt:1], nil];
        
        
        BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:2 /*textureIndex:textureIndex*/];
        [mapView addOverlay:polyline];
    }];
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.lineWidth = 5.0;
        //polylineView.isFocus = YES;
        // 是否分段纹理绘制（突出显示），默认YES
        //加载分段纹理图片，必须否则不能进行分段纹理绘制
        polylineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        
         
         
        
        return polylineView;
    }
    return nil;
}
-(void)viewDidAppear:(BOOL)animated
{
    BMKPointAnnotation *annotation=[[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude=39.915;
    coor.longitude=116.404;
    annotation.coordinate=coor;
    annotation.title=@"这里是北京";
    [mapView addAnnotation:annotation];
}
-(void)viewWillAppear:(BOOL)animated
{
    [mapView viewWillAppear];
    mapView.delegate=self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [mapView viewWillDisappear];
    mapView.delegate=nil;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MyMapViewController.m
//  BeStronger
//
//  Created by Roy on 17/3/5.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "MyMapViewController.h"


@interface MyMapViewController ()<MAMapViewDelegate>
@property(strong,nonatomic) MAMapView *mapview;

@end

@implementation MyMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"跑步模式";
    //初始化地图view
    _mapview=[[MAMapView alloc]initWithFrame:self.contentView.bounds];
    //显示交通情况
    self.mapview.showTraffic=YES;
    [self.view addSubview:_mapview];
    NSLog(@"进来了");
    //[self showMyLocation];
    [self setMyMapType];
    [self takeSnapshot];
   // [self bigZhen];
    
    self.mapview.delegate=self;
    [self zhexian];
    
    
}

-(void)initMap
{
    //初始化地图view
    _mapview=[[MAMapView alloc]initWithFrame:self.view.bounds];
    //显示交通情况
    self.mapview.showTraffic=YES;
    [self.contentView addSubview:_mapview];
    NSLog(@"进来了");
    //[self showMyLocation];
    [self setMyMapType];
    [self takeSnapshot];
    // [self bigZhen];
    
    self.mapview.delegate=self;
    [self zhexian];


}

-(void)viewWillDisappear:(BOOL)animated
{
    self.mapview.showTraffic=NO;
}
//显示当前位置
-(void) showMyLocation
{
    _mapview.showsUserLocation=YES;
    _mapview.userTrackingMode=MAUserTrackingModeFollow;
}


//设置地图模式
-(void) setMyMapType
{
    //卫星模式
    //[_mapview setMapType:MAMapTypeSatellite];
    //设置底图为卫士模式下的夜间模式
    //[_mapview setMapType:MAMapTypeStandardNight];
    [_mapview setMapType:MAMapTypeBus];


}


//地图截屏功能
-(void) takeSnapshot
{
    __block UIImage *screenshotImage = nil;
    __block NSInteger resState = 0;
//    [self.mapview  takeSnapshotInRect:inRect withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
//        screenshotImage = resultImage;
//        resState = state; // state表示地图此时是否完整，0-不完整，1-完整
//    }];
    [self.mapview takeSnapshotInRect:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
        screenshotImage=resultImage;
        resState=state;
    }];
}

//设置大头针  大头针标注MAPinAnnotationView，通过它可以设置大头针颜色、是否显示动画、是否支持长按后拖拽大头针改变坐标等。
#pragma mark 大头针
-(void) bigZhen
{

    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    
    [self.mapview addAnnotation:pointAnnotation];


}
#pragma mark 折线
//折线类为 MAPolyline，由一组经纬度坐标组成，并以有序序列形式建立一系列的线段.iOS SDK支持在3D矢量地图上绘制带箭头或有纹理等样式的折线，同时可设置折线端点和连接点的类型，以满足各种绘制线的场景。
-(void) zhexian
{
    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    
    //在地图上添加折线对象
    [self.mapview addOverlay: commonPolyline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 协议
//大头针协议 设置大头针样式
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{

    NSLog(@"大头针样式");
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

//折线
-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    NSLog(@"zhexian xie yi");
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        NSLog(@"overlay is comming in");
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:123 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        polylineRenderer.lineDash=YES;//绘制虚线
        
        return polylineRenderer;
    }
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.ø
}
*/

@end

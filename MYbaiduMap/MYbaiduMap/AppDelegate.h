//
//  AppDelegate.h
//  MYbaiduMap
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 zhiyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager *_mapManager;
    UINavigationController *navigationControl;
}
@property (strong, nonatomic) UIWindow *window;


@end


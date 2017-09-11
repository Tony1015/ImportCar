//
//  TNMacro.h
//  BaseProject
//
//  Created by Tony on 2017/8/4.
//  Copyright © 2017年 Tony. All rights reserved.
//

#ifndef TNMacro_h
#define TNMacro_h

#define tnHttpUrlPrefix @"http://39.108.157.18:8081/anke/client/"
//#define tnHttpUrlPrefix @"http://192.168.0.102:8081/anke/client/"

#define tnHttpUrlString(a) [tnHttpUrlPrefix stringByAppendingString:a]

#define tnUserInfoPath [tnDocumentPath stringByAppendingPathComponent:@"userInfo"]

#define tnMainColor tnColor(140, 108, 209, 1)
#define tnBackgroundColor tnColor(239, 239, 239, 1);





#define tnLogFunctionName TNLog(@"%s",__func__)

//调试日志用KKLog，生产日志用NSLog
#ifdef DEBUG
#define TNLog(FORMAT, ...)  fprintf(__stderrp,"%s %s:%d\t%s\t%s\n",__TIME__,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __FUNCTION__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define TNLog(FORMAT, ...)
#endif

#define tnScreenBounds   [UIScreen mainScreen].bounds
#define tnScreenScale    [UIScreen mainScreen].scale
#define tnScreenSize     tnScreenBounds.size
#define tnScreenWidth    tnScreenSize.width
#define tnScreenHeight   tnScreenSize.height

#define tnSplitWidth      (1/[UIScreen mainScreen].scale)


#define tnNavigationBarHight 44 //self.navigationController.navigationBar.frame.size.height
#define tnStatusBarHight 20//[[UIApplication sharedApplication] statusBarFrame].size.height
#define tnTabbarHeight 49 //self.tabBarController.tabBar.frame.size.height



#define tnRandomColor tnColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1)

#define tnColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define tnHexColor(hex)   [UIColor tn_colorWithHex:hex]
#define tnColorWhite [UIColor whiteColor]
#define tnColorRed [UIColor redColor]
#define tnColorGreen [UIColor greenColor]
#define tnColorBlue [UIColor blueColor]
#define tnColorYellow [UIColor yellowColor]
#define tnColorLightGray [UIColor lightGrayColor]
#define tnColorDarkGray [UIColor darkGrayColor]
#define tnColorBlack [UIColor blackColor]


#define tnSystemFont(size) [UIFont systemFontOfSize:size]
#define tnBoldFont(size)   [UIFont boldSystemFontOfSize:size]

#define tnWeakify(object)  autoreleasepool{} __weak __typeof(object) object##Weak = object;
#define tnStrongify(object) autoreleasepool{} __strong __typeof(object) object = object##Weak;
#define tnBlockify(object) autoreleasepool{} __block __typeof(object) object##Block = object;



#define tnCornerRadius(view,radius)\
[view.layer setCornerRadius:radius];\
[view.layer setMasksToBounds:YES];

//角度获取弧度
#define tnDegreesToRadian(x)      (M_PI * (x) / 180.0)
//弧度获取角度
#define tnRadianToDegrees(radian) ((radian) * 180.0 / M_PI)



//路径
#define tnDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]

#define tnDeviceSystemVersion      [[UIDevice currentDevice] systemVersion].floatValue //系统版本

#define tnApplication        [UIApplication sharedApplication]

#define tnKeyWindow          [UIApplication sharedApplication].keyWindow

#define tnAppWindow          [[UIApplication sharedApplication].delegate window]

#define tnAppDelegate        [UIApplication sharedApplication].delegate

#define tnUserDefaults       [NSUserDefaults standardUserDefaults]

#define tnNotificationCenter [NSNotificationCenter defaultCenter]

#define tnBundleId           [[NSBundle mainBundle] bundleIdentifier]

#define tnBundle             [NSBundle mainBundle]

#endif /* TNMacro_h */

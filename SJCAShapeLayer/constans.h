//
//  constans.h
//  SJCAShapeLayer
//
//  Created by SPIREJ on 2017/2/17.
//  Copyright © 2017年 SPIREJ. All rights reserved.
//

#ifndef constans_h
#define constans_h

#define kDeviceWidth            [[UIScreen mainScreen] bounds].size.width
#define kDeviceHeight           [[UIScreen mainScreen] bounds].size.height
#define KNaviewtionBarHeight    64

//16进制颜色转换成UIColor
#define ColorWithHex(hex,alph)  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:(alph)]
#define kVCViewBGColor          ColorWithHex(0xf7f7f8, 1)

#define kNavTitle               @"示例"

#endif /* constans_h */

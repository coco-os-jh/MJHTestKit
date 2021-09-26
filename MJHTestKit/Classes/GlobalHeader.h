//
//  GlobalHeader.h
//  Pods
//
//  Created by mjh on 2021/9/23.
//

@import SVProgressHUD;
@import Masonry;
#import <objc/runtime.h>

#ifndef GlobalHeader_h
#define GlobalHeader_h

#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
#define ScreenWidth  [[UIScreen mainScreen]bounds].size.width
#define KTopHeight   (KStatusBarHeight + 44)
#define KStatusBarHeight   (ScreenHeight >= 812.0 ? 44 : 20)
#define KbottomHeight (ScreenHeight >= 812.0 ? 34 : 0)
#define HEIGHTSCALE   1//(ScreenHeight - KTopHeight)/(736 - KTopHeight)
#define HEIGHTBILISCALE  1//(ScreenHeight)/(667)
#define WIDTHSCALE   1//(ScreenWidth)/(375)
#define WIDGHTSCALE   1//(ScreenWidth)/(414)
#define SafeAreaTopHeight KTopHeight
#define SafeAreaBottomHeight KbottomHeight

#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBA(r, g, b,a)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:a]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexAlpha(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)al]

#define gyennoBlack  HexRGB(0x343434)
#define gyennoGray   HexRGB(0x727272)
#define gyennoLightGray   HexRGB(0xe9e9e9)
#define gyennoLightGrayNew   HexRGB(0x999999)
#define kLineColor HexRGB(0xE3E6EA)

#define kColor1  HexRGB(0x5a7193)
#define kColor2  HexRGB(0x3c485a)
#define kColor3  HexRGB(0xff9c00)
#define kColor4  HexRGB(0xff3232)
#define kColor5  HexRGB(0x73a9ff)
#define kColor6  HexRGB(0xa5b1c6)
#define kColor7  HexRGB(0xE3E6EA)
#define kColor8  HexRGB(0xf3f3f3)
#define kColor9  HexRGB(0x50E3C2)
#define kColor11  HexRGB(0xC9E7FF)

#define SystemColor kColor1
#define SystemTitleColor kColor2
#define SystemTineColor kColor3
#define SystemRedColor kColor4
#define SystemNoticeColor kColor5
#define SystemDescColor kColor6
#define IMSenderBubbleColor kColor11
#define SystemLineColor kColor7
#define SystemBackgroundColor HexRGB(0xf9f9f9)

#define newDescColor HexRGB(0xc7c7c7)
#define subTitleColor HexRGB(0x9b9b9b)

#define documentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define roundCorner(view) view.layer.masksToBounds = YES;view.layer.cornerRadius = 5.0;
#define FONT(font) [UIFont systemFontOfSize:font]
#define PingFangSCRegularFont(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize]
#define PingFangSCMediumFont(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]
#define PingFangSCSemiboldFont(fontSize) [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize]
#define PingFangHKRegularFont(fontSize) [UIFont fontWithName:@"PingFangHK-Regular" size:fontSize]
#define PingFangSCLightFont(fontSize) [UIFont fontWithName:@"PingFangSC-Light" size:fontSize]

#define TINEFONT(font) [UIFont systemFontOfSize:font weight:UIFontWeightThin]
#define BOLDFONT(font) [UIFont boldSystemFontOfSize:font]
#define IMAGE(name) [UIImage imageNamed:name]
#define proportion ((ScreenWidth - 414)<0?1:1.22)
#define sixScale ((ScreenWidth - 414)<0?0.9:1)
#define USERDEFAULT(key,value) [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];[[NSUserDefaults standardUserDefaults] synchronize];
#define GETUSERDEFAULT(key) [[NSUserDefaults standardUserDefaults]objectForKey:key]

#endif /* GlobalHeader_h */

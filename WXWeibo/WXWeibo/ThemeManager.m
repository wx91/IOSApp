//
//  ThemeManager.m
//  WXWeibo
//
//  Created by wangx on 15/7/28.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import "ThemeManager.h"
#import "Constant.h"
static ThemeManager *sigleton=nil;

@implementation ThemeManager

+(ThemeManager *)shareInstance{
    if(sigleton==nil){
        @synchronized(self){
            sigleton=[[ThemeManager alloc]init];
        }
    }
    return sigleton;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        NSString *themePath=[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themePlist=[[NSDictionary alloc]initWithContentsOfFile:themePath];
        //默认为空
        self.themeName=nil;
    }
    return self;
}
#pragma  mark overwrite  setter
//切换主题时，会调用此方法设置主题
-(void)setThemeName:(NSString *)themeName{
    if (_themeName!=themeName) {
        [_themeName release];
        _themeName=[themeName copy];
    }
    NSString *themeDir=[self getThemePath];
    NSString *filePath=[themeDir stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist=[NSDictionary dictionaryWithContentsOfFile:filePath];
    
}
//获取目录
-(NSString *)getThemePath{
    if (self.themeName==nil) {
        //如果主题名称为空，则使用项目包括根目录下的默认主题
        NSString *resourePath=[[NSBundle mainBundle]resourcePath];
        return resourePath;
    }
    //获取主题路径,如Skins/blue
    NSString *themePath=[self.themePlist objectForKey:_themeName];
    //程序包的根路径
    NSString *resourePath=[[NSBundle mainBundle]resourcePath];
    //完整的主题包路径
    NSString *path=[resourePath stringByAppendingPathComponent:themePath];
    return path;
}

//返回当前主题下，图片名对应名称
-(UIImage *)getThemeImage:(NSString *)imageName{
    if (imageName.length==0) {
        return nil;
    }
    NSString *themePath=[self getThemePath];
    NSString *imagePath=[themePath stringByAppendingPathComponent:imageName];
    UIImage *image=[[UIImage alloc]initWithContentsOfFile:imagePath];
    return image;
}

-(UIColor *)getColorWithName:(NSString *)name{
    if (name.length==0) {
        return nil;
    }
    //返回三色值:如24，35，60
    NSString *rgb=[_fontColorPlist objectForKey:name];
    NSArray *rgbs=[rgb componentsSeparatedByString:@","];
    if (rgbs.count==3) {
        float r=[rgbs[0] floatValue];
        float g=[rgbs[1] floatValue];
        float b=[rgbs[2] floatValue];
        UIColor *color=Color(r, g, b, 1);
        return color;
    }
    return nil;
}
//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}

@end

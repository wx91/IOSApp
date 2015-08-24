//
//  NSString+Size.h
//  meituan
//
//  Created by wangx on 15/8/21.
//  Copyright (c) 2015年 wangx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(NSInteger)font;

@end

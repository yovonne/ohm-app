//
//  OCUtils.m
//  ohm
//
//  Created by 刘 朝仁 on 16/2/16.
//  Copyright © 2016年 刘 朝仁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OCUtils.h"
@implementation OCUtils
+ (NSStringDrawingOptions)stringDrawingOptions{
    return NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
}
@end
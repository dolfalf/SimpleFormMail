//
//  UIImage+Extension.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/24.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (id)renderImageNamed:(NSString *)name {
    
    UIImage *myImage = [UIImage imageNamed:name];
    return [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end

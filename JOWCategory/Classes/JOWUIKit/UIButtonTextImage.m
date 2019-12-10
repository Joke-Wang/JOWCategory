//
//  UIButtonTextImage.m
//  bimeiti
//
//  Created by Joke Wang on 2018/3/23.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import "UIButtonTextImage.h"

@implementation UIButtonTextImage

- (void)setzz_buttonStyle:(ZZButtonStyleType)zz_buttonStyle {
    _zz_buttonStyle = zz_buttonStyle;
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.hidden   = false;
    self.titleLabel.hidden  = false;
    
    if (self.zz_buttonStyle == ZZButtonStyleTypeTopImageAndBottomText) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, -self.imageView.frame.size.height, 0);
        // item.imageEdgeInsets = UIEdgeInsetsMake(-item.titleLabel.frame.size.height, 0, 0, -item.titleLabel.frame.size.width);
        // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
        self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, 0, 0, -self.titleLabel.intrinsicContentSize.width);
    } else if (self.zz_buttonStyle == ZZButtonStyleTypeLeftTextAndRightImage) {
        CGFloat a = self.titleLabel.frame.size.width;
        CGFloat b = self.imageView.frame.size.width;
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, a + 2, 0, - a - 2)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - b - 2, 0, b + 2)];
    } else if (self.zz_buttonStyle == ZZButtonStyleTypeLeftImageAndRightText) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, - 2, 0, 2)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
    } else if (self.zz_buttonStyle == ZZButtonStyleTypeText) {
        self.imageView.hidden = true;
        self.titleEdgeInsets = UIEdgeInsetsMake(0,  -self.imageView.frame.size.width, 0, 0);
    } else if (self.zz_buttonStyle == ZZButtonStyleTypeImage) {
        self.titleLabel.hidden = true;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.titleLabel.frame.size.width);
    } else {
        //    CGFloat a = self.titleLabel.frame.size.width;
        //    CGFloat b = self.imageView.frame.size.width;
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


@end

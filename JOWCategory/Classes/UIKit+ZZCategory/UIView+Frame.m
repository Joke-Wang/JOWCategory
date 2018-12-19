//
//  UIView+Frame.m
//  bimeiti
//
//  Created by Joke Wang on 2018/1/10.
//  Copyright © 2018年 com.bi.meiti. All rights reserved.
//

#import "UIView+Frame.h"

#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic,   copy) dispatch_block_t singleTapEvent;

@property (nonatomic,   copy) dispatch_block_t longTapEvent;

@end

@implementation UIView (Frame)

-(void)setLongTapEvent:(dispatch_block_t)longTapEvent{
    
    objc_setAssociatedObject(self, @selector(longTapEvent), longTapEvent, OBJC_ASSOCIATION_COPY);
    
}

-(dispatch_block_t)longTapEvent{
    
    return objc_getAssociatedObject(self,_cmd);
    
}

-(void)setSingleTapEvent:(dispatch_block_t)singleTapEvent{
    objc_setAssociatedObject(self, @selector(singleTapEvent), singleTapEvent, OBJC_ASSOCIATION_COPY);
}

-(dispatch_block_t)singleTapEvent{
    return objc_getAssociatedObject(self,_cmd);
}


- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)x{
    self.center = CGPointMake(x, self.center.y);
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)y{
    self.center = CGPointMake(self.center.x, y);
}

/** 获取最大x */
- (CGFloat)maxX{
    return self.x + self.width;
}
/** 获取最小x */
- (CGFloat)minX{
    return self.x;
}

/** 获取最大y */
- (CGFloat)maxY{
    return self.y + self.height;
}
/** 获取最小y */
- (CGFloat)minY{
    return self.y;
}

- (void)addSingleTapEvent:(dispatch_block_t)event{
    
    self.userInteractionEnabled = true;
    
    if (event) {
        self.singleTapEvent = event;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
}

- (void)longTapAction:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        !self.longTapEvent ? nil:self.longTapEvent();
    }else {
        
    }
    
}

- (void)singleTapAction:(UITapGestureRecognizer *)tap{
    
    !self.singleTapEvent ? nil:self.singleTapEvent();
    
}

-(CGRect (^)(UIView *))zz_getRelativeWindowFrame{
    
    return ^CGRect (UIView * subView) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGRect relativeframe = [subView convertRect:subView.bounds toView:window];
        return relativeframe;
    };
    
}

-(UIView *(^)(NSInteger))zz_getElementByTag{
    
    return ^ UIView*(NSInteger viewTag) {
        for (int i =0; i< self.subviews.count; i++) {
            UIView * subV = self.subviews[i];
            if (subV.tag == viewTag) {
                return subV;
            }
        }
        return nil;
    };
    
}



@end

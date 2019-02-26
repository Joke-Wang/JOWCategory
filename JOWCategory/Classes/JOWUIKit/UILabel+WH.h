//
//  UILabel+WH.h
//  PineLoan
//
//  Created by Joke Wang on 2016/12/9.
//  Copyright © 2016年 joke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WH)

/**
 * 根据已设置属性计算blabel宽度
 */
- (CGFloat)zz_labelWidth;

/**
 * 根据已设置属性计算label高度
 */
- (CGFloat)zz_labelHeight;

/**
 * 根据给定宽度计算label宽度
 */
- (CGFloat)zz_labelHeightWithWidth:(CGFloat)width;

/**
 * 给label内容添加行间距
 */
- (void)zz_changeLineSpaceWithSpace:(float)space;

/**
 * 给label内容添加字间距
 */
- (void)zz_changeWordSpaceWithSpace:(float)space;

/**
 * 给label内容添加行间距和字间距
 *
 * @param lineSpace 行间距
 * @param wordSpace 字间距
 */
- (void)zz_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end



/**
 * 数值变化的label
 */
@interface UILabel (TextNumber)

/**
 * 给label设置数值，带动画效果
 *
 * @param sender 将要显示的数值
 */
- (void)zz_setTextNumber:(NSString *)sender;


@end


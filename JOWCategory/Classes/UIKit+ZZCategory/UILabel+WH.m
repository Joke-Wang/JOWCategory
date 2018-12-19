//
//  UILabel+WH.m
//  PineLoan
//
//  Created by Joke Wang on 2016/12/9.
//  Copyright © 2016年 joke. All rights reserved.
//

#import "UILabel+WH.h"
#import "../Foundation+ZZCategory/NSString+ZZ.h"

@implementation UILabel (WH)

/**
 * 根据已设置属性计算blabel宽度
 */
- (CGFloat)zz_labelWidth {
    UIFont *font = self.font;
    NSString *text = self.text;
    
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, font.xHeight)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{ NSFontAttributeName : font }
                              context:nil].size.width + 1;
}

/**
 * 根据已设置属性计算label高度
 */
- (CGFloat)zz_labelHeight {
    return [self zz_labelHeightWithWidth:CGRectGetWidth(self.frame)];
}

/**
 * 根据给定宽度计算label宽度
 */
- (CGFloat)zz_labelHeightWithWidth:(CGFloat)width {
    UIFont *font = self.font;
    NSString *text = self.text;
    
    return [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName : font}
                              context:nil].size.height;
}

/**
 * 给label内容添加行间距
 */
- (void)zz_changeLineSpaceWithSpace:(float)space {
    
    [self zz_changeSpaceWithLineSpace:space WordSpace:0];
    
}

/**
 * 给label内容添加字间距
 */
- (void)zz_changeWordSpaceWithSpace:(float)space {
    
    [self zz_changeSpaceWithLineSpace:0 WordSpace:space];
    
}

/**
 * 给label内容添加行间距和字间距
 *
 * @param lineSpace 行间距
 * @param wordSpace 字间距
 */
- (void)zz_changeSpaceWithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    [attributedString addAttribute:NSKernAttributeName value:@(wordSpace) range:NSMakeRange(0, [labelText length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

@end


/**
 * 数值变化的label
 */
@implementation UILabel (TextNumber)

/**
 * 给label设置数值，带动画效果
 *
 * @param sender 将要显示的数值
 */
- (void)zz_setTextNumber:(NSString *)sender {
    __weak typeof(self) weakself = self;
    
    [NSString zz_setNumberFrom:self.text to:sender change:^(NSString *num) {
        weakself.text = num;
    }];
}




@end



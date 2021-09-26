//
//  UIView+Addtion.m
//  GyennoDoctor
//
//  Created by lmzqm on 2019/2/15.
//  Copyright © 2019 Gyenno. All rights reserved.
//

#import "UIView+Addtion.h"
#import "UIButton+Position.h"
#import "GlobalHeader.h"

@implementation UIView (Addtion)

#pragma mark ================= UIImageView =================

-(UIImageView*)getImageView{
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

-(void)shadowWithRadius:(CGFloat )radius opacity:(CGFloat)opacity shadowColor:(UIColor *)color {
    [self setNeedsLayout];
    [self layoutIfNeeded];

    
    self.layer.shadowColor = color.CGColor;//HexAlpha(0x7F7F7F,0.23).CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = opacity;//阴影透明度，默认0
    self.layer.shadowRadius = radius;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];

    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = 3;
    
    CGPoint topLeft      = self.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);

    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));

    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);


    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));

    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    
    //设置阴影路径
    self.layer.shadowPath = path.CGPath;
}

-(void)shaowView{
    [self shadowWithRadius:3 opacity:0.5];
}

-(void)shadowWithRadius:(CGFloat )radius opacity:(CGFloat)opacity{
    [self shadowWithRadius:radius opacity:opacity shadowColor:HexAlpha(0x7F7F7F,0.23)];
}

-(void)cornorRadios{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor whiteColor].CGColor;
    CGRect rect = self.bounds;
    layer.frame = rect;
    UIBezierPath *path = [UIBezierPath  bezierPathWithRoundedRect:rect cornerRadius:5*HEIGHTSCALE];
    layer.path = path.CGPath;
    [self.layer insertSublayer:layer atIndex:0];
                          
    
}

// jiang
-(UIImage *)createViewImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO,[UIScreen mainScreen].scale);
     CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:context];
    
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



-(UIImage *)gye_corner{
    return [self gye_drawRectWithRoundedCorner:5*HEIGHTSCALE borderWidth:0 borderColor:nil backGroundColor:nil];
}


- (UIImage *)gye_drawRectWithRoundedCorner:(CGFloat)radius
                               borderWidth:(CGFloat)borderWidth
                               borderColor:(UIColor *)borderColor
                           backGroundColor:(UIColor*)bgColor{
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
    
//    [self.layer renderInContext:contextRef];
    
    CGContextSetLineWidth(contextRef, borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGContextMoveToPoint(contextRef, width - halfBorderWidth, radius + halfBorderWidth);
    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(contextRef, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(contextRef, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}

-(UIImageView*)getImageViewWithImage:(UIImage*)image{
    UIImageView *imageView = [self getImageView];
    imageView.image = image;
    return imageView;
}

-(UIImageView*)getImageViewWithImageStr:(NSString*)imageStr{
    return  [self getImageViewWithImage:IMAGE(imageStr)];
}

#pragma mark ================= UILable =================

-(UILabel*)getLabelWithFont:(UIFont*)font textColor:(UIColor*)color{
    
    UILabel *label= [self getLabel];
    label.font = font;
    label.textColor = color;
    
    return label;
    
}

-(UILabel *)getLabel{
    
    UILabel *label = [UILabel new];
    return label;
}

- (UILabel *)addLabelWithTextColor:(UIColor *)textColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment)alignment {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = alignment;
    [self addSubview:label];
    return label;
}
- (UIImageView *)addIcon {
    UIImageView *icon = [[UIImageView alloc] init];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:icon];
    return icon;
}

#pragma mark ================= UIButton =================

-(UIButton *)getVerButtonWithImage:(NSString *)imagestr text:(NSString *)textStr{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setTitle:textStr forState:UIControlStateNormal];
    [btn setImage:IMAGE(imagestr) forState:UIControlStateNormal];
    
    
    [btn positionButtonImageAtPosition:ImagePositionTop withSpacing:7];
    return btn;
}


-(void)addTarget:(id)target action:(nullable SEL)action{
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer new] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    
}

#pragma mark ************ UITableView ************

-(UITableView *)getTableViewStyle:(UITableViewStyle)style{
    
    UITableView* _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:style];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 100*HEIGHTBILISCALE;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableView.backgroundColor = SystemBackgroundColor;
//    _tableView.emptyDataSetSource = self;
//    _tableView.emptyDataSetDelegate = self;
//    [self.view addSubview:_tableView];
    
    return _tableView;
}

- (UIView *)buildTextFieldRightView:(UIView *)view {
//    UIButton *button = [self buildButtonForRightView];
    //  封装一层
    if(@available(iOS 13,*)){
        UIView *rightView = [[UIView alloc] initWithFrame:view.bounds];
          [rightView addSubview:view];

          return rightView;
    }else{
        return view;
    }
    
  
}

@end

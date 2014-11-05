//
//  UIImageCategory.h
//  Exam
//
//  Created by  on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//是否是高清屏幕
#define ISIPHONERETINA ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
//是否是高清iPad屏幕
#define ISPADRETINA ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048,1536), [[UIScreen mainScreen] currentMode].size) : NO)

#define isRetina (isiPhoneRetina || isPadRetina)

@interface UIImage (UIImageCategory) 

# pragma mark ImageFitSize Category

//根据当前图片的大小，和需要显示的图片大小，得到同比例缩放后的大小
- (CGSize) sizeWithFitInSize : (CGSize)aSize;

//根据需要显示的图片大小，得到同比例缩放后的图片对象，支持高清缩放，即是高清屏幕时缩放的图片均为显示图片的两倍
- (UIImage *) imageWithFitInSize : (CGSize)aSize;

+ (UIImage *)imageWithFitInSize:(CGSize)aSize AndName:(NSString*)name;

//根据需要显示的图片大小，得到同比例缩放后的图片对象
- (UIImage *) imageWithOutRetinaFitInSize : (CGSize)aSize;

//根据尺寸的大小，让图片全部填充满
- (UIImage *)imageWithFillInSize : (CGSize)aSize;

//裁剪图片尺寸只获取中间显示部分
- (UIImage *)imageCorrectInSize : (CGSize)aSize;

//压缩图片并截图图片中间部分尺寸
- (CGSize)sizeCorrectInSize : (CGSize)aSize;

//根据想要的尺寸压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/*改变size*/
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;

/*垂直翻转*/
- (UIImage *)flipVertical;

/*水平翻转*/
- (UIImage *)flipHorizontal;

/*裁切*/
- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

/*修改透明度*/
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

@end

@implementation UIImage (UIImageCategory)

//裁剪图片尺寸只获取中间显示部分

- (UIImage *)imageCorrectInSize : (CGSize)aSize{
    if (aSize.width >= self.size.width && aSize.height >= self.size.height) {
        return self;
    }
    CGSize size ;
    size = [self sizeCorrectInSize:aSize];
    
    UIGraphicsBeginImageContext(aSize);
    
	float dWidth = (size.width - aSize.width)/2.0;
	float dHeight = (size.height - aSize.height)/2.0;
	
	CGRect rect = CGRectMake(dWidth, dHeight, aSize.width, aSize.height);
	[self drawInRect:rect];
	
	UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newing;
}
//压缩图片并截图图片中间部分尺寸
- (CGSize)sizeCorrectInSize : (CGSize)aSize{
    CGFloat scale;
    CGSize thisSize = self.size;
	CGSize newsize = thisSize;
    if ((thisSize.width/aSize.width)>=(thisSize.height/aSize.height)) {
        scale = (float)aSize.height/newsize.height;
        newsize.width *=scale;
        newsize.height *=scale;
    }
    else {
        scale = (float)aSize.width/newsize.width;
        newsize.width *=scale;
        newsize.height *=scale;
    }
    return newsize;
}

- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/***
 *  根据当前图片的大小，和需要显示的图片大小，得到同比例缩放后的大小
 **/

- (CGSize) sizeWithFitInSize : (CGSize)aSize{
    
    CGFloat scale;
    CGSize thisSize = self.size;
	CGSize newsize = thisSize;
	
    if ((thisSize.width/aSize.width)>=(thisSize.height/aSize.height)) {
        scale = (float)aSize.width/newsize.width;
        newsize.width *=scale;
        newsize.height *=scale;
    }
    else {
        scale = (float)aSize.height/newsize.height;
        
        newsize.width *=scale;
        newsize.height *=scale;
    }
	return newsize;
}


- (UIImage *)imageWithFillInSize : (CGSize)aSize{
    CGSize size ;
        size.width = aSize.width;
         size.height = aSize.height;

    UIGraphicsBeginImageContext(aSize);

	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	[self drawInRect:rect];
	
	UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newing;
    
}


/***
 *  根据需要显示的图片大小，得到同比例缩放后的图片对象，支持高清缩放，即是高清屏幕时缩放的图片均为显示图片的两倍
**/
- (UIImage *) imageWithFitInSize : (CGSize)aSize
{
    if (aSize.width >= self.size.width && aSize.height >= self.size.height) {
        return self;
    }
    CGSize size  = [self sizeWithFitInSize:CGSizeMake(aSize.width,aSize.height)];
//    CGSize size;
//    if (isRetina) {
//        size = [self sizeWithFitInSize:CGSizeMake(aSize.width * 2,aSize.height * 2)];
//    }
//    else{
//        size = [self sizeWithFitInSize:aSize];
//    }
    
	UIGraphicsBeginImageContext(aSize);
    
	float dWidth = (aSize.width - size.width)/2.0;
	//float dHeight = (aSize.height - size.height)/2.0;
	
	CGRect rect = CGRectMake(dWidth, 0, size.width, size.height);
    //NSLog(@"rect width %.2f  height %.2f",dWidth,dHeight);
	[self drawInRect:rect];
	
	UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newing;
}

+ (UIImage *)imageWithFitInSize:(CGSize)aSize AndName:(NSString *)name{
    
    UIImage *newImg = [UIImage imageNamed:name];
    
    newImg = [newImg imageWithFitInSize:aSize];
    
    return newImg;
}

//根据需要显示的图片大小，得到同比例缩放后的图片对象
- (UIImage *) imageWithOutRetinaFitInSize : (CGSize)aSize{
    if (aSize.width >= self.size.width && aSize.height >= self.size.height) {
        return self;
    }
    CGSize size = [self sizeWithFitInSize:aSize];
	UIGraphicsBeginImageContext(aSize);
	float dWidth = (aSize.width - size.width)/2.0;
	float dHeight = (aSize.height - size.height)/2.0;
	
	CGRect rect = CGRectMake(dWidth, dHeight, size.width, size.height);
	[self drawInRect:rect];
	
	UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newing;
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (UIImage *)flip:(BOOL)isHorizontal {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    } else {
        UIGraphicsBeginImageContext(rect.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);
    if (isHorizontal) {
        CGContextRotateCTM(ctx, M_PI);
        CGContextTranslateCTM(ctx, -rect.size.width, -rect.size.height);
    }
    CGContextDrawImage(ctx, rect, self.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)flipVertical {
    return [self flip:NO];
}

- (UIImage *)flipHorizontal {
    return [self flip:YES];
}

- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}

/*修改透明度*/
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

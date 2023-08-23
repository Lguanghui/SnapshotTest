//
//  ViewController.m
//  SnapshotTest
//
//  Created by 梁光辉 on 2023/8/22.
//

#import "ViewController.h"
@import UIKit;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [self drawImageWithView:[self getTargetView]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    // 图片写入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (UIView *)getTargetView {
    // drawViewHierarchyInRect 临界值 CGRectMake(0, 0, 2700, 1000);    // 超出后空白
    // [view.layer renderInContext:context]; 临界值 CGRect frame = CGRectMake(0, 0, 29000, 1000); // 超出后 App 崩溃，系统热重启（怀疑 GPU 内存爆了）。CGRectMake(0, 0, 29000, 1000) 处于崩溃边缘，杀死 App 或者让 App 进入后台时会导致系统热重启。超过这个尺寸之后，必崩
    CGRect frame = CGRectMake(0, 0, 2700, 1000);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    view.backgroundColor = UIColor.cyanColor;
    
    return view;
}

- (UIImage *)drawImageWithView:(UIView *)view {
    CGFloat imageWidth = view.frame.size.width;
    CGFloat imageHeight = view.frame.size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0.0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

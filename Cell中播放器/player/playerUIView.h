//
//  playerUIView.h
//  player
//
//  Created by gxtc on 16/9/14.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface playerUIView : UIView
@property(nonatomic,strong)UIImageView * tollView;

+(instancetype)initPlaverWithURL:(NSString *)url andFram:(CGRect)fram;

- (AVPlayer *)playerWithURL:(NSString *)url;


@end

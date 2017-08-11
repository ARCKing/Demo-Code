//
//  ViewController.m
//  UIImagePickerView
//
//  Created by gxtc on 16/8/29.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>


@property(nonatomic,retain)UIImagePickerController * picker;
@property(nonatomic,retain)UIImageView * imgView;
@property(nonatomic,retain) NSString * strPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 50, 160 *2, 90 * 2)];
    [self.view addSubview:self.imgView];
    
    
     NSUserDefaults * userDerfaults = [NSUserDefaults standardUserDefaults];
    self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[userDerfaults objectForKey:@"picPath"]]];
    
    
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIAlertController * alerate = [UIAlertController alertControllerWithTitle:@"图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
    
  [alerate addAction:[UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
      
      UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
      imagePicker.delegate = self;
      imagePicker.allowsEditing = YES;
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      
      [self presentViewController:imagePicker animated:YES completion:nil];
      self.picker = imagePicker;
      
  }]];
    
}
    [alerate addAction:[UIAlertAction actionWithTitle:@"本地图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        self.picker = imagePicker;
        
    }]];
    
    [self presentViewController:alerate animated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

   NSUserDefaults * userDerfaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"done");
    
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imgView.image = image;
    
    
    if ([userDerfaults objectForKey:@"picPath"] == nil) {
   _strPath = [[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"pic"];
    
    NSLog(@"path == %@",_strPath);
        
    }else{
        _strPath = [userDerfaults objectForKey:@"picPath"];
    
        NSLog(@"path == %@",_strPath);
    }
    
    
    [userDerfaults setObject:_strPath forKey:@"picPath"];
    
    NSData * data = UIImageJPEGRepresentation(image, 1);
    
    [data writeToFile:[userDerfaults objectForKey:@"picPath"] atomically:NO];
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

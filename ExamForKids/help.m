//
//  help.m
//  ExamForKids
//
//  Created by kaisya on 7/18/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import "help.h"
#import "UserData.h"

@interface help ()

@end

@implementation help

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *image = [UIImage imageNamed:@"help1"];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    int imageWidth,imageHeight,height;
    if (IPHONE6P) {
        NSLog(@"IPHONE6P");
        imageWidth = 414;
        imageHeight = 666;
        height = 60;
    }else if (IPHONE5){
        NSLog(@"IPHONE5");
        imageWidth = 320;
        imageHeight = 518;
        height = 58;
    }else if(IPHONE6){
        NSLog(@"IPHONE6");
        imageWidth = 375;
        imageHeight = 597;
        height = 65;
    }else{
        NSLog(@"IPHONEelse");
        imageWidth = 320;
        imageHeight = 428;
        height = 50;
    }

    imageview.frame = CGRectMake(0, height, imageWidth, imageHeight);
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

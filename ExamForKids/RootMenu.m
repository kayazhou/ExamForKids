//
//  RootMenu.m
//  ExamForKids
//
//  Created by kaisya on 7/10/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import "RootMenu.h"
#import "ContentOfExam.h"

@interface RootMenu ()

@end

@implementation RootMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectLeftAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;

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
-(void)selectLeftAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

- (IBAction)StartUnderTen:(id)sender {
    ContentOfExam *secondView = [[ContentOfExam alloc] init];
    [self.navigationController pushViewController:secondView animated:YES];
    secondView.title = @"Second View";
}
@end

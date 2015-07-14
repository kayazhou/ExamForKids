//
//  ContentOfExam.m
//  ExamForKids
//
//  Created by kaisya on 7/10/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import "ContentOfExam.h"
#import "AppDelegate.h"

@interface ContentOfExam () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *tableViewData;
    NSMutableArray *tableData;
    NSMutableArray *tableDataResult;
}
extern BOOL addition;
extern BOOL subtraction;
extern BOOL underTen;
extern BOOL underHundred;

@end

@implementation ContentOfExam

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self dataInit];
//    for (NSObject *object in tableViewData) {
//        NSLog(@"数组对象:%@", object);
//    }
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    
    _tableView.separatorColor = [UIColor blueColor];
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataInit{
    BOOL style = 0;
    int randomFirst = 0,randomSecond = 0;
    NSString *content,*result;
    NSMutableArray *tableData = [NSMutableArray arrayWithCapacity:11];
    NSMutableArray *tableDataResult = [NSMutableArray arrayWithCapacity:11];
    for (int i = 0; i < 11; i++) {
        if (subtraction && addition) {
            style =arc4random() % 2;
        }
        if (subtraction && !addition) {
            style = 1;
        }
        if (!subtraction && addition) {
            style = 0;
        }
        if (!subtraction && !addition) {
            style =arc4random() % 2;
        }
        if (underTen && underHundred) {
            randomFirst = (arc4random() % 100) + 1;
            if (style) {
                randomSecond = (arc4random() % randomFirst) + 1;
            }else{
                randomSecond = (arc4random() % 100) + 1;
            }
        }
        if (!underTen && !underHundred) {
            randomFirst = (arc4random() % 100) + 1;
            if (style) {
                randomSecond = (arc4random() % randomFirst) + 1;
            }else{
                randomSecond = (arc4random() % 100) + 1;
            }
        }
        if (!underTen && underHundred) {
            randomFirst = (arc4random() % 100) + 1;
            if (style) {
                randomSecond = (arc4random() % randomFirst) + 1;
            }else{
                randomSecond = (arc4random() % 100) + 1;
            }
        }
        if (underTen && !underHundred) {
            randomFirst = (arc4random() % 10) + 1;
            if (style) {
                randomSecond = (arc4random() % randomFirst) + 1;
            }else{
                randomSecond = (arc4random() % 10) + 1;
            }
        }
        if (style) {
            content = [NSString stringWithFormat:@"%d - %d = ",randomFirst,randomSecond];
            result = [NSString stringWithFormat:@"%d",randomFirst-randomSecond];
        }else{
            content = [NSString stringWithFormat:@"%d + %d = ",randomFirst,randomSecond];
            result = [NSString stringWithFormat:@"%d",randomFirst+randomSecond];
        }

//        NSLog(@"content:%@",content);
        [tableData addObject:content];
        [tableDataResult addObject:result];
        for (NSObject * object in tableData) {
            NSLog(@"数组对象:%@", object);
        }
        
    }
    tableViewData = [tableData copy];
    NSLog(@"tableviewdata count is:%d",tableData.count);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
//    cell.textLabel.text = [tableViewData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [tableViewData objectAtIndex:indexPath.row];
    cell.detailTextLabel.textAlignment = UITextLayoutDirectionLeft;
    return cell;
}

@end

//
//  ContentOfExam.m
//  ExamForKids
//
//  Created by kaisya on 7/10/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import "ContentOfExam.h"
#import "AppDelegate.h"
#import "UserDataDesign.h"
#import "UserData.h"

@interface ContentOfExam () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *tableViewData;
    NSArray *tableViewDataResult;
    NSMutableArray *tableData;
    NSMutableArray *tableDataResult;
    NSDate *dateNow;
    int numberOfQuestion;
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
    
    // Format the datatime for timer
//    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    numberOfQuestion = 15;
//    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    [formatter setDateFormat:@"hh:mm:ss:SSS"];
    dateNow = [NSDate date];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"the time is :%@", timeLocal);
//    NSString *dateDiff = [[NSString alloc] compareCurrentTime:(NSDate *)date];
//    NSLog(@"the time is :%@", [self compareCurrentTime:date]);
    
//    [[Person alloc] initWithnam:(NSString *)xiaohong age:19];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(selectRightAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self dataInit];
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource=self;
    //设置代理
    _tableView.delegate=self;
    _tableView.scrollEnabled = NO;
    
    CGRect tableViewFrame = _tableView.frame;
//    tableViewFrame.size.width = 414;
//    tableViewFrame.size.height = 736;
    if (IPHONE6P) {
        NSLog(@"IPHONE6P");
        tableViewFrame.size.width = 414;
        tableViewFrame.size.height = 736;
    }else if (IPHONE5){
        NSLog(@"IPHONE5");
        tableViewFrame.size.width = 320;
        tableViewFrame.size.height = 568;
    }else if(IPHONE6){
        NSLog(@"IPHONE6");
        tableViewFrame.size.width = 375;
        tableViewFrame.size.height = 667;
    }else{
        NSLog(@"IPHONEelse");
        tableViewFrame.size.width = 320;
        tableViewFrame.size.height = 568;
    }
    _tableView.frame = tableViewFrame;

    _tableView.separatorColor = [UIColor blueColor];
    
    [self.view addSubview:_tableView];
}

+(NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    int temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"一分钟"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年",temp];
    }
    
    return  result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataInit{
    BOOL style = 0;
    int randomFirst = 0,randomSecond = 0;
    NSString *content,*result;
    NSMutableArray *tableData = [NSMutableArray arrayWithCapacity:numberOfQuestion];
    NSMutableArray *tableDataResult = [NSMutableArray arrayWithCapacity:numberOfQuestion];
    for (int i = 0; i < numberOfQuestion; i++) {
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

        [tableData addObject:content];
        [tableDataResult addObject:result];
    }
    tableViewData = [tableData copy];
    tableViewDataResult = [tableDataResult copy];
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
    return numberOfQuestion;
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

-(void)selectRightAction:(id)sender
{
    tableViewData = tableViewDataResult;
    [_tableView reloadData];
    self.navigationItem.rightBarButtonItem = nil;
}


@end

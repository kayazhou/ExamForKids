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
    NSDate * beginDate;
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
    
    numberOfQuestion = 10;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataInit{
    BOOL style = 0;
    BOOL style1 = 0;
    BOOL isThree = 0;
    int randomFirst = 0,randomSecond = 0,randomThird = 0;
    NSString *content,*result;
    beginDate = [NSDate date];
    NSLog(@"begin date is :%@",beginDate);

    tableData = [NSMutableArray arrayWithCapacity:numberOfQuestion];
    tableDataResult = [NSMutableArray arrayWithCapacity:numberOfQuestion];
    
    for (int i = 0; i < numberOfQuestion; i++) {
        isThree = arc4random() %2;
        if (isThree) {
            if (subtraction && !addition) {
                style = 1;
                style1 = 1;
            }else if (!subtraction && addition) {
                style = 0;
                style1 = 0;
            }else{
                style =arc4random() % 2;
                style1 =arc4random() % 2;
            }
            
            if (underTen && underHundred) {
                randomFirst = (arc4random() % 100) + 1;
                if (style) {
                    randomSecond = (arc4random() % randomFirst) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst - randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (100 - (randomFirst - randomSecond));
                    }
                }else{
                    randomSecond = (arc4random() % (100-randomFirst)) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst + randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (100 - (randomFirst + randomSecond - 1));
                    }
                }
            }
            if (!underTen && !underHundred) {
                randomFirst = (arc4random() % 100) + 1;
                if (style) {
                    randomSecond = (arc4random() % randomFirst) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst - randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (100 - (randomFirst - randomSecond));
                    }
                }else{
                    randomSecond = (arc4random() % (100-randomFirst)) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst + randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (100 - (randomFirst + randomSecond - 1));
                    }
                }
            }
            if (!underTen && underHundred) {
                randomFirst = (arc4random() % 100) + 1;
                if (style) {
                    randomSecond = (arc4random() % randomFirst) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst - randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (100 - (randomFirst - randomSecond));
                    }
                }else{
                    randomSecond = (arc4random() % (100-randomFirst)) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst + randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (100 - (randomFirst + randomSecond));
                    }
                }
            }
            if (underTen && !underHundred) {
                randomFirst = (arc4random() % 10) + 1;
                if (style) {
                    randomSecond = (arc4random() % randomFirst) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst - randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (10 - (randomFirst - randomSecond));
                    }
                }else{
                    randomSecond = (arc4random() % (10-randomFirst)) + 1;
                    if (style1) {
                        randomThird = arc4random() % (randomFirst + randomSecond + 1);
                    }else{
                        randomThird = arc4random() % (10 - (randomFirst + randomSecond));
                    }
                }
            }
            if (style) {
                if (style1) {
                    content = [NSString stringWithFormat:@"%d - %d - %d = ",randomFirst,randomSecond,randomThird];
                    result = [NSString stringWithFormat:@"%d - %d - %d = %d",randomFirst,randomSecond,randomThird,randomFirst-randomSecond-randomThird];
                }else{
                    content = [NSString stringWithFormat:@"%d - %d + %d = ",randomFirst,randomSecond,randomThird];
                    result = [NSString stringWithFormat:@"%d - %d + %d = %d",randomFirst,randomSecond,randomThird,randomFirst-randomSecond+randomThird];
                }
            }else{
                if (style1) {
                    content = [NSString stringWithFormat:@"%d + %d - %d = ",randomFirst,randomSecond,randomThird];
                    result = [NSString stringWithFormat:@"%d + %d - %d = %d",randomFirst,randomSecond,randomThird,randomFirst+randomSecond-randomThird];
                }else{
                    content = [NSString stringWithFormat:@"%d + %d + %d = ",randomFirst,randomSecond,randomThird];
                    result = [NSString stringWithFormat:@"%d + %d + %d = %d",randomFirst,randomSecond,randomThird,randomFirst+randomSecond+randomThird];
                }
            }
        }else{
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
                    randomSecond = (arc4random() % (101-randomFirst)) + 1;
                }
            }
            if (!underTen && !underHundred) {
                randomFirst = (arc4random() % 100) + 1;
                if (style) {
                    randomSecond = (arc4random() % randomFirst) + 1;
                }else{
                    randomSecond = (arc4random() % (101-randomFirst)) + 1;
                }
            }
            if (!underTen && underHundred) {
                randomFirst = (arc4random() % 100) + 1;
                if (style) {
                    randomSecond = (arc4random() % randomFirst) + 1;
                }else{
                    randomSecond = (arc4random() % (101-randomFirst)) + 1;
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
                result = [NSString stringWithFormat:@"%d - %d = %d",randomFirst,randomSecond,randomFirst-randomSecond];
            }else{
                content = [NSString stringWithFormat:@"%d + %d = ",randomFirst,randomSecond];
                result = [NSString stringWithFormat:@"%d + %d = %d",randomFirst,randomSecond,randomFirst+randomSecond];
            }
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
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.detailTextLabel.text = [tableViewData objectAtIndex:indexPath.row];
    cell.detailTextLabel.textAlignment = UITextLayoutDirectionLeft;
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:30];
    return cell;
}

-(void)selectRightAction:(id)sender
{
    tableViewData = tableViewDataResult;
    NSDate * tomorrowDate = [NSDate date];
    NSTimeInterval interval = [tomorrowDate timeIntervalSinceDate:beginDate];
    int diff = interval;
    [_tableView reloadData];
    self.navigationItem.title = [NSString stringWithFormat:@"%d秒",diff];

    self.navigationItem.rightBarButtonItem = nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IPHONE6P) {
        return 67.0f;
    }else if (IPHONE5){
        return 63.0f;
    }else if(IPHONE6){
        return 67.0f;
    }else{
        return 59.0f;
    }
}

@end

//
//  RootMenu.m
//  ExamForKids
//
//  Created by kaisya on 7/10/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import "RootMenu.h"
#import "ContentOfExam.h"
#import "UserDataDesign.h"
#import "UserData.h"
#import "sys/sysctl.h"
#import <MessageUI/MessageUI.h>
#import "help.h"

@interface RootMenu ()

<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>{
    UITableView *_tableView;
    NSMutableArray *_contacts;//联系人模型
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
    NSArray *tableViewData;
    NSMutableArray *tableData;
    int numberOfQuestion;
    NSString *letterResult;
}
extern BOOL addition;
extern BOOL subtraction;
extern BOOL underTen;
extern BOOL underHundred;

@end

@implementation RootMenu


- (void)viewDidLoad {
    [super viewDidLoad];
    addition = NO;
    subtraction = NO;
    underTen = NO;
    underHundred = NO;
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectLeftAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(selectRightAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self initData];
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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

    [self.view addSubview:_tableView];
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
-(void)selectRightAction:(id)sender
{
    ContentOfExam *secondView = [[ContentOfExam alloc] init];
    [self.navigationController pushViewController:secondView animated:YES];
    secondView.title = @"Timing begins";
}
-(void)selectHelpAction{
    help *thirdView = [[help alloc] init];
    [self.navigationController pushViewController:thirdView animated:YES];
    thirdView.title = @"How to use?";
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    TableViewCell *group=_contacts[indexPath.section];
    UserData *contact=group.name[indexPath.row];
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=[contact getName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Selected section %lu, cell %lu",
//          (unsigned long)[indexPath indexAtPosition: 0],
//          (unsigned long)[indexPath indexAtPosition: 1 ]);
    if ([indexPath indexAtPosition: 0] == 0 && [indexPath indexAtPosition: 1 ] == 0) {
        addition = !addition;
    }
    if ([indexPath indexAtPosition: 0] == 0 && [indexPath indexAtPosition: 1 ] == 1) {
        subtraction = !subtraction;
    }
    if ([indexPath indexAtPosition: 0] == 1 && [indexPath indexAtPosition: 1 ] == 0) {
        underTen = !underTen;
    }
    if ([indexPath indexAtPosition: 0] == 1 && [indexPath indexAtPosition: 1 ] == 1) {
        underHundred = !underHundred;
    }
    if ([indexPath indexAtPosition: 0] == 2 && [indexPath indexAtPosition: 1 ] == 0) {
        [self selectHelpAction];
    }
    
    /* 得到选中的表格单元的指针 */
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath: indexPath ];
//    NSLog(@"点击的数是：%@",indexPath);
    
    /* 切换附件的类型 */
    if (cell.accessoryType == UITableViewCellAccessoryNone)
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    
}

-(void)initData{
    _contacts=[[NSMutableArray alloc]init];
    
    UserData *contact1=[UserData initWithName:@"Addition"];
    UserData *contact2=[UserData initWithName:@"Subtraction"];
    TableViewCell *group1=[TableViewCell initWithGroupName:@"level" andDetail:@"select level for exam" andName:[NSMutableArray arrayWithObjects:    contact1,contact2, nil]];
    [_contacts addObject:group1];
    
    UserData *contact3=[UserData initWithName:@"0-10"];
    UserData *contact4=[UserData initWithName:@"0-100"];
    TableViewCell *group2=[TableViewCell initWithGroupName:@"Style" andDetail:@"select style for exam" andName:[NSMutableArray arrayWithObjects:contact3,contact4, nil]];
    [_contacts addObject:group2];
    
    UserData *contact5=[UserData initWithName:@"How to use?"];
    TableViewCell *group3=[TableViewCell initWithGroupName:@"Style" andDetail:@"Help" andName:[NSMutableArray arrayWithObjects:contact5, nil]];
    [_contacts addObject:group3];
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"计算分组数");
    return _contacts.count;
}
#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"计算每组(组%li)行数",(long)section);
    TableViewCell *group1=_contacts[section];
    return group1.name.count;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"生成组（组%li）名称",(long)section);
    TableViewCell *group=_contacts[section];
//    NSLog(@"%@",group.groupName);
    return group.groupName;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    NSLog(@"生成尾部（组%li）详情",(long)section);
    TableViewCell *group=_contacts[section];
    return group.detail;
}

#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 50;
    }
    return 40;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

#pragma mark 切换开关转化事件
-(void)switchValueChange:(UISwitch *)sw{
//    NSLog(@"section:%li,switch:%i",(long)sw.tag, sw.on);
}


-(void)selectLeftAction:(id)sender
{
    if (![MFMailComposeViewController canSendMail]) {
        return;
    }
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    
    [controller setSubject:@"Come On Junior"];
    [self dataInit];
    [controller setMessageBody:letterResult isHTML:YES];
    
    [controller setMailComposeDelegate:self];
    
    // 显示控制器
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dataInit{
    BOOL style = 0;
    int randomFirst = 0,randomSecond = 0;
    NSString *content;
    tableData = [NSMutableArray arrayWithCapacity:numberOfQuestion];
    for (int i = 0; i < 30; i++) {
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
                randomSecond = (arc4random() % (100-randomFirst)) + 1;
            }
        }
        if (!underTen && !underHundred) {
            randomFirst = (arc4random() % 100) + 1;
            if (style) {
                randomSecond = (arc4random() % randomFirst) + 1;
            }else{
                randomSecond = (arc4random() % (100-randomFirst)) + 1;
            }
        }
        if (!underTen && underHundred) {
            randomFirst = (arc4random() % 100) + 1;
            if (style) {
                randomSecond = (arc4random() % randomFirst) + 1;
            }else{
                randomSecond = (arc4random() % (100-randomFirst)) + 1;
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
        }else{
            content = [NSString stringWithFormat:@"%d + %d = ",randomFirst,randomSecond];
        }
        [tableData addObject:content];
    }
    tableViewData = [tableData copy];
    letterResult = [tableViewData componentsJoinedByString:@"</p>"];
}


@end

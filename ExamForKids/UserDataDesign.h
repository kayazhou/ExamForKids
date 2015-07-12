//
//  DataDesign.h
//  ExamForKids
//
//  Created by kaisya on 7/11/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef ExamForKids_DataDesign_h
#define ExamForKids_DataDesign_h

@interface TableViewCell : NSObject

#pragma mark 组名
@property (nonatomic,copy) NSString *groupName;

#pragma mark 分组描述
@property (nonatomic,copy) NSString *detail;

#pragma mark 分项名称
@property (nonatomic,strong) NSMutableArray *name;

#pragma mark 带参数个构造函数
-(TableViewCell *)initWithGroupName:(NSString *)groupname andDetail:(NSString *)detail andName:(NSMutableArray *)name;

#pragma mark 静态初始化方法
+(TableViewCell *)initWithGroupName:(NSString *)groupname andDetail:(NSString *)detail andName:(NSMutableArray *)name;

@end

#endif

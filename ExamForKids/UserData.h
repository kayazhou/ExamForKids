//
//  UserData.h
//  ExamForKids
//
//  Created by kaisya on 7/11/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

#pragma mark 内容
@property (nonatomic,copy) NSString *name;

#pragma mark 带参数的构造函数
-(UserData *)initWithName:(NSString *)name;

#pragma mark 取得姓名
-(NSString *)getName;


#pragma mark 带参数的静态对象初始化方法
+(UserData *)initWithName:(NSString *)name;
@end
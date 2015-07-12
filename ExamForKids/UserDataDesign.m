//
//  UserDataDesign.m
//  ExamForKids
//
//  Created by kaisya on 7/11/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import "UserDataDesign.h"

@implementation TableViewCell

-(TableViewCell *)initWithGroupName:(NSString *)groupname andDetail:(NSString *)detail andName:(NSMutableArray *)name{
    if (self=[super init]) {
        self.groupName=groupname;
        self.detail=detail;
        self.name=name;
    }
    return self;
}

+(TableViewCell *)initWithGroupName:(NSString *)groupname andDetail:(NSString *)detail andName:(NSMutableArray *)name{
    TableViewCell *group1=[[TableViewCell alloc]initWithGroupName:groupname andDetail:detail andName:name];
    return group1;
}
@end
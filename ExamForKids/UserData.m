//
//  UserData.m
//  ExamForKids
//
//  Created by kaisya on 7/11/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import "UserData.h"

@implementation UserData

-(UserData *)initWithName:(NSString *)name{
    if(self=[super init]){
        self.name=name;
    }
    return self;
}

-(NSString *)getName{
    return [NSString stringWithFormat:@"%@",_name];
}

+(UserData *)initWithName:(NSString *)name{
    UserData *contact1=[[UserData alloc]initWithName:name];
    return contact1;
}

@end

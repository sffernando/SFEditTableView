//
//  STPersonBean.m
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/18.
//  Copyright © 2015年 fernando. All rights reserved.
//

#import "STPersonBean.h"

@implementation STPersonBean

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sf_PersonDesc = @"";
        _sf_PersonId = @"";
        _sf_PersonName = @"";
    }
    return self;
}

- (id)initDataWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if (dic) {
            if ([dic objectForKey:@"name"]) {
                _sf_PersonName = [dic objectForKey:@"name"];
            }
            
            if ([dic objectForKey:@"id"]) {
                _sf_PersonId = [dic objectForKey:@"id"];
            }
            
            if ([dic objectForKey:@"description"]) {
                _sf_PersonDesc = [dic objectForKey:@"description"];
            }
        }
    }
    return self;
}

@end

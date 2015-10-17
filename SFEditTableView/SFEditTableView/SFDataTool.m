//
//  SFDataTool.m
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/17.
//  Copyright © 2015年 fernando. All rights reserved.
//

#import "SFDataTool.h"

@implementation SFDataTool

+ (NSMutableArray *)sf_tableViewDataSourceWithCount:(int)count{
    if (count < 1) {
        count = 10;
    }
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < count; i ++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        [tempDic setValue:[NSString stringWithFormat:@"sf_editTable%hu",[[self class] singleCharacterForStringWithIndex:i]] forKey:@"name"];
        [tempDic setValue:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
        
        [tempDic setValue:[NSString stringWithFormat:@"%d_love you like a song",i] forKey:@"description"];
        
        [tempArray addObject:tempDic];
    }
    
    for (int j = 0; j < tempArray.count; j ++) {
        NSDictionary *dic = [tempArray objectAtIndex:j];
        STPersonBean *personBean = [[STPersonBean alloc] initDataWithDic:dic];
        [dataArray addObject:personBean];
    }
    
    return dataArray;
    
}

+ (unichar)singleCharacterForStringWithIndex:(NSInteger)index{
    NSString *string = @"abcdefghijklmnopqrstuvwxyz";
    unichar c = [string characterAtIndex:index];
    return c;
}

@end

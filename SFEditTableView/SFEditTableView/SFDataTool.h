//
//  SFDataTool.h
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/17.
//  Copyright © 2015年 fernando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPersonBean.h"

@interface SFDataTool : NSObject

+ (NSMutableArray *)sf_tableViewDataSourceWithCount:(int)count;

@end

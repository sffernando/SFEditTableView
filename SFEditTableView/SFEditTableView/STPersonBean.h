//
//  STPersonBean.h
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/18.
//  Copyright © 2015年 fernando. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STPersonBean : NSObject

@property (nonatomic, copy) NSString *sf_PersonName;
@property (nonatomic, copy) NSString *sf_PersonId;
@property (nonatomic, copy) NSString *sf_PersonDesc;

- (id)initDataWithDic:(NSDictionary *)dic;

@end

//
//  STEditTableViewCell.h
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/19.
//  Copyright © 2015年 fernando. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPersonBean.h"

@interface STEditTableViewCell : UITableViewCell

- (void)setCellDataWithBean:(STPersonBean *)bean;

@end

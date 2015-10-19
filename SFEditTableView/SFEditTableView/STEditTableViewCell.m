//
//  STEditTableViewCell.m
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/19.
//  Copyright © 2015年 fernando. All rights reserved.
//

#import "STEditTableViewCell.h"

@interface STEditTableViewCell (){
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *descLabel;
}

@end

@implementation STEditTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCellDataWithBean:(STPersonBean *)bean{
    [self.contentView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    nameLabel.text = bean.sf_PersonName;
    descLabel.text = bean.sf_PersonDesc;
}
@end

//
//  ViewController.m
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/12.
//  Copyright (c) 2015年 fernando. All rights reserved.
//

#import "ViewController.h"
#import "SFDataTool.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *sfTableView;
@property (nonatomic, strong) NSMutableArray *sfDataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _sfTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _sfTableView.delegate = self;
    _sfTableView.dataSource = self;
    [self.view addSubview:_sfTableView];
    
    if (_sfDataArray == nil) {
        _sfDataArray = [SFDataTool sf_tableViewDataSourceWithCount:20];
    }
    
    [_sfTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UITableView *)sfTableView{
//    if (_sfTableView == nil) {
//        _sfTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
//    }
//    return _sfTableView;
//}
//
//- (NSMutableArray *)sfDataArray{
//    if (_sfDataArray == nil) {
//        _sfDataArray = [SFDataTool sf_tableViewDataSourceWithCount:20];
//    }
//    return _sfDataArray;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sfDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SFTableCell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    UITableViewCell *cell = [_sfTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    
    // Configure the cell...
    
    STPersonBean *personBean = [_sfDataArray objectAtIndex:row];
    
    cell.detailTextLabel.text = personBean.sf_PersonDesc;
    cell.textLabel.text = personBean.sf_PersonName;
    return cell;
}

@end

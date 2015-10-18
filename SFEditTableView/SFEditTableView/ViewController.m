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
@property (nonatomic, strong) UIButton       *editBtn;
@property (nonatomic, assign) BOOL           isEditMode;

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
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(self.view.frame.size.width - 80, 17, 80, 30);
    [_editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(clickToEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editBtn];
    
    
    [_sfTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickToEdit{
    _isEditMode = !_isEditMode;
    [_sfTableView setEditing:_isEditMode animated:YES];
}

#pragma mark - UITableViewDataSource
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


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Edit Mode
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone; // No Delete icon
    
    
    
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Can move cell
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSUInteger origins = sourceIndexPath.row;  // Original position
    NSUInteger to = destinationIndexPath.row; // Destination position
    NSLog(@"Origin %lu, To %lu", (unsigned long)origins, (unsigned long)to);
    
    [_sfDataArray exchangeObjectAtIndex:origins withObjectAtIndex:to];
}

@end

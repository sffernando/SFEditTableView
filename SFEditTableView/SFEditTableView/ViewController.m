//
//  ViewController.m
//  SFEditTableView
//
//  Created by  张亚斌 on 15/10/12.
//  Copyright (c) 2015年 fernando. All rights reserved.
//

#import "ViewController.h"
#import "SFDataTool.h"
#import "STEditTableViewCell.h"

static NSString *cellIdentifier = @"STEditTableViewCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>{
    UILongPressGestureRecognizer *longPress;
}

@property (nonatomic, strong) UITableView *sfTableView;
@property (nonatomic, strong) NSMutableArray *sfDataArray;
@property (nonatomic, strong) UIButton       *editBtn;
@property (nonatomic, assign) BOOL           isEditMode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _sfTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    [_sfTableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    _sfTableView.delegate = self;
    _sfTableView.dataSource = self;
    [self.view addSubview:_sfTableView];
    
    
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    longPress.delegate = self;
    [_sfTableView addGestureRecognizer:longPress];
    
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
    [_sfTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sfDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

//编辑的时候是否缩进
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [_sfTableView registerClass:[STEditTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    STEditTableViewCell *cell = [_sfTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    // Configure the cell...
    if (_sfDataArray.count > indexPath.row) {
        STPersonBean *personBean = [_sfDataArray objectAtIndex:indexPath.row];
        [cell setCellDataWithBean:personBean];
    }
    
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

- (IBAction)longPressGestureRecognized:(id)sender {
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:_sfTableView];
    NSIndexPath *indexPath = [_sfTableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [_sfTableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [_sfTableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [_sfDataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [_sfTableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
                
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [_sfTableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}

- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (_isEditMode) {
        CGPoint location = [gestureRecognizer locationInView:_sfTableView];
        if (location.x <= (self.view.frame.size.width - 36)) {
            return YES;
        }else{
            return NO;
        }
    }
    return NO;
}



@end

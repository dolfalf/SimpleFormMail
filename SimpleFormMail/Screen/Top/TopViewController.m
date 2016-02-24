//
//  TopViewController.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/23.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "TopViewController.h"
#import "StoryboardUtil.h"
#import "UIImage+Extension.h"

#import <objc/message.h>

@interface TopViewTableCell ()

@property (nonatomic, assign) id tar_send;
@property (nonatomic, assign) id tar_copy;
@property (nonatomic, assign) id tar_edit;
@property (nonatomic, assign) SEL sel_send;
@property (nonatomic, assign) SEL sel_copy;
@property (nonatomic, assign) SEL sel_edit;

@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, weak) IBOutlet UIButton *copynewButton;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, weak) IBOutlet UIView *buttonContainerView;
@end

@implementation TopViewTableCell

- (void)awakeFromNib {
    
    [_sendButton setImage:[UIImage renderImageNamed:@"icon_send"]
                 forState:UIControlStateNormal];
    [_copynewButton setImage:[UIImage renderImageNamed:@"icon_copy"]
                    forState:UIControlStateNormal];
    [_editButton setImage:[UIImage renderImageNamed:@"icon_edit"]
                 forState:UIControlStateNormal];
    
}

- (void)addTarget:(id)target sendButtonTouched:(SEL)action {
    self.tar_send = target;
    self.sel_send = action;
}

- (void)addTarget:(id)target copyButtonTouched:(SEL)action {
    self.tar_copy = target;
    self.sel_copy = action;
}

- (void)addTarget:(id)target editButtonTouched:(SEL)action {
    self.tar_edit = target;
    self.sel_edit = action;
}

- (IBAction)sendButtonTouched:(id)sender {
    if (_tar_send != nil && [_tar_send respondsToSelector:_sel_send]) {
        [_tar_send performSelector:_sel_send withObject:self afterDelay:0.f];
    }
}

- (IBAction)copyButtonTouched:(id)sender {
    if (_tar_copy != nil && [_tar_copy respondsToSelector:_sel_copy]) {
        [_tar_send performSelector:_sel_copy withObject:self afterDelay:0.f];
    }
}

- (IBAction)editButtonTouched:(id)sender {
    if (_tar_edit != nil && [_tar_edit respondsToSelector:_sel_edit]) {
        [_tar_edit performSelector:_sel_edit withObject:self afterDelay:0.f];
    }
}

@end

#pragma mark - TopViewController Class
@interface TopViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) TopViewTableCell *stubCell;   //高さ計算用セルの生成
@end

@implementation TopViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Simple Form";
    
    [self initControls];
    
    //REMARK: Add sectino
    self.items = @[
                   @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sodales diam sed turpis mattis dictum. In laoreet porta eleifend. Ut eu nibh sit amet est iaculis faucibus.",
                   @"initWithBitmapDataPlanes:pixelsWide:pixelsHigh:bitsPerSample:samplesPerPixel:hasAlpha:isPlanar:colorSpaceName:bitmapFormat:bytesPerRow:bitsPerPixel:",
                   @"祇辻飴葛蛸鯖鰯噌庖箸",
                   @"Nam in vehicula mi.",
                   @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
                   @"あのイーハトーヴォの\nすきとおった風、\n夏でも底に冷たさをもつ青いそら、\nうつくしい森で飾られたモーリオ市、\n郊外のぎらぎらひかる草の波。",
                   ];
    
    //高さ計算用セルの生成
    self.stubCell = [self.mainTableView dequeueReusableCellWithIdentifier:@"Cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - private methods
- (void)initControls {
    
    UIBarButtonItem *setting_button = [[UIBarButtonItem alloc] initWithImage:[UIImage renderImageNamed:@"icon_setting"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(settingButtonTouched:)];
    
    setting_button.tintColor = [UIColor grayColor];
    
    UIBarButtonItem *add_button = [[UIBarButtonItem alloc] initWithImage:[UIImage renderImageNamed:@"icon_plus"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(addButtonTouched:)];
    
    add_button.tintColor = [UIColor grayColor];
    
    self.navigationItem.leftBarButtonItems = @[setting_button];
    self.navigationItem.rightBarButtonItems = @[add_button];
}

#pragma mark - IBAction
- (void)settingButtonTouched:(id)sender {
    
    [StoryboardUtil gotoSettingViewController:self completion:nil];
}

- (void)addButtonTouched:(id)sender {
    
    [StoryboardUtil gotoSettingViewController:self completion:nil];
}

#pragma mark - UITableView Helper
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    TopViewTableCell *topCell = (TopViewTableCell *)cell;
    
//    NSDictionary *dataDictionary = _items[indexPath.row];
    topCell.titleLabel.text = @"あいうおえ";
    topCell.contentLabel.text = _items[indexPath.row];
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //計測用のプロパティ"_stubCell"を使って高さを計算する
    [self configureCell:_stubCell atIndexPath:indexPath];
    [_stubCell layoutIfNeeded];
    
    //カスタムセルの ContentView のサイズを再計算し、高さを決定する
    CGFloat height = [_stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height = height + _stubCell.titleLabel.frame.size.height + _stubCell.buttonContainerView.frame.size.height;
    
    return height + 1.f;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TopViewTableCell *cell = (TopViewTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = (TopViewTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //REMARK: Add item
    cell.titleLabel.text = @"あいうおえ";
    cell.contentLabel.text = _items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //REMARK: Add item
}


@end

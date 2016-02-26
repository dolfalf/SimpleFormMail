//
//  EditMailViewController.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/26.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "EditMailViewController.h"
#import "TempleteSelectTableViewController.h"

@interface EditMailViewController ()

@property (strong, nonatomic) RETableViewManager *manager;

@property (strong, nonatomic) RETableViewSection *mailSection;
@property (strong, nonatomic) RETableViewSection *titleSection;
@property (strong, nonatomic) RETableViewSection *contentSection;
@property (strong, readwrite, nonatomic) RETableViewSection *buttonSection;

@property (strong, readwrite, nonatomic) RETextItem *toItem;
@property (strong, readwrite, nonatomic) RETextItem *cc1Item;
@property (strong, readwrite, nonatomic) RETextItem *cc2Item;
@property (strong, readwrite, nonatomic) RETextItem *cc3Item;

@property (strong, readwrite, nonatomic) RETextItem *titleItem;

@property (strong, readwrite, nonatomic) RELongTextItem *contentItem;




@end

@implementation EditMailViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新規テンプレート作成";
    
    [self initControls];
    
    // Create manager
    //
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.mailSection = [self addMailControls];
    self.titleSection = [self addTitleControls];
    self.contentSection = [self addContentControls];
    self.buttonSection = [self addButton];
}

- (void)viewWillAppear:(BOOL)animated {
    
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
    
}

- (RETableViewSection *)addMailControls {
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Mail"];
    [self.manager addSection:section];
    
    self.toItem = [RETextItem itemWithTitle:@"To" value:@"" placeholder:@"Email address"];
    _toItem.name = @"To";
    _toItem.keyboardType = UIKeyboardTypeEmailAddress;
    _toItem.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _toItem.validators = @[@"presence", @"email"];

    self.cc1Item = [RETextItem itemWithTitle:@"CC 1" value:@"" placeholder:@"Email address"];
    _cc1Item.name = @"CC 1";
    _cc1Item.keyboardType = UIKeyboardTypeEmailAddress;
    _cc1Item.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _cc1Item.validators = @[@"presence", @"email"];
    
    self.cc2Item = [RETextItem itemWithTitle:@"CC 2" value:@"" placeholder:@"Email address"];
    _cc2Item.name = @"CC 2";
    _cc2Item.keyboardType = UIKeyboardTypeEmailAddress;
    _cc2Item.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _cc2Item.validators = @[@"presence", @"email"];
    
    self.cc3Item = [RETextItem itemWithTitle:@"CC 3" value:@"" placeholder:@"Email address"];
    _cc3Item.name = @"CC 3";
    _cc3Item.keyboardType = UIKeyboardTypeEmailAddress;
    _cc3Item.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _cc3Item.validators = @[@"presence", @"email"];
    
    [section addItem:_toItem];
    [section addItem:_cc1Item];
    [section addItem:_cc2Item];
    [section addItem:_cc3Item];
    
    return section;
}

- (RETableViewSection *)addTitleControls {
    
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Title"];
    [self.manager addSection:section];
    
    RETableViewItem *title_templete_buttonItem = [RETableViewItem itemWithTitle:@"Select Templete" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
//        item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    title_templete_buttonItem.textAlignment = NSTextAlignmentCenter;
    
    self.titleItem = [RETextItem itemWithTitle:nil value:nil placeholder:@"Full length text field"];
    
    [section addItem:title_templete_buttonItem];
    [section addItem:_titleItem];
    
    return section;
}

- (RETableViewSection *)addContentControls {
    
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Basic controls"];
    [self.manager addSection:section];
    
    RETableViewItem *content_templete_buttonItem = [RETableViewItem itemWithTitle:@"Select Templete" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
//        item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    content_templete_buttonItem.textAlignment = NSTextAlignmentCenter;
    
    self.contentItem = [RELongTextItem itemWithValue:nil placeholder:@"Multiline text field"];
    self.contentItem.cellHeight = 120;
    
    [section addItem:content_templete_buttonItem];
    [section addItem:_contentItem];
    
    return section;
    
}

- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"Test button" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}

@end

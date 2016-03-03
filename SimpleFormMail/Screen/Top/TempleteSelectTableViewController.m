//
//  TempleteSelectTableViewController.m
//  SimpleFormMail
//
//  Created by lee jaeeun on 2016/02/26.
//  Copyright © 2016年 kj-code. All rights reserved.
//

#import "TempleteSelectTableViewController.h"
#import "UIImage+Extension.h"

@implementation TempleteViewCell

@end

@interface TempleteSelectTableViewController ()

@property (nonatomic, assign) TempleteSelectType screenType;
@property (nonatomic, strong) NSArray *items;
@end

@implementation TempleteSelectTableViewController

- (instancetype)initWithScreenType:(TempleteSelectType)type {
    self = [super init];
    if (self) {
        //Initialize
        self.screenType = type;
    }
    
    return self;
}

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title =
    (_screenType==TempleteSelectTypeTitle)?@"タイトル選択":
    (_screenType==TempleteSelectTypeContent)?@"本文選択":@"";
    
    [self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)initControls {
    
    UIBarButtonItem *back_button = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backButtonTouched:)];
    
    UIBarButtonItem *add_button = [[UIBarButtonItem alloc] initWithImage:[UIImage renderImageNamed:@"icon_plus"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(addButtonTouched:)];
    
    self.navigationItem.leftBarButtonItems = @[back_button];
    self.navigationItem.rightBarButtonItems = @[add_button];
    
}

#pragma mark - IBAction
- (void)backButtonTouched:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addButtonTouched:(id)sender {
    
    //
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TempleteViewCell *cell = (TempleteViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

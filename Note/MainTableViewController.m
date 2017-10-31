//
//  MainTableViewController.m
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import "MainTableViewController.h"
#import "NoteStore.h"
#import "NoteTableViewCell.h"
#import "NoteModel.h"
#import "NoteEditViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

//初始化方法
- (instancetype) init{
    //调用父类的指定初始化方法
    self = [super initWithStyle:UITableViewStylePlain];
//    [[NoteStore getNoteStore]createNote];
//    [[NoteStore getNoteStore]createNote];
    
    if(self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"NoteList";
        // 创建新的UIBarButtonItem对象
        // 将其目标对象设置为当前对象，将其动作方法设置为addNewItem:
        UIBarButtonItem *addBututon = [[UIBarButtonItem alloc]
       initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self                                action:@selector(addNoteItem:)];
        // 为UINavigationItem对象的rightBarButtonItem属性赋值，
        // 指向新创建的UIBarButtonItem对象
        navItem.rightBarButtonItem = addBututon;
    }
    
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerClass:[UITableViewCell class]
//           forCellReuseIdentifier:@"UITableViewCell"];
    // 创建UINib对象，该对象代表包含了NoteTableViewCell的NIB文件
    UINib *nib = [UINib nibWithNibName:@"NoteTableViewCell" bundle:nil];
    // 通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"NoteTableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [[[NoteStore getNoteStore]allItems]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"NoteTableViewCell" forIndexPath:indexPath];
    
    NSArray *items =[[NoteStore getNoteStore]allItems];
    NoteModel *item=items[indexPath.row];
    
    cell.notePreviewLabel.text=item.content;
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteEditViewController *editViewController =[[NoteEditViewController alloc] init];
    
    NSArray *items = [[NoteStore getNoteStore] allItems];
    NoteModel *selectedItem = items[indexPath.row];
    // 将选中的BNRItem对象赋给DetailViewController对象
    editViewController.noteItem = selectedItem;
    
    // 将新创建的editViewController对象压入UINavigationController对象的栈
    [self.navigationController pushViewController:editViewController
                                         animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

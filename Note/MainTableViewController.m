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

    if(self) {
        //The navigation item used to represent the view controller in a parent's navigation bar.
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"NoteList";
        // 创建新的UIBarButtonItem对象
        // 将其目标对象设置为当前对象，将其动作方法设置为addNoteItem:
        addBututon = [[UIBarButtonItem alloc]
       initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self                                action:@selector(addNoteItem:)];
        
        // 为UINavigationItem对象的rightBarButtonItem属性赋值，
        // 指向新创建的UIBarButtonItem对象
        navItem.rightBarButtonItem = addBututon;
        //UIViewController对象有一个名为editButtonItem的属性，不用自己创建。
        navItem.leftBarButtonItem = self.editButtonItem;
        
        deleteBututon = [[UIBarButtonItem alloc]
                      initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                      target:self                                action:@selector(deleteAllNote:)];
    }
    
    return self;
}
//固定了Style
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated

{
    [super setEditing:editing animated:animated];
    if(editing){
        self.navigationItem.rightBarButtonItem=deleteBututon;
    }else{
        self.navigationItem.rightBarButtonItem=addBututon;
    }
}

//Called after the controller's view is loaded into memory.
- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建UINib对象，该对象代表包含了NoteTableViewCell的NIB文件
    UINib *nib = [UINib nibWithNibName:@"NoteTableViewCell" bundle:nil];
    // 通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"NoteTableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
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

//设置NoteTableViewCell的地方
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoteTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"NoteTableViewCell" forIndexPath:indexPath];
    
    NSArray *items =[[NoteStore getNoteStore]allItems];
    NoteModel *item=items[indexPath.row];
    
    cell.notePreviewLabel.text=item.content;
//    NSLog(@"%@", item.dateString);
    cell.dateLabel.text=item.dateString;
    
    return cell;
}
//按下tableView时的跳转，NoteEditViewController在这里完成初始化！
- (void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteEditViewController * editViewController =[[NoteEditViewController alloc] init];
    
    NSArray *items = [[NoteStore getNoteStore] allItems];
    NoteModel *selectedItem = items[indexPath.row];
    // 将选中的NoteModel对象赋给NoteEditViewController对象，NoteEditViewController知道显示哪个Note了。
    editViewController.noteItem = selectedItem;
    
    // 将新创建的editViewController对象压入UINavigationController对象的栈。
    [self.navigationController pushViewController:editViewController
                                         animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //刷新数据
    [self.tableView reloadData];
}
- (IBAction)addNoteItem:(id)sender
{
    NoteModel *newItem = [[NoteStore getNoteStore] createNote];
    
    
    // 获取新创建的对象在allItems数组中的索引
    NSInteger lastRow = [[[NoteStore getNoteStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    //将新行插入UITableView对象
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
    //新建后选中不跳转
//    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    //新建后进行跳转
    [self tableView:self didSelectRowAtIndexPath:indexPath];
}

- (IBAction)deleteAllNote:(id)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ALERT"
                                                                   message:@"Delete all notes."
                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"DELETE"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              [[NoteStore getNoteStore]removeAll];
                                                              [self.tableView reloadData];
                                                          }];
    //^(UIAlertAction * action){}匿名函数？
    [alert addAction:deleteAction];
    
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"Cancle"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果UITableView对象请求确认的是删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [[NoteStore getNoteStore] allItems];
        NoteModel *item = items[indexPath.row];
        [[NoteStore getNoteStore] removeNote:item];
        // 还要删除表格视图中的相应表格行（带动画效果）
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    } }


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

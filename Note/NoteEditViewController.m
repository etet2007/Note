//
//  NoteEditViewController.m
//  Note
//
//  Created by Stephen Lau on 2017/10/30.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import "NoteEditViewController.h"
//#import "NoteModel.h"
#import "NoteModel+CoreDataClass.h"

@interface NoteEditViewController ()

@end

@implementation NoteEditViewController

- (instancetype)init{
    self=[super init];
    self.navigationItem.title =@"NoteEdit";
    
    _typeList = [[NSArray alloc]initWithObjects:@"conference",@"to-do",@"anniversary",@"memorandum", nil];

    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //必须在加载nib文件后才能设置。
    _typePicker.delegate=self;
    _typePicker.dataSource=self;
    NSUInteger index=[_typeList indexOfObject:_noteItem.type];
    if(index<=3&&index>=0)
    [_typePicker selectRow:index inComponent:0 animated:true];//Component从0开始
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //把model里的content取出来显示。
    NoteModel *noteItem = self.noteItem;
    self.noteTextView.text = noteItem.content;
    
//    // 创建NSDateFormatter对象，用于将NSDate对象转换成简单的日期字符串
//    static NSDateFormatter *dateFormatter = nil;
//    if (！dateFormatter) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
//        dateFormatter.timeStyle = NSDateFormatterNoStyle;
//    } //
//    将转换后得到的日期字符串设置为dateLabel的标题
//    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 取消当前的第一响应对象
    [self.view endEditing:YES];
    // 将修改“保存”至NoteModel对象
    NoteModel *item = self.noteItem;
    item.content = self.noteTextView.text;
    [item updateDate];
}
- (void)setNoteItem:(NoteModel *)item
{
    _noteItem = item;
    self.navigationItem.title =@"NoteEdit";
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_typeList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    return [_typeList objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _noteItem.type=[_typeList objectAtIndex:row];
}

@end

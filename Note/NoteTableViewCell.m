//
//  NoteTableViewCell.m
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import "NoteTableViewCell.h"

@implementation NoteTableViewCell

//当NIB文件解档某个对象后，该对象就会收到awakeFromNib消息，可以在awakeFromNib中设置该对象，或者执行其他需要的初始化操作。
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (IBAction)editNote:(id)sender {
//}

@end

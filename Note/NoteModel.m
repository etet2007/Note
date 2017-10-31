//
//  NoteModel.m
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel 

- (instancetype)init {
    self=[super init];
    

    [self updateDate];
    
    _content=@"";
    //bug
    _type=@"Work";
    return self;
}

- (instancetype)initWithContent:(NSString *)content { 
    self=[self init];
    if (self) {
    _content=content;
     }
    return self;
}
//description函数
-(NSString *)description{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"Content:%@, date:%@ , type:%@",
     self.content,
     self.dateString,
     self.type];
    return descriptionString;
}
//NSCoding带来的函数，保存数据
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.dateString forKey:@"dateString"];
    [aCoder encodeObject:self.type forKey:@"type"];
}

//initWithCoder:是一个特例，和其他初始化方法无关。
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {
        _content = [aDecoder decodeObjectForKey:@"content"];
        _dateString = [aDecoder decodeObjectForKey:@"dateString"];
        _type = [aDecoder decodeObjectForKey:@"type"];
    }
    return self;
}
- (void)updateDate { 
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    //得到转换后得到的日期字符串
    _dateString = [dateFormatter stringFromDate:[NSDate date]];
}

@end

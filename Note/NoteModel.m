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
    _date=[NSDate date];
    //test code
    _content=@"firestNote firestNote firestNote firestNote firestNote firestNote firestNote";
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
     self.date,
     self.type];
    return descriptionString;
}
//NSCoding带来的函数，保存数据
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.type forKey:@"type"];
}

//initWithCoder:是一个特例，和其他初始化方法无关。
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {
        _content = [aDecoder decodeObjectForKey:@"content"];
        _date = [aDecoder decodeObjectForKey:@"date"];
        _type = [aDecoder decodeObjectForKey:@"type"];
    }
    return self;
}
@end

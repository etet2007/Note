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
-(NSString *)description{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"Content:%@, date:%@ , type:%@",
     self.content,
     self.date,
     self.type];
    return descriptionString;
}

@end

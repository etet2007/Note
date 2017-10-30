//
//  NoteStore.m
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import "NoteStore.h"
#import "NoteModel.h"

@interface NoteStore()
@property (nonatomic) NSMutableArray *privateItems;
@end

@implementation NoteStore

- (NoteModel *)createNote { 
    NoteModel *noteModel=[[NoteModel alloc]init];
    [self.privateItems addObject:noteModel];
    return noteModel;
}

+ (instancetype)getNoteStore { 
    //将sharedStore指针声明为了静态变量（static variable）
    static NoteStore *noteStore=nil;
    if(!noteStore){
        noteStore=[[self alloc]initPrivate];
    }
    return noteStore;
}
- (instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use+[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate{
    self=[super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}
-(NSArray *)allItems{
    return self.privateItems;
}

@end

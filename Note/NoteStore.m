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
//        _privateItems = [[NSMutableArray alloc] init];
        NSString *path = [self itemArchivePath];
        //载入固化文件
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        // 如果之前没有保存过privateItems，就创建一个新的
        if (!_privateItems){
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
-(NSArray *)allItems{
    return self.privateItems;
}
//获取相应文件的全路径
-(NSString *)itemArchivePath
{
    //注意第一个参数是NSDocumentDirectory而不是NSDocumentationDirectory
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    // 从documentDirectories数组获取第一个，也是唯一文档目录路径
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory
            stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    // 如果固化成功就返回YES
    //archiveRootObject:toFile:会将privateItems中的所有BNRItem对象都保存至路径为itemArchivePath的文件。
    return [NSKeyedArchiver archiveRootObject:self.privateItems
                                              toFile:path];
    
}
@end

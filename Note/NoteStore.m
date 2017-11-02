//
//  NoteStore.m
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import "NoteStore.h"
//#import "NoteModel.h"
#import "NoteModel+CoreDataClass.h"

@interface NoteStore()
@property (nonatomic) NSMutableArray *privateItems;
@end

@implementation NoteStore

- (NoteModel *)createNote { 
//    NoteModel *noteModel=[[NoteModel alloc]init];
    NoteModel *noteModel =
    [NSEntityDescription insertNewObjectForEntityForName:@"NoteModel"
                                  inManagedObjectContext:self.context];
    [self.privateItems addObject:noteModel];
    return noteModel;
}
//获取NoteStore对象
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
        //1.不保存数据版本。
//        _privateItems = [[NSMutableArray alloc] init];
        //ARCHIVE方法
//        NSString *path = [self itemArchivePath];
        //2.载入固化文件方法
//        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        // 如果之前没有保存过privateItems，就创建一个新的
//        if (!_privateItems){
//            _privateItems = [[NSMutableArray alloc] init];
        
        //3.读取Homepwner.xcdatamodeld
        //主要使用NSManagedObjectModel NSPersistentStoreCoordinator NSManagedObjectContext
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        _psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        // 设置SQLite文件路径
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        if (![_psc
              addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
        }
        //创建NSManagedObjectContext对象
        _context = [[NSManagedObjectContext alloc] init];
        _context.persistentStoreCoordinator = _psc;
        

        [self loadAllItems];
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
//    return [documentDirectory
//            stringByAppendingPathComponent:@"items.archive"];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
//    NSString *path = [self itemArchivePath];
    // 如果固化成功就返回YES
    //archiveRootObject:toFile:会将privateItems中的所有BNRItem对象都保存至路径为itemArchivePath的文件。
//    return [NSKeyedArchiver archiveRootObject:self.privateItems
//                                              toFile:path];
    
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful){
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}
- (void)removeNote:(NoteModel *)item {
    //需要通知NSManagedObjectContext对象从数据库删除相应的数据。
    [self.context deleteObject:item];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)removeAll { 
    [self.privateItems removeAllObjects];
    //1.创建查询请求 EntityName：想要清楚的实体的名字
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"NoteModel"];
    //2.创建删除请求  参数是：查询请求
    //NSBatchDeleteRequest是iOS9之后新增的API，不兼容iOS8及以前的系统
    NSBatchDeleteRequest *deletRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    //3.使用存储调度器(NSPersistentStoreCoordinator)执行删除请求
    /**
     Request：存储器请求（NSPersistentStoreRequest）  删除请求NSBatchDeleteRequest继承于NSPersistentStoreRequest
     context：管理对象上下文
     */
    [_psc executeRequest:deletRequest withContext:_context error:nil];
}

- (void)loadAllItems
{
    //第一次使用时，会一次性地取出store.data中的所有NoteModel对象。要通过NSManagedObjectContext对象得到这些NoteModel对象，就必须先设置一个NSFetchRequest对象，然后执行该对象。执行NSFetchRequest对象后，可以得到一组与指定的参数相匹配的对象。
    if(!self.privateItems) {
        //NSFetchRequest: A description of search criteria used to retrieve data from a persistent store
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        //设置相应的实体描述，定义所要获取的对象的实体。
        NSEntityDescription *e = [NSEntityDescription entityForName:@"NoteModel"
                                             inManagedObjectContext:self.context];
        request.entity = e;
       //还可以为NSFetchRequest对象设置排序描述对象（sort descriptors），用于指定返回对象的排列次序。排序描述对象拥有一个键（和某个实体属性对应）和一个布尔值（代表次序是升序还是降序）。
        //在本应用中作用不是非常大，只是加载数据时的排序。
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"dateString"
                                ascending:NO];
        request.sortDescriptors = @[sd];
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request
                                                      error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
        //如果某个应用的数据庞大，就应该只获取需要使用的实体对象。为NSFetchRequest对象设置特定的        NSPredicate对象，可以使Core Data只返回符合条件的对象。
    }
}

@end

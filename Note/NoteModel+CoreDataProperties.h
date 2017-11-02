//
//  NoteModel+CoreDataProperties.h
//  Note
//
//  Created by Stephen Lau on 2017/10/31.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//
//

#import "NoteModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN
//使用类别属性，为类增加方法。
@interface NoteModel (CoreDataProperties)

+ (NSFetchRequest<NoteModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *dateString;
@property (nullable, nonatomic, copy) NSString *type;

-(void)updateDate;
@end

NS_ASSUME_NONNULL_END

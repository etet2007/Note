//
//  NoteStore.h
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NoteModel;

@interface NoteStore : NSObject
@property(nonatomic,readonly)NSArray *allItems;

+ (instancetype)getNoteStore;

- (NoteModel *)createNote;
- (void)removeNote:(NoteModel *)item;
- (void)removeAll;

//保存数据
- (BOOL) saveChanges;
@end

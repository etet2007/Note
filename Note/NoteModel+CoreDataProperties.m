//
//  NoteModel+CoreDataProperties.m
//  Note
//
//  Created by Stephen Lau on 2017/10/31.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//
//

#import "NoteModel+CoreDataProperties.h"

@implementation NoteModel (CoreDataProperties)

+ (NSFetchRequest<NoteModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NoteModel"];
}

//Provides an opportunity to add code into the life cycle of the managed object when it is initially created.
- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.type=@"conference";
    [self updateDate];

}

- (void)updateDate {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    //得到转换后得到的日期字符串
    self.dateString = [dateFormatter stringFromDate:[NSDate date]];
    
}

@dynamic content;
@dynamic dateString;
@dynamic type;

@end

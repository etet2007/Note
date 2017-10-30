//
//  NoteModel.h
//  Note
//
//  Created by Stephen Lau on 2017/10/28.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteModel : NSObject
@property (strong,nonatomic,readwrite) NSString* content;
@property (strong,nonatomic,readonly) NSDate* date;
@property (strong,nonatomic,readwrite) NSString* type;//应该使用枚举

-(instancetype)initWithContent:(NSString *)content;
-(instancetype)init;//必须有的初始化函数
@end

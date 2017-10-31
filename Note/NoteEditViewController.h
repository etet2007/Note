//
//  NoteEditViewController.h
//  Note
//
//  Created by Stephen Lau on 2017/10/30.
//  Copyright © 2017年 Stephen Lau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoteModel;
@interface NoteEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (nonatomic, strong) NoteModel *noteItem;
@end

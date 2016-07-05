//
//  HLLNoteView.h
//  Save+
//
//  Created by Youngrocky on 16/6/26.
//  Copyright © 2016年 Rocky Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLLNibProtocol.h"
#import "HLLAnimationProtocol.h"

@interface HLLNoteView : UIView<HLLAnimationProtocol,HLLNibProtocol>

@property (nonatomic ,strong ,readonly) NSString * note;

- (void) clearNote;

@end


//
//  Task.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"
#import <UIKit/UIKit.h>

@interface Task : NSObject

@property (strong, nonatomic) NSString *taskName;
@property int taskId;
@property int petId;
@property BOOL isRecurring;
@property NSDate *time;
@property (strong, nonatomic) NSString *taskNote;
@property (strong, nonatomic) Pet *pet;
@property (strong, nonatomic) UIImage *loadedImage;
@property BOOL is_task_complete;

-(instancetype)initWithTaskName:(NSString *)taskName andPetId:(int)petId /*andRecurring:(BOOL)isRecurring*/ andTaskNote:(NSString *)taskNote;

@end

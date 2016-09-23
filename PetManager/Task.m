//
//  Task.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "Task.h"

@implementation Task

-(instancetype)initWithTaskName:(NSString *)taskName andPetId:(int)petId /*andRecurring:(BOOL)isRecurring*/ andTaskNote:(NSString *)taskNote {
    self = [super init];
    if (self) {
        _taskName = taskName;
//        _taskId = taskId;
        _petId = petId;
//        _isRecurring = isRecurring;
        _taskNote = taskNote;
        return self;
    }
    
    return nil;
}

@end

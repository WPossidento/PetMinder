//
//  AnimalType.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "AnimalType.h"

@implementation AnimalType

-(instancetype)initWithAnimalType:(NSString *)name andImage:(NSString *)image {
    self = [super init];
    if (self) {
        _name = name;
        _image = image;
        return self;
    }
    return nil;
}

@end

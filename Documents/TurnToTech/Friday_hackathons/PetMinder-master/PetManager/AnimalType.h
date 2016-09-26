//
//  AnimalType.h
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimalType : NSObject

@property int animalType_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;

-(instancetype)initWithAnimalType:(NSString *)name andImage:(NSString *)image;

@end

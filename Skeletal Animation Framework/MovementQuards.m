//
//  MovementQuards.m
//  practiceGame
//
//  Created by CS Team on 7/2/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "MovementQuards.h"


@implementation MovementQuards

@synthesize top;
@synthesize bottom;

- (id)init {
    if (self=[super init]){
        top = 0;
        bottom = 0;
    }
    return self;
}


-(void)addPosition:(double)posx:(double)posy:(double)posz:(double)part{
    posStack[top][0] = posx;
    posStack[top][1] = posy;
    posStack[top][2] = posz;
    posStack[top][3] = part;
    top++;
}

-(double*)getLastPosition{
    return posStack[bottom++];
}

-(bool)morePositions{
    if (bottom < top)
        return 1;
    else{
        for (int i = 0; i < 20; i++){
            posStack[0][0] = 0.0;
            posStack[0][1] = 0.0;
            posStack[0][2] = 0.0;
            posStack[0][3] = 0.0;
        }
        top = 0;
        bottom = 0;
        return 0;
    }
}

-(double)getPart{
    return posStack[top][3];
}

-(void)clear{
    free(posStack);
}


/*
 #pragma mark - Navigation
 n
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

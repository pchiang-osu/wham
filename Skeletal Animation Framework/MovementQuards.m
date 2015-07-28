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
        /*posQueue[0] = malloc(sizeof(double) * 500);
        posQueue[1] = malloc(sizeof(double) * 500);
        posQueue[2] = malloc(sizeof(double) * 500);
        posQueue[3] = malloc(sizeof(double) * 500);*/
        top = 0;
        bottom = 0;
    }
    return self;
}


-(void)addPosition:(double)posx:(double)posy:(double)posz:(double)part{
    posQueue[top][0] = posx;
    posQueue[top][1] = posy;
    posQueue[top][2] = posz;
    posQueue[top][3] = part;
    top++;
}

-(double*)getLastPosition{
    return posQueue[bottom++];
}

-(bool)morePositions{
    if (bottom < top)
        return 1;
    else
        return 0;
}

-(void)clear{
    free(posQueue);
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

/*
 Generic queue.
 */

#import <UIKit/UIKit.h>

@interface NSMutableArray (QueueAdditions)

-(id) dequeue;
-(void) enqueue:(id)obj;
-(id) peek:(int)index;
-(id) peekHead;
-(id) peekTail;
-(BOOL) empty;

@end
//
//  RightGLKViewController.m
//  YogaApp
//
//  Created by CS Team on 3/19/15.
//  Copyright (c) 2015 CS Team. All rights reserved.
//

#import "RightGLKViewController.h"

@interface RightGLKViewController (){
    /*float _curRed;
    BOOL _increasing;8=*/
    GLuint vertexBuffer;
    float rotation;
    
    /*for timer*/
    bool timerOn;
    int numberClicks;
    int flag;
    
    int secElapsed;
    int minElapsed;
    
    int secRem;
    int minRem;
    NSTimer *timer;
    /*end for timer*/
    
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;


@end

@implementation RightGLKViewController
@synthesize context;
@synthesize effect;
#define BUFFER_OFFSET(i) ((char *)NULL + (i))

/*define cube vertices and normals*/
GLfloat gCubeVertexData[216] =
{
 
    //x     y      z              nx     ny     nz
    1.0f, -1.0f, -1.0f,         1.0f,  0.0f,  0.0f,
    1.0f,  1.0f, -1.0f,         1.0f,  0.0f,  0.0f,
    1.0f, -1.0f,  1.0f,         1.0f,  0.0f,  0.0f,
    1.0f, -1.0f,  1.0f,         1.0f,  0.0f,  0.0f,
    1.0f,  1.0f,  1.0f,         1.0f,  0.0f,  0.0f,
    1.0f,  1.0f, -1.0f,         1.0f,  0.0f,  0.0f,
    
    1.0f,  1.0f, -1.0f,         0.0f,  1.0f,  0.0f,
    -1.0f,  1.0f, -1.0f,         0.0f,  1.0f,  0.0f,
    1.0f,  1.0f,  1.0f,         0.0f,  1.0f,  0.0f,
    1.0f,  1.0f,  1.0f,         0.0f,  1.0f,  0.0f,
    -1.0f,  1.0f, -1.0f,         0.0f,  1.0f,  0.0f,
    -1.0f,  1.0f,  1.0f,         0.0f,  1.0f,  0.0f,
    
    -1.0f,  1.0f, -1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f, -1.0f, -1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f,  1.0f,  1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f,  1.0f,  1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f, -1.0f, -1.0f,        -1.0f,  0.0f,  0.0f,
    -1.0f, -1.0f,  1.0f,        -1.0f,  0.0f,  0.0f,
    
    -1.0f, -1.0f, -1.0f,         0.0f, -1.0f,  0.0f,
    1.0f, -1.0f, -1.0f,         0.0f, -1.0f,  0.0f,
    -1.0f, -1.0f,  1.0f,         0.0f, -1.0f,  0.0f,
    -1.0f, -1.0f,  1.0f,         0.0f, -1.0f,  0.0f,
    1.0f, -1.0f, -1.0f,         0.0f, -1.0f,  0.0f,
    1.0f, -1.0f,  1.0f,         0.0f, -1.0f,  0.0f,
    
    1.0f,  1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    -1.0f,  1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    1.0f, -1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    1.0f, -1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    -1.0f,  1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    -1.0f, -1.0f,  1.0f,         0.0f,  0.0f,  1.0f,
    
    1.0f, -1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    -1.0f, -1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    1.0f,  1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    1.0f,  1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    -1.0f, -1.0f, -1.0f,         0.0f,  0.0f, -1.0f,
    -1.0f,  1.0f, -1.0f,         0.0f,  0.0f, -1.0f
   
    /*
    //x     y      z              nx     ny     nz
    0.5f, -0.5f, -1.5f,         1.0f,  0.0f,  0.0f,
    0.5f,  -1.5f, -1.5f,         1.0f,  0.0f,  0.0f,
    0.5f, -1.5f,  -0.5f,         1.0f,  0.0f,  0.0f,
    0.5f, -1.5f,  -0.5f,         1.0f,  0.0f,  0.0f,
    0.5f,  -0.5f,  -0.5f,         1.0f,  0.0f,  0.0f,
    0.5f,  -0.5f, -1.5f,         1.0f,  0.0f,  0.0f,
    
    0.5f,  -0.5f, -1.5f,         0.0f,  1.0f,  0.0f,
    -0.5f,  -0.5f, -1.5f,         0.0f,  1.0f,  0.0f,
    0.5f,  -0.5f,  -0.5f,         0.0f,  1.0f,  0.0f,
    0.5f,  -0.5f,  -0.5f,         0.0f,  1.0f,  0.0f,
    -0.5f,  -0.5f, -1.5f,         0.0f,  1.0f,  0.0f,
    -0.5f,  -0.5f,  -0.5f,         0.0f,  1.0f,  0.0f,
    
    
    -0.5f,  -0.5f, -1.5f,        -1.0f,  0.0f,  0.0f,
    -0.5f, -1.5f, -1.5f,        -1.0f,  0.0f,  0.0f,
    -0.5f,  -0.5f, -0.5f,        -1.0f,  0.0f,  0.0f,
    -0.5f,  -0.5f, -0.5f,        -1.0f,  0.0f,  0.0f,
    -0.5f, -1.5f, -1.5f,        -1.0f,  0.0f,  0.0f,
    -0.5f, -1.5f,  -0.5f,        -1.0f,  0.0f,  0.0f,
    
    0.5f, -1.5f, -0.5f,         0.0f, -1.0f,  0.0f,
    -0.5f, -1.5f, -0.5f,         0.0f, -1.0f,  0.0f,
    0.5f, -1.5f,  -1.5f,         0.0f, -1.0f,  0.0f,
    0.5f, -1.5f,  -1.5f,         0.0f, -1.0f,  0.0f,
    -0.5f, -1.5f, -0.5f,         0.0f, -1.0f,  0.0f,
    -0.5f, -1.5f,  -1.5f,         0.0f, -1.0f,  0.0f,

    -0.5f,  -0.5f,  -0.5f,         0.0f,  0.0f,  1.0f,
    0.5f,  -0.5f,  -0.5f,         0.0f,  0.0f,  1.0f,
    -0.5f, -1.5f,  -0.5f,         0.0f,  0.0f,  1.0f,
    -0.5f, -1.5f,  -0.5f,         0.0f,  0.0f,  1.0f,
    0.5f,  -0.5f,  -0.5f,         0.0f,  0.0f,  1.0f,
    0.5f, -1.5f,  -0.5f,         0.0f,  0.0f,  1.0f,
    
    -0.5f, -0.5f, -1.5f,         0.0f,  0.0f, -1.0f,
    0.5f, -0.5f, -1.5f,         0.0f,  0.0f, -1.0f,
    -0.5f,  -1.5f, -1.5f,         0.0f,  0.0f, -1.0f,
    -0.5f,  -1.5f, -1.5f,         0.0f,  0.0f, -1.0f,
    0.5f, -0.5f, -1.5f,         0.0f,  0.0f, -1.0f,
    0.5f,  -1.5f, -1.5f,         0.0f,  0.0f, -1.0f*/

};

-(void)setUpGL{
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor
    = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
    
    glEnable(GL_DEPTH_TEST);
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData),
                 gCubeVertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT,
                          GL_FALSE, 24, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT,
                          GL_FALSE, 24, BUFFER_OFFSET(12));

}

-(void)tearDownGL{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &vertexBuffer);
    
    self.effect = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*for timer*/
    timerOn = false;
    numberClicks = 0;
    flag = 0;
    secElapsed = 0;
    minRem = 0;
    
    secRem = 0;
    minRem = 2;
    /*end for timer*/
    
    
    self.context = [[EAGLContext alloc]
                    initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create OpenGL ES 2.0 context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setUpGL];

}

- (void)viewDidUnload{
    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - GLKViewDelegate
/*may go to delegate*/
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.6f, 0.6f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [self.effect prepareToDraw];
    
    glDrawArrays(GL_TRIANGLES, 0, 36);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.paused = !self.paused;
}
/*end may go to delegate*/



/*for timer*/
- (void)onTick {
    
    
    
    
    if (minRem != 0 || secRem != 0) {
        
        
        if (secElapsed != 60){
            //if (flag != 0){
            secElapsed += 1;
            //}
        }
        
        if (secRem != -1){
            secRem -= 1;
        }
        
        if (secElapsed == 60){
            secElapsed = 0;
            minElapsed += 1;
        }
        
        if (secRem == -1){
            secRem = 59;
            minRem -= 1;
            
            /*if (flag == 0){
             secElapsed += 1;
             }*/
        }
        
        flag++;
    }
    _glkRTimeEla.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",minElapsed,secElapsed];  //how to write to label
    _glkRTimeRem.text=[NSString stringWithFormat:@"%.2d" ":" "%.2d",minRem,secRem];
}

- (IBAction)glkRstartStop:(id)sender {
    
    numberClicks += 1;
    if (numberClicks % 2 != 0){
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                 target: self
                                               selector:@selector(onTick)
                                               userInfo: nil
                                                repeats: YES];
    }
    else{
        [timer invalidate];
        timer = nil;
    }
}
/*end for timer*/

#pragma mark - GLKViewControllerDelegate

- (void)update {
    
    float aspect = fabsf(self.view.bounds.size.width /
                         self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective
    (GLKMathDegreesToRadians(100.0f), aspect, 0.1f, 100.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelMatrix =
    GLKMatrix4MakeTranslation(0.0f,-1.0f,-10.0f);
    modelMatrix =
    /*GLKMatrix4Rotate(modelMatrix,rotation,1.0f,1.0f,0.7f);*/
    GLKMatrix4Rotate(modelMatrix,rotation,1.0f,0.0f,0.0f); //use to change the axis of rotation
    self.effect.transform.modelviewMatrix = modelMatrix;
    
    rotation += self.timeSinceLastUpdate * 1.0f;
}


@end

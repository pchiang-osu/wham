//
//  RightGLKViewController.m
//  YogaApp
//
//  Created by Gabe Aron on 3/19/15.
//  Copyright (c) 2015 wham. All rights reserved.
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
    
    NSNumber *n;
    NSArray *arr;
    int xHistory1;    //stores immediate possitions to see if device is going up or down
    int xHistory2;
    int yHistory1;
    int yHistory2;
    int zHistory1;
    int zHistory2;
    float values[3];
    int count;
    
    WWDeviceManager *deviceManager; //new
    WWDevice * connectedDevice; //new
    
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


/*- (void) manager:(WWDeviceManager *)manager onDeviceConnected: (WWDevice *)device { //new
    NSLog(@"WWAppDelegate: connected!");
    
    connectedDevice = device;
    connectedDevice.delegate = self; // Very important: Set WWDevice's delegate to this ViewController.
    
    // Request updates from the WearWare device every 1 second:
    [device changeUpdatePeriod:1];
    
    // Enable Temperature, Battery Voltage, and Pedometer data on the WearWare device:
    [device enableData:[NSArray arrayWithObjects:[NSValue valueWithWWCommandId:WWCommandIdTemperature],
                        [NSValue valueWithWWCommandId:WWCommandIdBattery],
                        [NSValue valueWithWWCommandId:WWCommandIdPedometer],
                        [NSValue valueWithWWCommandId:WWCommandIdPedometerDistance],
                        [NSValue valueWithWWCommandId:WWCommandIdAccelerometer],
                        nil]];
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    count = 0;
    values[0] = 1.0;
    values[1] = 1.0;
    values[2] = 1.0;
    
    /*for timer*/
    timerOn = false;
    numberClicks = 0;
    flag = 0;
    secElapsed = 0;
    minRem = 0;
    
    secRem = 0;
    minRem = 2;
    /*end for timer*/
    
    /*WearWare*/
    NSLog(@"WWAppDelegate: connected!");
    
    //new
    /*connectedDevice = [WWCentralDeviceManager sharedCentralDeviceManager].device;
    //connectedDevice.delegate = self; // Very important: Set WWDevice's delegate to this ViewController.
    
    // Request updates from the WearWare device every 1 second:
    [[WWCentralDeviceManager sharedCentralDeviceManager].device changeUpdatePeriod:1];
    
    // Enable Temperature, Battery Voltage, and Pedometer data on the WearWare device:
    [[WWCentralDeviceManager sharedCentralDeviceManager].device enableData:[NSArray arrayWithObjects:[NSValue valueWithWWCommandId:WWCommandIdTemperature],
                        [NSValue valueWithWWCommandId:WWCommandIdBattery],
                        [NSValue valueWithWWCommandId:WWCommandIdPedometer],
                        [NSValue valueWithWWCommandId:WWCommandIdPedometerDistance],
                        [NSValue valueWithWWCommandId:WWCommandIdAccelerometer],
                        nil]];
    //new*/

    //self.manager;
    [[WWCentralDeviceManager sharedCentralDeviceManager] addObserver:self
                                                          forKeyPath:@"accelerometerData"
                                                             options:0
                                                             context:NULL];
    /*WearWare*/
    
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

//new
- (NSString*)toString:(NSArray*)accelerometerData {
    NSString * accelString = [NSString stringWithFormat:@"X=%@, Y=%@, Z=%@",
                              [accelerometerData objectAtIndex:0],
                              [accelerometerData objectAtIndex:1],
                              [accelerometerData objectAtIndex:2]];
    return accelString;
}//new

/*WearWare*/
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"accelerometerData"]) {
        // Do something with [WWCentralDeviceManager sharedDeviceManager].ADCData
        arr = [WWCentralDeviceManager sharedCentralDeviceManager].accelerometerData;
        _xyzData.text=[NSString stringWithFormat:@"%@", [self toString:(NSArray*)arr]]; //new
        NSLog(@"%@", arr);
        NSString* string = [NSString stringWithFormat:@"X=%@", [arr objectAtIndex:0]];
        NSLog(@"%d,%s", [string intValue],"string");
        NSString* string2 = [arr objectAtIndex:0];
        NSString* stringb2 = [arr objectAtIndex:1];
        NSString* stringc2 = [arr objectAtIndex:2];
        xHistory1 = [string2 intValue];
        yHistory1 = [stringb2 intValue];
        zHistory1 = [stringc2 intValue];
        
    }
}
/*WearWare*/

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

 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


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
    
    count++;
    
    float aspect = fabsf(self.view.bounds.size.width /
                         self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective
    (GLKMathDegreesToRadians(100.0f), aspect, 0.1f, 100.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelMatrix =
    GLKMatrix4MakeTranslation(0.0f,-1.0f,-10.0f);
    /*modelMatrix =
    GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
    self.effect.transform.modelviewMatrix = modelMatrix;*/
    
    NSString* string = [arr objectAtIndex:0];
   
   
    if (xHistory1 > xHistory2)        //going up
    {
        values[1] = 0.0;
        values[2] = 0.0;
        values[0] = 1.0;
        rotation += self.timeSinceLastUpdate * (xHistory1-xHistory2);
        modelMatrix =
        GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
        self.effect.transform.modelviewMatrix = modelMatrix;
    }
    else if (xHistory1 < xHistory2)   //going down
    {
        values[1] = 0.0;
        values[2] = 0.0;
        values[0] = 1.0;
        rotation -= self.timeSinceLastUpdate * (xHistory2 - xHistory1);
        modelMatrix =
        GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
        self.effect.transform.modelviewMatrix = modelMatrix;
    }
    if (yHistory1 > yHistory2)
    {
        values[0] = 0.0;
        values[2] = 0.0;
        values[1] = 1.0;
        rotation += self.timeSinceLastUpdate * (yHistory1-yHistory2);
        modelMatrix =
        GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
        self.effect.transform.modelviewMatrix = modelMatrix;
    }
    else if (yHistory1 < yHistory2)
    {
        values[0] = 0.0;
        values[2] = 0.0;
        values[1] = 1.0;
        rotation -= self.timeSinceLastUpdate * (yHistory2 - yHistory1);
        modelMatrix =
        GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
        self.effect.transform.modelviewMatrix = modelMatrix;
    }
    if (zHistory1 > zHistory2)
    {
        values[0] = 0.0;
        values[1] = 0.0;
        values[2] = 1.0;
        rotation += self.timeSinceLastUpdate * (zHistory1 - zHistory2);
        modelMatrix =
        GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
        self.effect.transform.modelviewMatrix = modelMatrix;
    }
    else if (zHistory1 < zHistory2)
    {
        
        values[0] = 0.0;
        values[1] = 0.0;
        values[2] = 1.0;
        rotation -= self.timeSinceLastUpdate * (zHistory2 - zHistory1);
        modelMatrix =
        GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
        self.effect.transform.modelviewMatrix = modelMatrix;
    }
    xHistory2 = xHistory1;
    yHistory2 = yHistory1;
    zHistory2 = zHistory1;
}


@end

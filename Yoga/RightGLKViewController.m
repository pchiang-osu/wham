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
    int accxHistory[2];    //stores acceleration data
    int accyHistory[2];
    int acczHistory[2];
    
    int velxHistory[2];    //stores volocity data
    int velyHistory[2];
    int velzHistory[2];
    
    int posxHistory[2];    //stores position data
    int posyHistory[2];
    int poszHistory[2];
    int posxPrev;
    int posyPrev;
    int poszPrev;
    
    //for gravity compensation
    unsigned char sample_X;
    unsigned char sample_Y;
    unsigned char sample_Z;
    unsigned char sensor_Data[8];
    unsigned char countx,county ;
    unsigned char direction;
    unsigned long sstatex,sstatey,sstatez;
    unsigned int countCalibrate;

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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    count = 0;
    countCalibrate = 0;
    values[0] = 1.0;
    values[1] = 1.0;
    values[2] = 1.0;
    
    //load acceleration data
    accxHistory[1] = 0;
    accyHistory[1] = 0;
    acczHistory[1] = 0;
    accxHistory[0] = 0;
    accyHistory[0] = 0;
    acczHistory[0] = 0;
    
    //load velocity data
    velxHistory[0] = 0;
    velyHistory[0] = 0;
    velzHistory[0] = 0;
    velxHistory[1] = 0;
    velyHistory[1] = 0;
    velzHistory[1] = 0;
    
    //load position data
    posxHistory[0] = 0;
    posyHistory[0] = 0;
    poszHistory[0] = 0;
    posxHistory[1] = 0;
    posyHistory[1] = 0;
    poszHistory[1] = 0;
    
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
    [[WWCentralDeviceManager sharedCentralDeviceManager] requestData:WWCommandIdAccelerometer andUpdatePeriod:20];  //controls the device update rate
    

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


/*for acceleration-to-position*/

-(void) calibrate{                      //obtain the value of the refrence threshold. Used for no-movement condition
    sample_X = accxHistory[1];
    sample_Y = accyHistory[1];
    sample_Z = acczHistory[1];
    
    sstatex += sample_X;
    sstatey += sample_Y;
    sstatez += sample_Z;
    
    if (countCalibrate == 24){
        sstatex = sstatex >> 10;    //division by 1024
        sstatey = sstatey >> 10;
    }
}

-(void)position {
    
    unsigned char count2;
    count2 = 0;
    
    do{
        accxHistory[1] = accxHistory[1] + sample_X;     //filter routine for noise attenuation
        accyHistory[1] = accyHistory[1] + sample_Y;     //64 samples are averaged. The resulting average represents the acceleration of an instant
        
        count2++;
    }while (count2 != 0x40);    //64 sums of the acceleration sample
    
    accxHistory[1] = accxHistory[1] >> 6;       //division by 64
    accyHistory[1] = accyHistory[1] >> 6;
    
    if ((accxHistory[1] <= 3) && (accxHistory[1] >= -3)){       //discrimination window applied to the x axis acceleration
        accxHistory[1] = 0;
    }
    
    if ((accyHistory[1] <= 3) && (accyHistory[1] >= -3)){       //discrimination window applied to the y axis acceleration
        accyHistory[1] = 0;
    }
    
    /*integration*/
    //first x integration
    velxHistory[1] = velxHistory[0] + accxHistory[0] + ((accxHistory[1] - accxHistory[0]) >> 1);
    
    //second x integration
    posxHistory[1] = posxHistory[0] + velxHistory[0] + ((velxHistory[1] - velxHistory[0]) >> 1);
    /*end integration*/
    
    //set previous x position for position comparison
    posxPrev = posxHistory[0];
    
    /*resetting of values*/
    //update x acceleration to current value for future integration
    accxHistory[0] = accxHistory[1];
    //update x velocity to current value for future integration
    velxHistory[0] = velxHistory[1];
    //make required adjustment to make x position available data
    posxHistory[1] = posxHistory[1] << 18;
    
    //update x position to current value for future integration
    posxHistory[0] = posxHistory[1];
    /*end resetting of values*/
}

/*end for acceleration-to-position*/

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
        
        //load acceleration data
        accxHistory[1] = [string2 intValue];
        accyHistory[1] = [stringb2 intValue];
        acczHistory[1] = [stringc2 intValue];
        
        if (countCalibrate < 24){                 //gather initial values to compensate for gravity
            NSLog(@"Calibrating...");
            [self calibrate];
        }
        //else{                                       //program proper
            [self position];
        //}
        countCalibrate++;
        
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
    modelMatrix =
    GLKMatrix4Rotate(modelMatrix,rotation,values[0],values[1],values[2]); //use to change the axis of rotation
    self.effect.transform.modelviewMatrix = modelMatrix;
    
    NSString* string = [arr objectAtIndex:0];
   
    
    /*new code*/
    NSLog(@"%s%d", "position history", posxHistory[0]);
    NSLog(@"%s%d", "prev position", posxPrev);
    
    if (posxHistory[0] > posxPrev){                     //going up
        rotation += self.timeSinceLastUpdate * 1;
    }
    else if (posxHistory[0] < posxPrev){                //going down
        rotation -= self.timeSinceLastUpdate * 1;
    }
    /*end new code*/
}


@end

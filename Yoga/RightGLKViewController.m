//
//  RightGLKViewController.m
//  YogaApp
//
//  Created by Gabe Aron on 3/19/15.
//  Copyright (c) 2015 wham. All rights reserved.
//

#import "RightGLKViewController.h"
#define RADIANS_PER_PIXEL (M_PI / 320.f)

@interface RightGLKViewController (){
    /*float _curRed;
    BOOL _increasing;8=*/
    GLuint vertexBuffer;
    float rotation;
    float rotationx;
    float rotationy;
    float rotationz;
    
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
    double accxHistory[2];    //stores acceleration data
    double accyHistory[2];
    double acczHistory[2];
    int accx[2];
    int accy[2];
    int accz[2];
    
    
    double velxHistory[2];    //stores volocity data
    double velyHistory[2];
    double velzHistory[2];
    
    double posxHistory[2];    //stores position data
    double posyHistory[2];
    double poszHistory[2];
    double posxPrev;
    double posyPrev;
    double poszPrev;
    
    int rotationXY;
    int rotationXYPrev;
    int rotationYZ;
    int rotationYZPrev;
    int rotationXZ;
    int rotationXZPrev;
    
    CGPoint iniLocation;
    GLKQuaternion quarternion;

    
    #pragma DATA_SEG MY_ZEROPAGE
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
    = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);       //color
    
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
    
    rotationx = 0.0;
    rotationy = 0.0;
    rotationz = 0.0;
    
    count = 0;
    direction = 0;
    countCalibrate = 0;
    values[0] = 0.0;
    values[1] = 0.0;
    values[2] = 0.0;
    
    //load acceleration data
    accxHistory[1] = 0;
    accyHistory[1] = 0;
    acczHistory[1] = 0;
    accxHistory[0] = 0;
    accyHistory[0] = 0;
    acczHistory[0] = 0;
    accx[0] = 0;
    accy[0] = 0;
    accz[0] = 0;
    accx[1] = 0;
    accy[1] = 0;
    accz[1] = 0;
    
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
    //NSLog(@"WWAppDelegate: connected!");
    WWCentralDeviceManager *manager = [WWCentralDeviceManager sharedCentralDeviceManager];
    [manager connect];

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
    
    //WWFrameWork//
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    
    
    [center addObserverForWWDeviceUpdates:nil usingBlock:^(NSNotification *notification){   //make all objects match observer
        NSString *notificationName = notification.name;                     //used to discriminate between notifications
        if ([notificationName isEqualToString:WWDeviceDidConnect]){
            WWDevice *device = notification.object;
            
            //Enable data and change the update rate
            [device enableData:WWCommandIdAccelerometer];       //get device accelerometer data
            [device changeUpdatePeriod:1];
        }
        else if ([notificationName isEqualToString:WWDeviceDidUpdate]){
            //If notification.name is WWDeviceDidUpdate, notification.object is WWDeviceData
            WWDeviceData *deviceData = notification.object;
            NSLog(@"%@", deviceData.data);
            //do something with deviceData.data
            accx[1] = [deviceData.data[0] integerValue];       //accelerometer indices
            accy[1] = [deviceData.data[1] integerValue];
            accz[1] = [deviceData.data[2] integerValue];
            
            //NSLog(@"%i", accx[1]);
            [self convertToUnits];
            
            rotationYZ = atan2(accyHistory[1], acczHistory[1]) - M_PI;
            rotationXZ = atan2(accxHistory[1], acczHistory[1]) - M_PI;
            rotationXY = atan2(accxHistory[1], accyHistory[1]) - M_PI;
            //NSLog(@"%d", rotationXY);
            //NSLog(@"%d", rotationXYPrev);
            NSLog(@"%d", rotationYZ);
            
            [self update];
            NSLog(@"%f", acczHistory[1]);
            
           
            /*if (count < 1024){                  //must calibrate to account for gravitational pull
                NSLog(@"Calibrating...");
                [self calibrate];
            }*/
            //else{
                //[self position];
                //[self data_reintegration];
                //[self data_transfer];
            //}
            count++;
            //[self setNeedsDisplay];
        }
        else if ([notificationName isEqualToString:WWDeviceDidDisconnect]){
            //Do any necessary cleanup
            //may have to remove observer//
        }
        
    }];
    //end WWFrameWork//


}


/*for acceleration-to-position*/

-(void) convertToUnits{
    
    //NSLog(@"%s", "Convert to units");
    
    //for x
    //if x = 255 and y = 65, x = -1. If x = 255 and y = 190, x = 1. If x = 190 or x = 61, then x = 0.//
    //If x is between 0 and 61 (going up) and y is between 65 and 0 (going down), then x goes from -1 to 0 (right)//
    //If x is between 61 and 0 (going down) and y is between 0 and 65 (going up), then x goes from 0 to -1 (left)//
    //If x is between 61 and 0 (going down) and y is between 255 and 190 (going down), then x goes from 0 to 1  (right)//
    //If x is between 0 and 61 (going up) and y is between 190 and 255 (going up), then x goes from 1 to 0  (left)//
    //If x is between 255 and 190 (going down) and y is between 190 and 255 (going up), then x goes from 1 to 0 (right)//
    //If x is between 190 and 255 (going up) and y is between 255 and 190 (going down), then x goes from 0 to 1 (left)//
    //If x is between 190 and 255 (going up) and y is between 0 and 65 (going up), then x goes from 0 to -1 (right)//
    //If x is between 255 and 190 (going down) and y is between 65 and 0 (going down), then x goes from -1 to 0 (left)//
    
    //if x = 255 and y = 65, x = -1. If x = 255 and y = 190, x = 1. If x = 190 or x = 61, then x = 0
    if (accx[1] >= 251 && accx[1] <= 255 && accy[1] >= 61 && accy[1] <= 65){
        accxHistory[1] = -1;
    }
    else if (accx[1] >= 251 && accx[1] <= 255 && accy[1] >= 188 && accy[1] <= 192){
        accxHistory[1] = 1;
    }
    else if (accx[1] == 190 || accx[1] == 61){
        accxHistory[1] = 0;
    }
    //if x is between 0 and 61 and y is between 65 and 0, then x goes from -1 to 0
    else if (accx[1] >= 0 && accx[1] <= 61 && accy[1] <= 65 && accy[1] >= 0){
        accxHistory[1] = -((61.0-(float)accx[1]) / 61);
    }
    //if x is between 61 and 0 and y is between 255 and 190, then x goes from 0 to 1
    else if (accx[1] >= 0 && accx[1] <= 61 && accy[1] <= 255 && accy[1] >= 190){
        accxHistory[1] = (61.0 - (float)accx[1]) / 61;
    }
    //if x is between 255 and 190 and y is between 190 and 255, then x goes from 1 to 0
    else if (accx[1] <= 255 && accx[1] >= 190 && accy[1] >= 190 && accy[1] <= 255){
        accxHistory[1] = ((float)accx[1] - 190) / 65;
    }
    //if x is between 190 and 255 and y is between 0 and 65, then x goes from 0 to -1
    else if (accx[1] >= 190 && accx[1] <= 255 && accy[1] >= 0 && accy[1] <= 255){
        accxHistory[1] = -((float)accx[1] - 190) / 65;
    }
    

    
    //for y
    //if y = 255 and x = 190, y = 1. If y = 65 and x = 255, y = 0. If y = 255 and x = 61, y = -1. If y = 190 and x = 255, y = 0//
    //if y is between 0 and 65, and x is between 190 and 255, y goes from 1 to 0//
    //if y is between 0 and 65 and x is between 0 and 61, y goes from 0 to -1//
    //if y is between 255 and 190, and x is between 61 and 0, y goes from -1 to 0//
    //if y is between 190 and 255 and x is between 255 and 190, y goes from 0 to 1//
    
    //if y = 255 and x = 190, y = 1. If y = 65 and x = 255, y = 0. If y = 255 and x = 61, y = -1. If y = 190 and x = 255, y = 0
    if (accy[1] >= 251 && accy[1] <= 255 && accx[1] >= 188 && accx[1] <= 191){
        accyHistory[1] = 1;
    }
    else if (accy[1] >= 251 && accy[1] <= 255 && accx[1] >= 59 && accx[1] <= 63){
        accyHistory[1] = -1;
    }
    else if (accy[1] == 65 || accy[1] == 190){
        accyHistory[1] = 0;
    }
    //if y is between 0 and 65, and x is between 190 and 255, y goes from 1 to 0
    else if (accy[1] >= 0 && accy[1] <= 65 && accx[1] >= 190 && accx[1] <= 255){
        accyHistory[1] = (65.0-(float)accy[1]) / 65;
    }
    //if y is between 0 and 65 and x is between 0 and 61, y goes from 0 to -1
    else if (accy[1] >= 0 && accy[1] <= 65 && accx[1] >= 0 && accx[1] <= 61){
        accyHistory[1] = -(65.0-(float)accy[1]) / 65;
    }
    //if y is between 255 and 190, and x is between 61 and 0, y goes from -1 to 0
    else if (accy[1] <= 255 && accy[1] >= 190 && accx[1] <= 61 && accx[1] >= 0){
        accyHistory[1] = -((float)accy[1] - 190) / 65;
    }
    //if y is between 190 and 255 and x is between 255 and 190, y goes from 0 to 1
    else if (accy[1] >= 190 && accy[1] <= 255 && accx[1] <= 255 && accx[1] >= 190){
        accyHistory[1] = ((float)accy[1] - 190) / 65;
    }
    
    
    //for z
    //if z = 190 or if z = 267, z = 0//
    //if z = 255, z = 1//
    //if z is between 190 and 255, z goes from 1 to 0//
    //if z is between 0 and 67, z goes from 1 to 0
    
    //if z = 190 or if z = 267, z = 0
    if (accz[1] == 190 || accz[1] == 267){
        acczHistory[1] = 1;
    }
    //if z = 255, z = 1
    else if (accz[1] == 255){
        acczHistory[1] = 0;
    }
    //if z is between 190 and 255, z goes from 1 to 0
    else if (accz[1] >= 190 && accz[1] <= 255){
        acczHistory[1] = (65.0 - ((float)accz[1] - 190)) / 65;
    }
    //if z is between 0 and 67, z goes from 1 to 0
    else if (accz[1] >= 0 && accz[1] <= 67){
        acczHistory[1] = (67.0 - (float)accz[1]) / 67;
    }
}

-(void) calibrate{                      //obtain the value of the refrence threshold. Used for no-movement condition
    sample_X = accxHistory[1];
    sample_Y = accyHistory[1];
    sample_Z = acczHistory[1];
    
    sstatex += sample_X;
    sstatey += sample_Y;
    sstatez += sample_Z;
    
    if (count == 1024){
        sstatex = sstatex >> 10;    //division by 1024
        sstatey = sstatey >> 10;
    }
}

/*-(void) data_transfer{                  //obtain magnitude and direction in seperate variables
    signed long positionXbkp;
    signed long positionYYbkp;
    unsigned int delay;
    unsigned char posx_seg[4], posy_seg[4];
    
    
    if (posxHistory[1] >= 0){               //This line compares the sign of the x direction data
        direction = (direction | 0x10);     //if positive the most significant byte is set to 1, else it is set to 8
        posx_seg[0] = posxHistory[1] & 0x000000FF;
        posx_seg[1] = (posxHistory[1]>>8) & 0x000000FF;   //the data are also managed in the subsequent lines in order to be sent.
        posx_seg[2] = (posxHistory[1]>>16) & 0x000000FF;    //The 32 bit variable must be split into 4 different 8 bit varibles
        //in order to be sent via the 8 bit SCI frame
        posx_seg[3] = (posxHistory[1]>>24) & 0x000000FF;
    }
    else{
        direction = (direction | 0x80);
        positionXbkp = posxHistory[1] - 1;      //erase when finished
        positionXbkp = positionXbkp^0xFFFFFFFF;
        posx_seg[0] = positionXbkp & 0x000000FF;
        posx_seg[1] = (positionXbkp>>8) & 0x000000FF;
        posx_seg[2] = (positionXbkp>>16) & 0x000000FF;
        posx_seg[3] = (positionXbkp>>24) & 0x000000FF;
    }
    
    if (posyHistory[1] >= 0){                       //do the same for y values
        direction = (direction | 0x10);
        posy_seg[0] = posyHistory[1] & 0x000000FF;
        posy_seg[1] = (posyHistory[1]>>8) & 0x000000FF;
        posy_seg[2] = (posyHistory[1]>>16) & 0x000000FF;
        posy_seg[3] = (posyHistory[1]>>24) & 0x000000FF;
    }
    else{
        direction = (direction | 0x80);
        positionYYbkp = posyHistory[1] - 1;      //erase when finished
        positionYYbkp = positionYYbkp^0xFFFFFFFF;
        posy_seg[0] = positionYYbkp & 0x000000FF;
        posy_seg[1] = (positionYYbkp>>8) & 0x000000FF;
        posy_seg[2] = (positionYYbkp>>16) & 0x000000FF;
        posy_seg[3] = (positionYYbkp>>24) & 0x000000FF;
    }
    
    delay = 0x0100;
    
    sensor_Data[0] = 0x03;
    sensor_Data[1] = direction;
    sensor_Data[2] = posx_seg[3];
    sensor_Data[3] = posy_seg[3];
    sensor_Data[4] = 0x01;
    sensor_Data[5] = 0x01;
    sensor_Data[6] = '\n';
    
    while (--delay);
    
    NSLog(@"Direction:""%c", direction);
    NSLog(@"sensor_Data:""%s", sensor_Data);
}*/

/*-(void)data_reintegration{                      //return data format to its original state
    if (direction >= 10){
        posxHistory[1] = posxHistory[1]|0xFFFFC000;     //18 "ones" inserted. Sme size as the amount of shifts
    }
    
    direction = direction & 0x01;
    if (direction == 1){
        posyHistory[1] = posyHistory[1]|0xFFFFC000;
    }
}*/


-(void) movement_end_check{         //Allow movement end detection. This detects when movement has stopped
    if (accxHistory[1] == 0){       //we count the number of acceleration samples that equal zero
        countx++;
    }
    else{
        countx = 0;
    }
    
    if (countx >= 25){              //if this number exceeds 25, we can assume that velocity is zero
        velxHistory[1] = 0;
        velxHistory[1] = 0;
    }
    
    if (accyHistory[1] == 0){         //we do the same for the Y axis
        county++;
    }
    else{
        county = 0;
    }
    
    if (county >= 25){
        velyHistory[1] = 0;
        velyHistory[0] = 0;
    }
    
}

/*-(void)position {
    
    unsigned char count2;
    count2 = 0;
    
    do{
        accxHistory[1] = accxHistory[1] + sample_X;     //filter routine for noise attenuation
        accyHistory[1] = accyHistory[1] + sample_Y;     //64 samples are averaged. The resulting average represents the acceleration of an instant
        
        count2++;
    }while (count2 != 0x40);    //64 sums of the acceleration sample
    
    accxHistory[1] = accxHistory[1] >> 6;       //division by 64
    accyHistory[1] = accyHistory[1] >> 6;
    
    accxHistory[1] = accxHistory[1] - (int)sstatex;     //eliminating zero reference offset of the acceleration data
    accyHistory[1] = accyHistory[1] - (int)sstatey;     //to obtain positive and negative acceleration
    
    if ((accxHistory[1] <= 3) && (accxHistory[1] >= -3)){       //discrimination window applied to the x axis acceleration variable
        accxHistory[1] = 0;
    }
    
    if ((accyHistory[1] <= 3) && (accyHistory[1] >= -3)){       //discrimination window applied to the y axis acceleration variable
        accyHistory[1] = 0;
    }
    
    //integration
    //first x integration
    velxHistory[1] = velxHistory[0] + accxHistory[0] + ((accxHistory[1] - accxHistory[0]) >> 1);
    
    //second x integration
    posxHistory[1] = posxHistory[0] + velxHistory[0] + ((velxHistory[1] - velxHistory[0]) >> 1);
    
    //first Y integration
    velyHistory[1] = velyHistory[0] + accyHistory[0] + ((accyHistory[1] - accyHistory[0]) >> 1);
    
    //second Y integration
    posyHistory[1] = posyHistory[0] + velyHistory[0] + ((velyHistory[1] - velyHistory[0]) >> 1);
    //end integration
    
    //set previous x position for position comparison
    posxPrev = posxHistory[0];
    
    //resetting of values
    //update x and y acceleration to current value for future integration
    accxHistory[0] = accxHistory[1];
    accyHistory[0] = accyHistory[1];
    //update x velocity to current value for future integration
    velxHistory[0] = velxHistory[1];
    velyHistory[0] = velyHistory[1];
    //make required adjustment to make x position available data
    posxHistory[1] = posxHistory[1] << 18;
    posyHistory[1] = posyHistory[1] << 18;
    
    //[self data_transfer];
    
    posxHistory[1] = posxHistory[1] >> 18;      //once the variables are set, they must return to their original state
    posyHistory[1] = posyHistory[1] >> 18;
    
    [self movement_end_check];
    
    //update x position to current value for future integration
    posxHistory[0] = posxHistory[1];
    posyHistory[0] = posyHistory[1];
    //end resetting of values
    
    NSLog(@"Position Y:""%i", (int)posyHistory[0]);
    //NSLog(@"Position X:""%i", (int)posxHistory[0]);
    
    direction = 0;
}*/

/*end for acceleration-to-position*/

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

/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.paused = !self.paused;
}*/
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
    
    //rotationx -= 0.3;
 
    float aspect = fabsf(self.view.bounds.size.width /
                         self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective
    (GLKMathDegreesToRadians(100.0f), aspect, 0.1f, 100.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 xMatrix = GLKMatrix4MakeXRotation(rotationx);
    GLKMatrix4 yMatrix = GLKMatrix4MakeYRotation(rotationy);
    GLKMatrix4 zMatrix = GLKMatrix4MakeZRotation(rotationz);
    
    GLKMatrix4 translateMatrix = GLKMatrix4MakeTranslation(0.0f, -1.0f, -10.f);
    
    GLKMatrix4 modelMatrix =
    GLKMatrix4Multiply(translateMatrix,
    GLKMatrix4Multiply(zMatrix,
    GLKMatrix4Multiply(yMatrix, xMatrix)));
    //GLKMatrix4MakeTranslation(0.0f,-1.0f,-10.0f);       //controls translation (lateral motion) of cube
    
    
   
    /*for XY rotation*/
   
    if ((rotationXY == -6 || rotationXY == -5) && rotationXYPrev == 0){
        rotationz += 0.5;
    }
    else if ((rotationXYPrev == -6 || rotationXYPrev == -5) && rotationXY == 0){
        rotationz -= 0.5;
    }
    else if (rotationXY < rotationXYPrev){
        rotationz -= 0.5;
    }
    else if (rotationXY > rotationXYPrev){
        rotationz += 0.5;
    }
        
    /*end for XY rotation*/
    
     /*for YZ rotation*/
    //if y = 0
    //up-side-down is always -1
    //right-side-up is always -2
    //perpendicular is -2 or -3

    if (rotationYZ == -2 && acczHistory[1] >= 0.95 && acczHistory[1] <= 1.0){
        rotationx = 0.0;
    }
    else if (rotationYZ == -1 && acczHistory[1] >= -0.1 && acczHistory[1] <= 0.1){
        rotationx = 0.0;
    }
    else if (rotationYZ == -4 && acczHistory[1] >= 0.01 && acczHistory[1] <= 0.03){
        rotationx = -0.8;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.15 && acczHistory[1] <= 0.2){
        rotationx = -0.84375;
    }
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] >= 0.2 && acczHistory[1] < 0.25){
        rotationx = -0.8875;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.25 && acczHistory[1] <= 0.3){
        rotationx = -0.93125;
    }
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.3 && acczHistory[1] <= 0.35){
        rotationx = -0.975;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.35 && acczHistory[1] <= 0.4){
        rotationx = -1.01875;
    }
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.4 && acczHistory[1] <= 0.45){
        rotationx = -1.0625;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.45 && acczHistory[1] <= 0.5){
        rotationx = -1.10625;
    }
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.5 && acczHistory[1] <= 0.55){
        rotationx = -1.15;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.55 && acczHistory[1] <= 0.6){
        rotationx = -1.19375;
    }
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.6 && acczHistory[1] <= 0.65){
        rotationx = -1.12375;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.65 && acczHistory[1] <= 7){
        rotationx = -1.28125;
    }
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.7 && acczHistory[1] <= 0.75){
        rotationx = -1.325;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.75 && acczHistory[1] <= 0.8){
        rotationx = -1.36875;
    }
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.8 && acczHistory[1] <= 0.85){
        rotationx = -1.4125;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.85 && acczHistory[1] <= 0.9){
        rotationx = -1.45625;
    }
    
    else if ((rotationXY == -3 || rotationYZ == -2) && acczHistory[1] > 0.9 && acczHistory[1] <= 0.95){
        rotationx = -1.5;
    }

    //end if y = 0
    /*end for YZ rotation*/
    
    //NSLog(@"%f", rotation);
    
    acczHistory[0] = acczHistory[1];
    
    self.effect.transform.modelviewMatrix = modelMatrix;
    
    rotationXYPrev = rotationXY;
    rotationYZPrev = rotationYZ;
}

@end



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

    
    #pragma DATA_SEG MY_ZEROPAGE
    //for gravity compensation
    unsigned char sample_X;
    unsigned char sample_Y;
    unsigned char sample_Z;
    unsigned char sensor_Data[8];
    unsigned char countx,county;
    unsigned char direction;
    unsigned long sstatex,sstatey,sstatez;
    unsigned int countCalibrate;

    float values[3];
    int count;
    
    WWDeviceManager *deviceManager;
    WWDevice* connectedDevice;
    WWDevice* connectedDevice1;
    WWDevice* connectedDevice2;
    
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
    posxHistory[1] = 0.0f;
    posyHistory[1] = -1.0f;
    poszHistory[1] = -10.0f;
    
    
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
            
            if (connectedDevice == nil){
                connectedDevice = device;
            }
            else if (connectedDevice1 == nil){
                connectedDevice1 = device;
            }
            else if (connectedDevice2 == nil){
                //connectedDevice2 = device;
            }
            else{
                NSLog(@"%s", "All device slots filled");
            }
        }
        else if ([notificationName isEqualToString:WWDeviceDidUpdate]){
            //If notification.name is WWDeviceDidUpdate, notification.object is WWDeviceData
            WWDeviceData *deviceData = notification.object;
            //NSLog(@"%@", deviceData.data);
            //do something with deviceData.data
            accx[1] = [deviceData.data[0] integerValue];       //accelerometer indices
            accy[1] = [deviceData.data[1] integerValue];
            accz[1] = [deviceData.data[2] integerValue];
            
            if (connectedDevice.peripheralIdentifier){
                NSLog(@"%d", accx[1]);
                NSLog(@"%s", "Device1 connected");
                [self convertToUnits];
                rotationYZ = atan2(accyHistory[1], acczHistory[1]) - M_PI;
                rotationXZ = atan2(accxHistory[1], acczHistory[1]) - M_PI;
                rotationXY = atan2(accxHistory[1], accyHistory[1]) - M_PI;
                
                [self integration];
                
                //NSLog(@"%d", rotationXY);
                //NSLog(@"%d", rotationXYPrev);
                //NSLog(@"%d", rotationYZ);
                
                [self update];
                //NSLog(@"%f", accxHistory[1]);
                
                count++;
                //[self setNeedsDisplay];
            }
            else if (connectedDevice1.peripheralIdentifier){
                NSLog(@"%d", accx[1]);
                NSLog(@"%s", "Device2 connected");
                //NSLog(@"%@", deviceData.data);
            }
            
            /*[self convertToUnits];
            
            rotationYZ = atan2(accyHistory[1], acczHistory[1]) - M_PI;
            rotationXZ = atan2(accxHistory[1], acczHistory[1]) - M_PI;
            rotationXY = atan2(accxHistory[1], accyHistory[1]) - M_PI;
            
            [self integration];
            
            //NSLog(@"%d", rotationXY);
            //NSLog(@"%d", rotationXYPrev);
            //NSLog(@"%d", rotationYZ);
            
            [self update];
            //NSLog(@"%f", accxHistory[1]);
            
            count++;
            //[self setNeedsDisplay];*/
            else if ([notificationName isEqualToString:WWDeviceDidDisconnect]){
                //Do any necessary cleanup
                //may have to remove observer//
            }
        }
        
    }];
    //end WWFrameWork//


}


/*for acceleration-to-position*/

-(void) convertToUnits{
    
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
    /*if (accz[1] >= 190 && accz[1] <= 192 && ((accx[1] >= 0 && accx[1] <= 2) || (accx[1] >= 253 && accx[1] <= 255))){
        accxHistory[1] = 0;
    }*/
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

-(void)integration{
    
    /*measure velocity*/
    if ((abs(accxHistory[1]) - accxHistory[0]) > 1000000){        //movement end check. Ridiculous, I know
        velxHistory[1] = velxHistory[0];
    }
    else{
        double velAreax = (accxHistory[1] - accxHistory[0]) * 0.01;
        velxHistory[1] += velAreax;
    }
    
    if (accyHistory[1] - accyHistory[0] < 10){        //movement end check
        velyHistory[1] = velyHistory[0];
    }
    else{
        double velAreay1 = (accyHistory[1] - accyHistory[0]) * 0.01 / 2;
        double velAreay2 = accyHistory[0] * 0.1;
        velyHistory[1] = velAreay1 + velAreay2;
    }
    
    
    if (acczHistory[1] - acczHistory[0] < 10){        //movement end check
        velzHistory[1] = velzHistory[0];
    }
    else{
        double velAreaz1 = (acczHistory[1] - acczHistory[0]) * 0.01 / 2;
        double velAreaz2 = acczHistory[0] * 0.1;
        velzHistory[1] = velAreaz1 + velAreaz2;
    }
    
    /*measure position*/
    double posAreax = (velxHistory[1] - velxHistory[0]) * 0.01;
    posxHistory[1] += posAreax;
    
    /*double posAreay1 = (velyHistory[1] - velyHistory[0]) * 0.01 / 2;
    double posAreay2 = velyHistory[0] * 0.01;
    posyHistory[1] = posAreay1 + posAreay2;
    
    double posAreaz1 = (velzHistory[1] - velzHistory[0]) * 0.01 / 2;
    double posAreaz2 = velzHistory[0] * 0.01;
    poszHistory[1] = posAreaz1 + posAreaz2;*/
    
    //posxHistory[1] += 1;
    /*posyHistory[1] *= 100000;
    poszHistory[1] *= 100000;*/
    
    /*update values*/
    accxHistory[0] = accxHistory[1];
    accyHistory[0] = accyHistory[1];
    acczHistory[0] = acczHistory[1];
    
    velxHistory[0] = velxHistory[1];
    velyHistory[0] = velyHistory[1];
    velzHistory[0] = velzHistory[1];
    
    //for x
    /*if (posxHistory[1] > posxHistory[0]){
        NSLog(@"%s", "XPosRight");
    }
    else if (posxHistory[1] < posxHistory[0]){
        NSLog(@"%s", "XPosLeft");
    }*/
    
    //for y
    /*if (posy[1] > posy[0]){
     NSLog(@"%s", "yPosAway");
     }
     else if (posy[1] < posy[0]){
     NSLog(@"%s", "yPosToward");
     }*/
    
    //for z
    /*if (posz[1] > posz[0]){
     NSLog(@"%s", "zPosDown");
     }
     else if (posz[1] < posz[0]){
     NSLog(@"%s", "zPosUp");
     }*/
    
    
    posxHistory[0] = posxHistory[1];
    posyHistory[0] = posyHistory[1];
    poszHistory[0] = poszHistory[1];
    
     //NSLog(@"X: ""%f", (posxHistory[0] * 10000));
     /*NSLog(@"Y: ""%f", posyHistory[0]);
     NSLog(@"Z: ""%f", poszHistory[0]);*/
    
    /*NSLog(@"X: ""%f", accx[1]);
     NSLog(@"Y: ""%f", accy[1]);
     NSLog(@"Z: ""%f", accz[1]);*/
}

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
 
    float aspect = fabsf(self.view.bounds.size.width /
                         self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective
    (GLKMathDegreesToRadians(100.0f), aspect, 0.1f, 100.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 xMatrix = GLKMatrix4MakeXRotation(rotationx);
    GLKMatrix4 yMatrix = GLKMatrix4MakeYRotation(rotationy);
    GLKMatrix4 zMatrix = GLKMatrix4MakeZRotation(rotationz);
    
    GLKMatrix4 translateMatrix = GLKMatrix4MakeTranslation((posxHistory[1] * 10000), posyHistory[1], poszHistory[1]);
    
    GLKMatrix4 modelMatrix =
    GLKMatrix4Multiply(translateMatrix,
    GLKMatrix4Multiply(zMatrix,
    GLKMatrix4Multiply(yMatrix, xMatrix)));
    //GLKMatrix4MakeTranslation(0.0f,-1.0f,-10.0f);       //controls translation (lateral motion) of cube
    
    
   
    /*for XY rotation*/
   
    if (acczHistory[1] > 1.0 || acczHistory[1] < 0.9){                                                  //if not parallel to surface
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
    }
    /*else{                                   //special condition
        rotationz += 0.2;
    }*/
    
    /*end for XY rotation*/
    
     /*for YZ rotation*/
    //if y = 0
    //up-side-down is always -1
    //right-side-up is always -2
    //perpendicular is -2 or -3
    
    if (acczHistory[1] == 0){
        rotationx = -0.8;
    }
    else if (rotationYZ == -2 && acczHistory[1] >= 0.95 && acczHistory[1] <= 1.0){
        rotationx = 0.0;
    }
    /*else if (rotationYZ == -1 && acczHistory[1] >= -0.1 && acczHistory[1] <= 0.1){
        rotationx = 0.0;
    }*/
    else if (/*rotationYZ == -4 && */acczHistory[1] >= 0.01 && acczHistory[1] <= 0.1){
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
    
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.85 && acczHistory[1] <= 0.9){
        rotationx = -1.45625;
    }
    
    else if ((rotationYZ == -3 || rotationYZ == -2) && acczHistory[1] > 0.9 && acczHistory[1] <= 0.95){
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



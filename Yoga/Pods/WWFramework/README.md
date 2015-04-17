![WWFramework Logo](https://github.com/rutgerfarry/WWFramework/blob/master/WWFramework.png)

WWFramework is a library for connecting to WWDevices developed at the [Oregon State VLSI Research Group](http://eecs.oregonstate.edu/research/vlsi/). 
Device connections are managed by a central device manager (WWCentralDeviceManager), and are interacted with directly for enabling and disabling sensors (as of version 0.2.0).

## Installation
### Add to an existing project with Cocoapods
WWFramework is avaliable from our private [Cocoapods](http://cocoapods.org/) repository. If you've not yet added our repo,
double check with [Rutger](mailto:rutgerfarry@gmail.com) that you have access to 
[WWCocoapods-Repo](https://github.com/rutgerfarry/WWCocoapods-Repo), and then enter the following into your terminal **(this
only needs to be done once)**
```shell
pod repo add  WWCocoapods-Repo https://github.com/rutgerfarry/WWCocoapods-Repo.git
```
If you need more help installing Cocoapods and setting up WWFramework, [check out this video](http://youtu.be/8wWNcFbumlI)

Then just add the following to your Xcode project's Podfile:
```ruby
source 'https://github.com/rutgerfarry/WWCocoapods-Repo.git'
pod 'WWFramework'
```
and update your Cocoapods by running `pod update` in the terminal. If you just created your Podfile, run `pod install`
instead. This one-time setup will create an Xcode workspace with Cocoapods integration.

### Create a new project using the example app
WWFramework includes an example Xcode iPhone app with pre-defined methods to get you started enabling data from a device and subscribing to updates. Just clone or download the zip of this repository, and open the WWFramework.xcworkspace file.
The application code will be found in WWFramework->WWFramework.
![Starter Project Location Screenshot](https://github.com/rutgerfarry/WWFramework/blob/master/Images/StarterProjectScreen.png)

## Usage
### Using WWCentralDeviceManager
Using WWCentralDeviceManager is easiest and most scalable way to connect to a WWDevice. Messsages are sent to the center to connect to and disconnect from devices, and the center notifies the application of updates to devices through NSNotificationCenter. There are a few steps to connecting to and recieving notifications from devices using the WWCentralDeviceManager.

*(Note) This is very early in development, an abstracted method of handling notifications will soon be released*

##### 1. Import WWCentralDeviceManager
```Objective-C
#import <WWFramework/WWCentralDeviceManager.h>
```
##### 2. Initialize WWCentralDeviceManager and connect to devices
Initializing the device manager automatically creates an instance of WWCentralDeviceManager that can be accessed anywhere throughout the app by calling `sharedCentralDeviceManager`. The `connect` method connects to all devices in the area.
```Objective-C
WWCentralDeviceManager * manager = [WWCentralDeviceManager sharedCentralDeviceManager];
[manager connect];

```
##### 3. Observe NSNotificationCenter updates
Implement the NSNotificationCenter extension method `addObserverForWWDeviceUpdates:usingBlock:`. This will create an object 
that handles notifications in a block asynchronously. You can tell the type of update by accessing `notification.name`. 
There are three notification names: `WWDeviceDidConnect`, `WWDeviceDidDisconnect` and `WWDeviceDidUpdate`. 
Use if / else if on notification.name to decide what to do with each notification.object

```Objective-C
NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
[center addObserverForWWDeviceUpdates:nil usingBlock:^(NSNotification * notification) {
    NSString * notificationName = notification.name;
    if ([notificationName isEqualToString:WWDeviceDidConnect]) {
        WWDevice * device = notification.object;
        
        // Enable data and change the update rate
        [device enableData:WWCommandIdADCSample];
        [device changeUpdatePeriod:3];
    }
    else if ([notificationName isEqualToString:WWDeviceDidUpdate]) {
        // If notification.name is WWDeviceDidUpdate, notification.object is WWDeviceData
        WWDeviceData * deviceData = notification.object;
        // Do something with deviceData.data
    }
    else if ([notificationName isEqualToString:WWDeviceDidDisconnect]) {
        // Do any necessary cleanup
    }
}];

```

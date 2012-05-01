//
//  AppDelegate.h
//  CNR
//
//  Created by Gwennin Le Bourdonnec on 01/05/12.
//  Copyright (c) 2012 Supinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventRepository.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    EventRepository* er;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *mainController;

@property (nonatomic, readonly) EventRepository* er;

@end

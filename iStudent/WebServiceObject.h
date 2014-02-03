//
//  WebServiceObject.h
//  iStudent
//
//  Created by Kobe Dai on 10/23/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceObject : NSObject

- (void)connectWithURLString: (NSString *)urlString withNotificationName: (NSString *)notificationName;

@end

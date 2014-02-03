//
//  WebServiceObject.m
//  iStudent
//
//  Created by Kobe Dai on 10/23/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import "WebServiceObject.h"

@implementation WebServiceObject

- (id)init
{
    self = [super init];
    
    if (self){
    }
    
    return self;
}

- (void)connectWithURLString: (NSString *)urlString withNotificationName: (NSString *)notificationName
{
    dispatch_queue_t dispatch_Queue = dispatch_get_main_queue();
    
    dispatch_async(dispatch_Queue, ^(void)
                   {
                       NSLog(@"connect");
                       NSURL *url = [NSURL URLWithString: urlString];
                       NSURLRequest *request = [NSURLRequest requestWithURL: url];
                       
                       NSError *error = nil;
                       NSURLResponse *response = nil;
                       
                       NSData *data = [NSURLConnection sendSynchronousRequest: request
                                                            returningResponse: &response
                                                                        error: &error];
                       
                       if ([data length] > 0 && error == nil)
                       {
                           NSObject *deserilizedJSONObject = [self deserializeJSONWithData: data];
                           [[NSNotificationCenter defaultCenter] postNotificationName: notificationName object: nil userInfo: [NSDictionary dictionaryWithObjectsAndKeys: deserilizedJSONObject, @"Response", nil]];
                       }
                       else if ([data length] == 0 && error == nil)
                       {
                           NSLog(@"No data returned");
                       }
                       else if (error != nil)
                       {
                           NSLog(@"An error happened = %@", error);
                       }
                   });
}

- (NSObject *)deserializeJSONWithData: (NSData *)data
{
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData: data
                                                    options: NSJSONReadingAllowFragments
                                                      error: &error];
    if (jsonObject != nil && error == nil)
    {
        if ([jsonObject isKindOfClass: [NSDictionary class]] || [jsonObject isKindOfClass: [NSArray class]])
        {
            return jsonObject;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        NSLog(@"An error happened = %@", error);
        return nil;
    }
}

@end

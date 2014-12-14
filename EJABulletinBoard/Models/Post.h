//
//  Post.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/14/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) Post *post;

@end

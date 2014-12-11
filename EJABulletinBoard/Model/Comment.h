//
//  Comment.h
//  EJABulletinBoard
//
//  Created by Errol John Antonio on 12/11/14.
//  Copyright (c) 2014 Errol John Antonio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * comment_txxt;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) Comment *comment;

@end

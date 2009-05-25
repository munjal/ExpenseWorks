//
//  SQLitePersistentObject+X.h
//  ExpenseWorks
//
//  Created by mbudhabh on 5/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
#import "FrameworkX.h"

@interface SQLitePersistentObject (X) 

+ (id)newWithParams:(XHash *)params;
+ (id)createWithParams:(XHash *)params;

@end

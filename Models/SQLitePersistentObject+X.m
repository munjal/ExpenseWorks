//
//  SQLitePersistentObject+X.m
//  ExpenseWorks
//
//  Created by mbudhabh on 5/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SQLitePersistentObject+X.h"


@implementation SQLitePersistentObject(X)

+ (id)newWithParams:(XHash *)params {	
	id instance = [[self alloc] init];
	for (NSString *key in [params allKeys]) {
		NSString *propertyName = (NSString *)[[NSString stringWithFormat:@"set_%@:", key] asCamelCase];
		[instance performSelector:NSSelectorFromString(propertyName) withObject:[params valueForKey:key]];
	}
	
	return instance;
}

+ (id)createWithParams:(XHash *)params {
	id instance = [self newWithParams:params];
	if (instance) {
		[instance save];
		return instance;
	}
	return nil;
//	return [[self newWithParams:params] save];
}


@end

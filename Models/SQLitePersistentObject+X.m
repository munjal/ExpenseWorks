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
		
		
//		if ([[params valueForKey:key] isKindOf:[NSNumber class]]) {
//			//NSDecimalNumber *value = [[params valueForKey:key] decimalValue];
//			//NSNumber *value = [NSNumber numberWithDouble:[[params valueForKey:key] doubleValue]];
////			int *value = [[params valueForKey:key] doubleValue];
//			
//			NSMethodSignature *methodSignature = [instance methodSignatureForSelector:NSSelectorFromString(propertyName)];
//			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
//			[invocation setTarget:instance];
//			[invocation setSelector:NSSelectorFromString(propertyName)];
//			[invocation setArgument:&value atIndex:2];
//			[invocation invoke];
//		}
//		else {
//			[instance performSelector:NSSelectorFromString(propertyName) withObject:[params valueForKey:key]];
//		}
//		if ([[params valueForKey:key] isKindOf:[NSNumber class]]){
//			objc_msgSend(instance, NSSelectorFromString(propertyName), [[params valueForKey:key] decimalValue]);
//		}			
//		else
			[instance performSelector:NSSelectorFromString(propertyName) withObject:[params valueForKey:key]];
//		[instance performSelector:NSSelectorFromString(propertyName) withObject:[params valueForKey:key]];			
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

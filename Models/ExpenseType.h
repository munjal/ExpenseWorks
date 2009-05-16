#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface ExpenseType : SQLitePersistentObject {
	NSString		*typeId;
	NSString		*name;
}

@property (nonatomic, retain) NSString	*typeId;
@property (nonatomic, retain) NSString	*name;

@end

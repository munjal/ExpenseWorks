#import "ToolbarController.h"


@implementation ToolbarController

@synthesize contentViewController = _contentViewController;
@synthesize toolbar = _toolbar;

- (id)initWithContentViewController:(UIViewController*)contentViewController;
{
	self = [super init];
	if (self) {
		_contentViewController = [contentViewController retain];
		if ([_contentViewController isKindOfClass:[UINavigationController class]]) {
			((UINavigationController*)_contentViewController).delegate = self;
		}
	}
	return self;
}

- (void)loadView;
{
	UIView* contentView = _contentViewController.view;
	CGRect frame = contentView.frame;
	UIView* view = [[UIView alloc] initWithFrame:frame];
	
	frame = CGRectMake(0, 20, frame.size.width, frame.size.height - 44.0f);
	contentView.frame = frame;
	[view addSubview:contentView];

	frame = CGRectMake(0.0f, frame.size.height, frame.size.width, 44.0f);
	_toolbar = [[UIToolbar alloc] initWithFrame:frame];
	[view addSubview:_toolbar];

	self.view = view;
	[view release];
	[_toolbar release];
}

- (void)navigationController:(UINavigationController *)navigationController 
        willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
	NSArray* items = nil;
	if ([viewController respondsToSelector:@selector(toolbarItems)]) {
		items = [viewController performSelector:@selector(toolbarItems)];
	}
	[_toolbar setItems:items animated:animated];
}

- (void)dealloc
{
	[_contentViewController release];
    [super dealloc];
}

@end

//
//  SynthesizeSingleton.h
//  https://gist.github.com/1196496
//

#define SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_CUSTOM_METHOD(className, methodName) \
\
+ (className *) methodName \
{ \
	static className *shared ## className; \
	static dispatch_once_t token; \
	dispatch_once(&token, ^{ \
		shared ## className = [[className alloc] init]; \
	}); \
    \
	return shared ## className; \
}

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_CUSTOM_METHOD(className, sharedInstance)


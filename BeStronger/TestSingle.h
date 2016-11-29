//
//  TestSingle.h
//  BeStronger
//
//  Created by Roy on 16/11/29.
//  Copyright © 2016年 Roy. All rights reserved.
//

//#ifndef TestSingle_h
//#define TestSingle_h
//
//
//#endif /* TestSingle_h */


#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

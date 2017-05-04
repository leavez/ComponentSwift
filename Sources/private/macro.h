//
//  macro.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#ifndef macro_h
#define macro_h

#ifdef __cplusplus
#   define let auto const
#   define var auto
#else
#   define let __auto_type const
#   define var __auto_type
#endif

#define EXTENSION(__class__, __content__) \
@interface __class__ () \
__content__ \
@end

#define EXTENSION_h(__class__, __content__) \
@interface __class__ (Inner) \
__content__ \
@end

#define EXTENSION_m(__class__, __content__) \
@implementation __class__ (Inner) \
__content__ \
@end

#define ConvertWithDefault(__obj__, __defalut__) (__obj__ == nil ? (__defalut__) : (__obj__.convert))



#endif /* macro_h */


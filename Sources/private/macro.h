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


#define ConvertWithDefault(__obj__, __defalut__) (__obj__ == nil ? (__defalut__) : (__obj__.convert))


#endif /* macro_h */


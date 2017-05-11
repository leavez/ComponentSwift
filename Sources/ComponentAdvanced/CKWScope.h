//
//  CKWScope.h
//  Pods
//
//  Created by Gao on 08/05/2017.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKWScope : NSObject

- (nonnull instancetype)initWithClass:(Class)cls
                           identifier:(nullable NSString *)identifier
                  initialStateCreator:(id _Nullable(^_Nullable)())initialStateCreator NS_REFINED_FOR_SWIFT;

@end

NS_ASSUME_NONNULL_END

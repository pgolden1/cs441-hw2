//
//  Universe.h
//  2048CSGame
//
//  Created by Peter Golden on 2/11/19.
//  Copyright © 2019 Peter Golden. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Universe : NSObject
@property (nonatomic) int magicNumber;
+(Universe *)getSingleton;

@end

NS_ASSUME_NONNULL_END

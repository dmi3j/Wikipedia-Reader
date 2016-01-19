//
//  Article.h
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 18/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject <NSCoding>

@property (nonatomic, copy) NSString *articleTitle;
@property (nonatomic, strong) NSURL *articleURL;

@end

//
//  Article.m
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 18/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "Article.h"

@implementation Article

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    if (self) {
        _articleTitle = [aDecoder decodeObjectForKey:@"articleTitle"];
        _articleURL = [aDecoder decodeObjectForKey:@"articleURL"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.articleTitle forKey:@"articleTitle"];
    [aCoder encodeObject:self.articleURL forKey:@"articleURL"];
}

@end

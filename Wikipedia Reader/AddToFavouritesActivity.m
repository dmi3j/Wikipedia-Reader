//
//  AddToFavouritesActivity.m
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 18/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "AddToFavouritesActivity.h"
#import "Article.h"
#import "ArticleManager.h"

@interface AddToFavouritesActivity ()

@property (nonatomic, strong) Article *article;

@end

@implementation AddToFavouritesActivity

- (instancetype)initWithArticle:(Article *)article
{
    self = [super init];
    if (self) {
        self.article = article;
    }

    return self;
}

- (NSString *)activityTitle
{
    return @"Add to Favourites";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"activity-logo"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    BOOL canPerform = NO;
    for (id object in activityItems) {
        if ([object isKindOfClass:[Article class]]) {
            canPerform = YES;
        }
    }
    return canPerform;
}

- (void)performActivity
{
    [ArticleManager saveArticle:self.article];

    NSLog(@"activity completed");
}

- (void)activityDidFinish:(BOOL)completed
{
    NSLog(@"activity completed 2");
}

@end

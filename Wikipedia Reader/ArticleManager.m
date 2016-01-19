//
//  ArticleManager.m
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 19/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "ArticleManager.h"
#import "Article.h"

@implementation ArticleManager

+ (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"articles"];
}

+ (BOOL)isArticleSaved:(Article *)article
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.articleURL == %@", article.articleURL];
    NSArray *filteredAticles = [[self getSavedArticles] filteredArrayUsingPredicate:predicate];

    if (filteredAticles.count > 0) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)saveArticle:(Article *)article
{
    BOOL result = NO;

    if (![self isArticleSaved:article]) {
        NSMutableArray *articles = [NSMutableArray arrayWithArray:[self getSavedArticles]];
        [articles addObject:article];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:articles];
        result = [data writeToFile:[self filePath] atomically:YES];
    }

    return result;
}

+ (BOOL)removeArticleWithURL:(NSURL *)articleURL
{
    BOOL result = NO;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.articleURL != %@", articleURL];
    NSArray *filteredAticles = [[self getSavedArticles] filteredArrayUsingPredicate:predicate];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:filteredAticles];
    result = [data writeToFile:[self filePath] atomically:YES];

    return result;
}

+ (NSArray <Article *> *)getSavedArticles
{
    NSArray *result = nil;

    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:[self filePath]]) {
        NSData *archivedArticles = [NSData dataWithContentsOfFile:[self filePath]];
        result = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArticles];
    }

    return result;
}

@end

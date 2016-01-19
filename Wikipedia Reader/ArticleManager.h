//
//  ArticleManager.h
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 19/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Article;

@interface ArticleManager : NSObject

+ (BOOL)isArticleSaved:(Article *)article;
+ (BOOL)saveArticle:(Article *)article;
+ (BOOL)removeArticleWithURL:(NSURL *)articleURL;
+ (NSArray <Article *> *)getSavedArticles;

@end

//
//  AddToFavouritesActivity.h
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 18/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@interface AddToFavouritesActivity : UIActivity

- (instancetype)initWithArticle:(Article *)article;

@end

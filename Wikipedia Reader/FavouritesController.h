//
//  FavouritesTableViewController.h
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 18/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@protocol FavouritesControllerDelegate <NSObject>

- (void)didSelectArticle:(Article *)article;

@end

@interface FavouritesController : UIViewController

@property (nonatomic, weak) id <FavouritesControllerDelegate> delegate;

@end

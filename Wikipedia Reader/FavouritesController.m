//
//  FavouritesTableViewController.m
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 18/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "FavouritesController.h"
#import "ArticleManager.h"
#import "Article.h"

NSString *const kCellIdentifier = @"article-cell";

@interface FavouritesController ()
@property (weak, nonatomic) IBOutlet UITableView *favouritesTableView;
@property (weak, nonatomic) IBOutlet UIView *noDataNoticeView;

@property (nonatomic, strong) NSMutableArray *articles;

@end

@implementation FavouritesController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.favouritesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.articles = [NSMutableArray arrayWithArray:[ArticleManager getSavedArticles]];
    [self.favouritesTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.articles.count > 0) {
        self.noDataNoticeView.hidden = YES;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else {
        self.noDataNoticeView.hidden = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }

    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }

    Article *currentArticle = [self.articles objectAtIndex:indexPath.row];
    cell.textLabel.text = currentArticle.articleTitle;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Article *currentArticle = [self.articles objectAtIndex:indexPath.row];
        [ArticleManager removeArticleWithURL:currentArticle.articleURL];
        [self.articles removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *currentArticle = [self.articles objectAtIndex:indexPath.row];

    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectArticle:)]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.delegate didSelectArticle:currentArticle];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

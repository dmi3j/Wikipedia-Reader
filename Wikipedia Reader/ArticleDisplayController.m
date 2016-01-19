//
//  ArticleDisplayController.m
//  Wikipedia Reader
//
//  Created by Dmitrijs Beloborodovs on 18/01/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "ArticleDisplayController.h"
#import "AddToFavouritesActivity.h"
#import "Article.h"
#import "FavouritesController.h"

@interface ArticleDisplayController () <FavouritesControllerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionsBarButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ArticleDisplayController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadRandomArticle];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DisplayBookmarks"]) {
        UINavigationController *wrapper = segue.destinationViewController;
        ((FavouritesController *)wrapper.topViewController).delegate = self;
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [self getCurrentArticleShortTitle];
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [self.activityIndicator stopAnimating];
}

#pragma mark -

- (IBAction)refreshButtonPressed:(UIBarButtonItem *)sender
{
    [self loadRandomArticle];
}

- (IBAction)actionButtonPressed:(UIBarButtonItem *)sender
{
    Article *currentArticle = [[Article alloc] init];
    currentArticle.articleTitle = [self getCurrentArticleShortTitle];
    currentArticle.articleURL = self.webView.request.URL;

    if (currentArticle.articleTitle.length == 0
        || currentArticle.articleURL.absoluteString.length == 0) {
        // do nothing if no article loaded
        return;
    }

    NSArray *activityItems = @[currentArticle, self.webView.request.URL];

    AddToFavouritesActivity *addToFavouritesActivity = [[AddToFavouritesActivity alloc] initWithArticle:currentArticle];

    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[addToFavouritesActivity]];

    // make it working on iPad
    if ([activityViewController respondsToSelector:@selector(popoverPresentationController)]) {
        activityViewController.popoverPresentationController.barButtonItem = self.actionsBarButton;
    }

    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
}

#pragma mark -

- (void)loadRandomArticle
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Special:Random"]];
    [self.webView loadRequest:request];
    [self.activityIndicator startAnimating];
}

- (NSString *)getCurrentArticleShortTitle
{
    NSString *longTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (longTitle.length > 0) {
        NSRange suffixRange = [longTitle rangeOfString:@" - Wikipedia, the free encyclopedia" options:NSBackwardsSearch];
        if (suffixRange.location != NSNotFound) {
            return [longTitle substringToIndex:suffixRange.location];
        }
        else {
            return longTitle;
        }
    }
    else {
        return @"";
    }
}

#pragma mark - FavouritesControllerDelegate

- (void)didSelectArticle:(Article *)article
{
    NSURLRequest *request = [NSURLRequest requestWithURL:article.articleURL];
    [self.webView loadRequest:request];
    [self.activityIndicator startAnimating];
}

@end

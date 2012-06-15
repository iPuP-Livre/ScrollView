//
//  ViewController.m
//  ScrollView
//
//  Created by Jérémy Lagrue on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define NSLogFunction NSLog(@"%s", __FUNCTION__)

#define HAUTEUR_SCROLLVIEW 1000 
#define LARGEUR_SCROLLVIEW 500
#define MARGE_PLACEMENT_BOUTONS 10
#define HAUTEUR_BOUTONS 20
#define LARGEUR_BOUTONS 50

@interface ViewController ()

@end

@implementation ViewController

-	(void)viewDidLoad 
{
    // définition de la scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame]; //[4]
    scrollView.contentSize = CGSizeMake(LARGEUR_SCROLLVIEW, HAUTEUR_SCROLLVIEW); //[5]
    scrollView.delegate = self; //[6]
    scrollView.maximumZoomScale = 3.0;
    scrollView.minimumZoomScale = 1.0; 
    [self.view addSubview:scrollView];  
    // placement des boutons
    // calcul du nombre de boutons à mettre en largeur
    int nbBoutonsLargeur = (int)(LARGEUR_SCROLLVIEW/(LARGEUR_BOUTONS + MARGE_PLACEMENT_BOUTONS));
    // calcul du nombre de boutons à mettre en hauteur
    int nbBoutonsHauteur = (int)(HAUTEUR_SCROLLVIEW/(HAUTEUR_BOUTONS + MARGE_PLACEMENT_BOUTONS));
    
    for (int ligne = 0 ; ligne < nbBoutonsHauteur ; ligne++)
    {
    	for (int colonne = 0 ; colonne < nbBoutonsLargeur ; colonne++) 
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setFrame:CGRectMake(colonne*(LARGEUR_BOUTONS + MARGE_PLACEMENT_BOUTONS), ligne * (HAUTEUR_BOUTONS + MARGE_PLACEMENT_BOUTONS), LARGEUR_BOUTONS, HAUTEUR_BOUTONS)]; //[8]
            [button setTitle:[NSString stringWithFormat:@"%d%d", ligne, colonne] forState:UIControlStateNormal]; //[9]
            [button addTarget:self action:@selector(handleClic:) forControlEvents:UIControlEventTouchUpInside]; //[10]
            button.tag = [button.titleLabel.text intValue]; //[11]
            [scrollView addSubview:button];
    	}
	}
    [super viewDidLoad];
}

-	(void) handleClic:(id)sender 
{
    UIButton *theSenderButton = (UIButton*)sender;
    NSLog(@"Sender tag : %d", theSenderButton.tag); //[12]
}

#pragma mark -
#pragma mark UIScrollView delegate methods

-	(void)scrollViewDidScroll:(UIScrollView *)scrollView //[13]
{ 
    NSLogFunction;
}
-	(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView //[14]
{ 
    NSLogFunction;
    for (UIButton *but in [scrollView subviews])
        but.highlighted = YES; //[15]
}
-	(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate //[16]
{ 
    NSLogFunction;
    for (UIButton *but in [scrollView subviews])
        but.highlighted = NO;
}

@end

//
//  ViewController.m
//  Poker
//
//  Created by Jake Goodman on 6/4/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#import "PokerViewController.h"
#import "Card.h"
#import "Hand.h"
#import "Deck.h"
#import "PokerGame.h"
#import "CardButton.h"


@interface PokerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIStackView *cardStackView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

-(void)setupCardViews;
-(void)updateViewsForGameState;

- (IBAction)didTapActionButton:(id)sender;
-(void)didTapCard:(id)sender;
-(void)replaceSelectedCards;
-(void)updateScoreFromCurrentHand;

-(void)presentGameOverAlert;
-(void)presentCanNotSelectAlert;

@end

@implementation PokerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentGame = [[PokerGame alloc] init];
}

- (IBAction)didTapActionButton:(id)sender {
    
    switch (_currentGame.state) {
        case START:
            [self setupCardViews];
            [_currentGame dealNextHand];
            break;
        case DEAL:
            [_currentGame dealNextHand];
            break;
        case GO:
            [self replaceSelectedCards];
            [self updateScoreFromCurrentHand];
            break;
        case DONE:
            self.currentGame = [[PokerGame alloc] init];
            [_cardStackView setHidden:true];
            break;
    }
    [self updateViewsForGameState];
}

-(void)replaceSelectedCards {
    //Iterate through CardButtons and if it selected, we replace it.
    //Note, should reimplement such that unselecting is part of the updateViewsForGameState method.
    NSMutableArray *indiciesToReplace = [NSMutableArray array];
    [_cardStackView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CardButton* cardButton = (CardButton*) obj;
        if ((cardButton) && (cardButton.isSelected)) {
            [indiciesToReplace addObject: [NSNumber numberWithInteger:idx]];
            [cardButton setSelected:false];
        }
    }];
    [_currentGame replaceCardsAtIndices:indiciesToReplace];
}

-(void)updateScoreFromCurrentHand {
    if ([_currentGame.currentHand hasStraight]) {
        [_currentGame addPointsToScore:500];
    }
    else if ([_currentGame.currentHand hasPair]) {
        [_currentGame addPointsToScore:100];
    }
}


-(void)setupCardViews
{
    [_cardStackView setHidden:false];
    if (_cardStackView.arrangedSubviews.count != 0) {
        return;
    }
    
    for (int i = 0; i < POKER_HAND_SIZE_CONST; i++) {
        CardButton *cardButton = [[CardButton alloc] init];
        [cardButton addTarget:self
                       action:@selector(didTapCard:)
             forControlEvents:UIControlEventTouchUpInside];
        [_cardStackView addArrangedSubview:cardButton];
    }
}

-(void)updateViewsForGameState {
    for (int i = 0; i < POKER_HAND_SIZE_CONST; i++){
        Card *card = [_currentGame.currentHand cardAtIndex:i];
        CardButton *cardButton = [_cardStackView.arrangedSubviews objectAtIndex:i];
        if (card && cardButton) {
            [cardButton setTitle:[Card stringForRank:card.rank] forState:UIControlStateNormal];

            UIImage *img = [UIImage imageNamed:[Card imagePathForSuit:card.suit]];
            [cardButton setImage:img forState:UIControlStateNormal];

        }
    }
    [_scoreLabel setText:[NSString stringWithFormat:@"Score: %i", _currentGame.score]];
    
    NSString* buttonTitle = @"";
    switch (_currentGame.state) {
        case START:
            buttonTitle = @"Start";
            break;
        case DEAL:
            buttonTitle = @"Deal";
            break;
        case GO:
            buttonTitle = @"GO";
            break;
        case DONE:
            buttonTitle = @"Play Again";
            [self presentGameOverAlert];
    }
    [_actionButton setTitle:buttonTitle forState:UIControlStateNormal];
}

-(void)didTapCard:(id)sender {
    if(_currentGame.state != GO) {
        return;
    }
    
    CardButton* button = (CardButton*) sender;
    
    if (button.isSelected) {
        [button setSelected:false];
    }
    else {
        NSInteger numSelected = 0;
        for (CardButton* button in [_cardStackView arrangedSubviews]) {
            if (button.isSelected) {
                numSelected += 1;
            }
        }
        if ([_currentGame canReplaceNumberOfCards:numSelected]) {
            [button setSelected:!button.isSelected];
        }
        else {
            [self presentCanNotSelectAlert];
        }
    }
}

-(void)presentGameOverAlert {
    NSString* title = @"No More Hands";
    NSString* message = [NSString stringWithFormat:@"Score: %i", _currentGame.score];
    [self presentDismissableAlertWithTitle:title message:message];
}

-(void)presentCanNotSelectAlert {
    NSString* title = @"No More Cards";
    NSString* message = @"There are not enough cards remaining to do that.";
    [self presentDismissableAlertWithTitle:title message:message];
}

-(void)presentDismissableAlertWithTitle:(NSString*)title message:(NSString*) message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message: message
                                                                      preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction *action) { }];
    
    [alertController addAction:closeAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

//
//  PokerGame.m
//  Poker
//
//  Created by Jake Goodman on 6/5/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Hand.h"
#import "Deck.h"
#import "PokerGame.h"

@interface PokerGame ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) Hand *currentHand;
@property int score;

@end

@implementation PokerGame

- (instancetype)init
{
    self = [super init];
    if (self) {
        _deck = [[Deck alloc] init];
        _score = 0;
        _state = START;
    }
    return self;
}

- (void)addPointsToScore:(int)newPoints
{
    _score += newPoints;
}

- (Boolean)hasNextHand
{
    return [_deck canGetHandOfSize:5];
}

-(void)dealNextHand
{
    _currentHand = [_deck handOfSize:5];
    self.state = GO;
}

- (Boolean)canReplaceNumberOfCards:(NSInteger)numCards
{
    return _deck.numberCardsRemaining >= numCards;
}

- (void)replaceCardsAtIndices:(NSArray*)indicies
{
    for (int i = 0; i < indicies.count; i++){
        NSInteger index = [(NSNumber*)indicies[i] integerValue];
        Card* replacementCard = [self->_deck nextCard];
        [_currentHand replaceCardAtIndex:index withCard:replacementCard];
    }
    if([self hasNextHand]) {
        _state = DEAL;
    }
    else{
        _state = DONE;
    }
}

@end

//
//  Deck.m
//  Poker
//
//  Created by Jake Goodman on 6/4/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Hand.h"
#import "Deck.h"

@interface Deck ()
@property (readwrite) NSUInteger currentIndex;
@end

@implementation Deck

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cards = [NSMutableArray array];
        for (int i = 1; i < 14; i++){
            Card *card1 = [[Card alloc] initWithRank:i suit:Spades];
            Card *card2 = [[Card alloc] initWithRank:i suit:Hearts];
            Card *card3 = [[Card alloc] initWithRank:i suit:Diamonds];
            Card *card4 = [[Card alloc] initWithRank:i suit:Clubs];
            [_cards addObject:card1];
            [_cards addObject:card2];
            [_cards addObject:card3];
            [_cards addObject:card4];
        }
        [self shuffle];
    }
    return self;
}

- (NSUInteger) numberCardsRemaining {
    return self.cards.count - self.currentIndex;
}

- (void) shuffle
{
    NSUInteger count = _cards.count;
    if (count <= 1) {
        return;
    }
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [_cards exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    _currentIndex = 0;
}

- (Boolean)hasNextCard {
    return [self numberCardsRemaining] > 0;
}

- (Card *)nextCard
{
    NSInteger nextIndex = self.currentIndex + 1;
    if (nextIndex < self.cards.count-1) {
        Card *card = _cards[self.currentIndex];
        self.currentIndex = nextIndex;
        return card;
    }
    return NULL;
}


- (Boolean)canGetHandOfSize:(NSUInteger)size
{
    return [self numberCardsRemaining] >= size;
}

- (Hand *)handOfSize:(NSUInteger)size
{
    NSMutableArray<Card *>* cardsForHand = [NSMutableArray array];
    for (int i = 0; i < size; i++){
        [cardsForHand addObject:[self nextCard]];
    }
    return [[Hand alloc] initWithCards:cardsForHand];
}

@end

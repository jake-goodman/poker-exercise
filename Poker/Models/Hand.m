//
//  Hand.m
//  Poker
//
//  Created by Jake Goodman on 6/5/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Hand.h"

@implementation Hand

- (instancetype)initWithCards:(NSMutableArray<Card *> *)cards
{
    self = [super init];
    if (self) {
        _cards = cards;
    }
    return self;
}

- (NSUInteger) size {
    return self.cards.count;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return self.cards[index];
}

- (void)replaceCardAtIndex:(NSUInteger)index withCard:(Card *)card
{
    if (card) {
        [_cards replaceObjectAtIndex:index withObject:card];
    }
}

- (Boolean)hasStraight
{
    //Sort Cards by rank
    NSArray<Card*> *sortedCards = [_cards sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSInteger first = (NSInteger)[(Card*)a rank];
        NSInteger second = (NSInteger)[(Card*)b rank];
        return first > second;
    }];
    
    //Check that each card is 1 less than the next
    for (int i = 0; i < sortedCards.count - 1; i++) {
        Card* card = sortedCards[i];
        Card* nextCard = sortedCards[i+1];
        if((int)card.rank != (int)nextCard.rank - 1) {
            return false;
        }
    }
    return true;
}

- (Boolean)hasPair
{
    //n^2 but since we know n is very small, ok for now.
    for (Card *card in _cards) {
        for (Card *card2 in _cards) {
            if (card != card2 && card.rank == card2.rank)  {
                return true;
            }
        }
    }
    return false;
}


@end

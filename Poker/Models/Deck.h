//
//  Deck.h
//  Poker
//
//  Created by Jake Goodman on 6/4/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#ifndef Deck_h
#define Deck_h

@interface Deck: NSObject

- (NSUInteger) numberCardsRemaining;
@property (strong, nonatomic) NSMutableArray<Card *>* cards;

- (void) shuffle;
- (Boolean) hasNextCard;
- (Card *) nextCard;
- (Boolean) canGetHandOfSize: (NSUInteger) size;
- (Hand *) handOfSize: (NSUInteger) size;

@end

#endif /* Deck_h */

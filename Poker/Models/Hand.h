//
//  Hand.h
//  Poker
//
//  Created by Jake Goodman on 6/5/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#ifndef Hand_h
#define Hand_h

@interface Hand: NSObject

@property (strong, nonatomic) NSMutableArray<Card *>* cards;

- (instancetype) initWithCards: (NSMutableArray<Card *>*) cards;

- (NSUInteger) size;
- (Card*) cardAtIndex: (NSUInteger) index;
- (void) replaceCardAtIndex: (NSUInteger) index
                   withCard: (Card*) card;
- (Boolean) hasPair;
- (Boolean) hasStraight;

@end

#endif /* Hand_h */

//
//  Card.h
//  Poker
//
//  Created by Jake Goodman on 6/4/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#ifndef Card_h
#define Card_h

@interface Card: NSObject

typedef NS_ENUM(NSInteger, Suit) {
    Clubs,
    Diamonds,
    Hearts,
    Spades
};

typedef NS_ENUM(NSInteger, Rank) {
    Ace = 1, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King
};


@property (nonatomic, readonly) Rank rank;
@property (nonatomic, readonly) Suit suit;

- (instancetype) initWithRank: (Rank) value
                         suit: (Suit) suit;

+ (NSString *) stringForRank: (Rank) rank;
+ (NSString *) imagePathForSuit: (Suit) suit;

@end

#endif /* Card_h */

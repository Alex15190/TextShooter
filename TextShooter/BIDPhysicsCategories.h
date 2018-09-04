//
//  BIDPhysicsCategories.h
//  TextShooter
//
//  Created by Alex Chekodanov on 03.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#ifndef BIDPhysicsCategories_h
#define BIDPhysicsCategories_h

typedef NS_OPTIONS(uint32_t, BIDPhysicsCategory)
{
    PlayerCategory        =  1 << 1,
    EnemyCategory         =  1 << 2,
    PlayerMissileCategory =  1 << 3
};

#endif /* BIDPhysicsCategories_h */

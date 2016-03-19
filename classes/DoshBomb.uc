class DoshBomb extends KFDroppedPickup_Cash;

var float damageToDosh;

auto state Pickup {
    /**
     * Copied from KFDroppedPickup_Cash.ValidTouch with minor change to the first if statement
     */
    function bool ValidTouch(Pawn Other) {
        local Actor HitA;
        local vector HitLocation, HitNormal;
        local bool bHitWall;

        // Altering this condition to allow KFPawn_Monster objects to be considered a valid touch
        if (Other == None || (!Other.bCanPickupInventory && !Other.IsA('KFPawn_Monster')) || (Other.DrivenVehicle == None && Other.Controller == None)) {
            return false;
        }

        // prevent picking up as soon as it's spawned
        if (Other == Instigator && `TimeSince(CreationTime) < 0.1f) {
            return false;
        }

        // make sure not touching through wall
        foreach Other.TraceActors(class'Actor', HitA, HitLocation, HitNormal, MyCylinderComp.GetPosition() + vect(0,0,10), Other.Location/*, vect(1,1,1)*/) {
            if (IsTouchBlockedBy(HitA)) {
                if (MyMeshComp == None) {
                    return false;
                } else {
                    bHitWall = true;
                    break;
                }
            }
        }
        if (bHitWall) {
            // fail only if wall between both cylinder and mesh center
            foreach Other.TraceActors(class'Actor', HitA, HitLocation, HitNormal, MyMeshComp.Bounds.Origin + vect(0,0,10), Other.Location/*, vect(1,1,1)*/) {
                if ( IsTouchBlockedBy(HitA) ) {
                    return false;
                }
            }
        }

        // make sure game will let player pick me up
        if (WorldInfo.Game.PickupQuery(Other, Inventory.class, self)) {
            return true;
        }
        return false;
    }
}

function GiveTo(Pawn P) {
    if (P.IsA('KFPawn_Monster')) {
        `Log("Damage? " $ (damageToDosh * CashAmount));
        P.TakeDamage(damageToDosh * CashAmount, Controller(TosserPRI.Owner), Location, Velocity, class'KFDT_Explosive');
        PickedUpBy(P);
    } else {
        super.GiveTo(P);
    }
}

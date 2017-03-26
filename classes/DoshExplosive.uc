class DoshExplosive extends KFDroppedPickup_Cash;

var float damageToDosh;
var class<DamageType> doshDamageType;

auto state Pickup {
    /**
     * Copied from KFDroppedPickup_Cash.ValidTouch with minor change to the first if statement
     */
    function bool ValidTouch(Pawn Other) {
        local Actor HitA;
        local vector HitLocation, HitNormal;
        local TraceHitInfo HitInfo;
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
        foreach Other.TraceActors(class'Actor', HitA, HitLocation, HitNormal, MyCylinderComp.GetPosition() + vect(0,0,10), Other.Location, vect(1,1,1), HitInfo) {
            if (IsTouchBlockedBy(HitA, HitInfo.HitComponent)) {
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
            foreach Other.TraceActors(class'Actor', HitA, HitLocation, HitNormal, MyMeshComp.Bounds.Origin + vect(0,0,10), Other.Location, vect(1,1,1), HitInfo) {
                if ( IsTouchBlockedBy(HitA, HitInfo.HitComponent) ) {
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
        P.TakeDamage(damageToDosh * CashAmount, Controller(TosserPRI.Owner), Location, Velocity, doshDamageType);
        PickedUpBy(P);
    } else {
        super.GiveTo(P);
    }
}

defaultproperties
{
    doshDamageType=class'DoshDamageType'
}

class WDMutator extends KFGame.KFMutator
    config(WeaponizedDosh);

var() config float damageToDosh;

function bool OverridePickupQuery(Pawn Other, class<Inventory> ItemClass, Actor Pickup, out byte bAllowPickup) {
    local KFDroppedPickup_Cash cashPickup;

    if (Pickup.IsA('KFDroppedPickup_Cash') && Other.IsA('KFPawn_Monster')) {
        cashPickup= KFDroppedPickup_Cash(Pickup);
        Other.TakeDamage(damageToDosh * cashPickup.CashAmount, Controller(cashPickup.TosserPRI.Owner), Pickup.Location, Pickup.Velocity, class'KFDT_Explosive');
        cashPickup.PickedUpBy(Other);
        bAllowPickup= 0;
        return true;
    }

    return super.OverridePickupQuery(Other, ItemClass, Pickup, bAllowPickup);
}

defaultproperties
{
    damageToDosh=1.0
}

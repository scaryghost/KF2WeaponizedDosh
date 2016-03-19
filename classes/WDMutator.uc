class WDMutator extends KFGame.KFMutator
    config(WeaponizedDosh);

var() config float damageToDosh;

function bool CheckReplacement(Actor Other) {
    if (KFPawn(Other) != None) {
        KFPawn(Other).InventoryManagerClass=class'WDInventoryManager';
    } else if (KFInventory_Money(Other) != None) {
        KFInventory_Money(Other).DroppedPickupClass= class'DoshBomb';
    } else if (DoshBomb(Other) != None) {
        `Log("Setting " $ damageToDosh);
        DoshBomb(Other).damageToDosh= damageToDosh;
    }
    return super.CheckReplacement(Other);
}

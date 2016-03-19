class WDInventoryManager extends KFInventoryManager;

/**
 * Copied from KFInventoryManager.ServerThrowMoney
 * Changed implementation so custom cash pickup class can be used
 */
reliable server function ServerThrowMoney() {
    local Inventory Inv;
    local KFGameReplicationInfo MyKFGRI;

    if (Instigator != none) {
        MyKFGRI = KFGameReplicationInfo(WorldInfo.GRI);

        foreach InventoryActors(class'Inventory', Inv) {
            // Changed equality check to ClassIsChildOf
            if (ClassIsChildOf(Inv.DroppedPickupClass, class'KFDroppedPickup_Cash')) {
                if (MyKFGRI != none && MyKFGRI.CurrentObjective != none) {
                    MyKFGRI.CurrentObjective.CheckForPayDayPawn(Instigator);
                }

                Instigator.TossInventory(Inv);
                return;
            }
        }
    }
}

class QHMutatorConfigFix extends QHDefaultsKF;

function registerMenuItems(WebAdminMenu menu) {
    super.registerMenuItems(menu);
    menu.addMenu("/settings/mutators", menuMutators, self, menuMutatorsDesc);
}

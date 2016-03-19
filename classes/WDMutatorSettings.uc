class WDMutatorSettings extends WebAdminSettings;

function initSettings() {
    SetFloatPropertyByName('damageToDosh', class'WDMutator'.default.damageToDosh);
}

function saveSettings() {
    super.saveSettings();
    class'WDMutator'.static.StaticSaveConfig();
}

protected function saveInternal() {
    GetFloatPropertyByName('damageToDosh', class'WDMutator'.default.damageToDosh);
}

defaultproperties
{
    Properties[0]=(PropertyId=0,Data=(Type=SDT_Float))
    PropertyMappings[0]=(Id=0,name="damageToDosh",MappingType=PVMT_RawValue,MinVal=1)
}

# About
This project is a port of the Killing Floor mutator ever made, WeaponizedDosh, to Killing Floor 2

# Compiling the Code
The code operates with the assumption that the package name is **WeaponizedDosh**.  If you are download the code with the "Download ZIP" 
button, make sure rename the folder to **WeaponizedDosh**.  If cloning the project with Git, you can set the destination to have a 
different name from the project.

```git
git clone https://github.com/scaryghost/KF2WeaponizedDosh.git WeaponizeDosh
```

# Loading the Mutator
## Command Line
Loading the mutator via the command line is done by adding the fully qualified mutator classname to the start command:
```
?mutator=WeaponizedDosh.WDMutator
```

## WebAdmin
Loading the mutator via the web admin page will require modifying the KFGame localization and INI files.  First, open up **KFGame.int**
and add the following lines:
```ini
[WDMutator KFMutatorSummary]
FriendlyName="Weaponized Dosh"
Description="Use your greatest weapon in battle instead of spending it on subpar weapons"
```

Next, open up **PCServer-KFGame.ini** and add the following lines:
```ini
[WDMutator KFMutatorSummary]
ClassName=WeaponizedDosh.WDMutator
```

If configured correctly, you will see **Weaponized Dosh** as a selectable mutator on the **Change Map** page and as an active mutator on 
the **Server Info** page.  Screen shots of what this looks are avialable on [Dropbox](https://www.dropbox.com/sh/swtnyht9g2d7t9c/AACfQTq9KD2FoHBhSOZbBZLZa?dl=0).


# Mutator Configuration
Mutator configuration is stored in the **KFWeaponizedDosh.ini** file; running the mod will create the file if it does not exist.  There 
is only one configurable option for this mutator; **damageToDosh**.  This variable is a float that controls how much damage 1£ deals.

## WebAdmin
Due to a  mistake in the web admin code, if you wish to configure the mutator via the web admin, there is one more change that must be 
made to the server configuration.  Open up the **KFWebAdmin.ini** file and search for the **QueryHandlers** option under the 
**WebAdmin.WebAdmin** section.

 ```ini
[WebAdmin.WebAdmin]
QueryHandlers=WebAdmin.QHCurrentKF
QueryHandlers=WebAdmin.QHDefaultsKF
QueryHandlers=WebAdmin.WebAdminSystemSettings
```

Replace the entry that says **WebAdmin.QHDefaultsKF** with **WeaponizedDosh.MutatorConfigHandler**

```ini
[WebAdmin.WebAdmin]
QueryHandlers=WebAdmin.QHCurrentKF
QueryHandlers=WeaponizedDosh.MutatorConfigHandler
QueryHandlers=WebAdmin.WebAdminSystemSettings
```

This adds a **Mutator** item under the **Settings** section on the web admin navigation bar.  This extra step will no longer be necessary 
when TWI addresses the mutator configuration bug.
bug,

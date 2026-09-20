# <img width="48" height="48" alt="CowTools Corel icon round white bg" src="https://github.com/user-attachments/assets/e6d3c273-a87d-4641-89f3-17082242db59" /> CowTools

**CowTools** is a small collection of CorelDRAW macros made to speed up repetitive print-shop tasks.

The name is a small nod to Gary Larson's comics. The tools themselves are considerably less surreal: the goal is simply to turn jobs that take dozens of clicks into one or two.

The project is currently built and tested around **CorelDRAW 2022 (v24)**.

## What it does

The first CowTools macro is aimed at sticker-sheet production.

If you already have templates with an optimized arrangement of placeholder shapes—for example, circles for 4 cm, 5 cm, and 6 cm stickers—the macro lets you:

1. Import the client's artwork.
2. Select the artwork and the grouped template.
3. Run the macro.
4. Have CorelDRAW duplicate the artwork into every placeholder position automatically.

Each copy is resized to match the corresponding placeholder and centered on it. The placeholder group is then removed, leaving the finished sheet ready for the next production steps.

The original artwork is left untouched.

## Current macro

### `ReplaceGroupWithCopies`

Select exactly two objects:

- the artwork you want to repeat;
- a group containing the placeholder objects.

Run the macro and CowTools will:

- create one copy of the artwork for every object in the group;
- resize each copy to the width and height of its placeholder;
- center each copy on that placeholder;
- delete the placeholder group;
- keep the whole operation as a single Undo step.

### A note about proportions

The current version resizes the artwork to the exact width and height of each placeholder.

That is ideal when the artwork already has the same proportions as the template—for example, circular artwork going into circular sticker placeholders.

If the artwork has a different aspect ratio, it may be stretched. A future version may add proportional scaling and automatic cropping/PowerClip behavior.

## Installation

### Option 1 — Install the `.gms` file

If the repository includes a ready-made `CowTools.gms` file:

1. Close CorelDRAW.
2. Copy `CowTools.gms` to:

```text
%AppData%\Corel\CorelDRAW Graphics Suite 2022\Draw\GMS
```

3. Open CorelDRAW again.

CowTools should now appear among the available VBA macros/scripts.

### Option 2 — Use the installer

If the repository includes the installer batch file:

1. Put the installer and `CowTools.gms` in the same folder.
2. Double-click the installer.
3. Restart CorelDRAW.

The installer copies the GMS file to the current user's CorelDRAW macro folder, so administrator privileges should normally not be necessary.

### Option 3 — Import the source manually

If you only want to use or modify the source code:

1. Open CorelDRAW.
2. Open the VBA editor with `Alt+F11`.
3. Create a new VBA/GMS project named `CowTools`.
4. In the VBA editor, right-click the project and choose **Import File...**
5. Import `CowTools.bas`.
6. Save the project.

## Assigning a keyboard shortcut

For quick use in production, assigning the macro to a shortcut is recommended.

In CorelDRAW, open the keyboard customization settings, find:

```text
CowTools.ReplaceGroupWithCopies
```

and assign whatever shortcut is convenient for your workflow.

## Example workflow

For a 4 cm round-sticker template:

```text
Open 4 cm template
        ↓
Import client artwork
        ↓
Select artwork + grouped placeholders
        ↓
Run CowTools
        ↓
Finished sticker sheet
```

The same macro can be used with other template sizes because the copies take their dimensions from the placeholder objects.

## Why this exists

CowTools started as a way to automate repetitive CorelDRAW work in a print-shop environment.

A lot of these jobs are individually simple, but doing the same positioning, duplicating, resizing, and aligning dozens of times adds up quickly. The idea behind the project is to keep the existing CorelDRAW workflow while removing the repetitive parts.

## Compatibility

Currently developed for:

- **CorelDRAW 2022**
- **Version 24.x**
- Windows
- VBA-enabled CorelDRAW installations

Other versions may work, but have not necessarily been tested.

## Source

The project is written in **VBA using the CorelDRAW object model**.

The `.bas` file is included so the macro can be inspected, modified, and extended without depending on the compiled `.gms` project.

## Future ideas

Possible additions include:

- proportional artwork scaling;
- automatic PowerClip/cropping for non-square artwork;
- more print-layout helpers;
- utilities for repetitive text and name-placement jobs;
- other small production shortcuts that prove useful in day-to-day CorelDRAW work.

## Contributing

This is a small practical project, but suggestions, bug reports, and improvements are welcome.

If a macro behaves differently in another CorelDRAW version, opening an issue with the version number and a description of the behavior would be especially useful.

---

CowTools is an independent project and is not affiliated with Corel or Gary Larson.

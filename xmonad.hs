------------------------------------------------------------------------
-- Base                                                              {{{
------------------------------------------------------------------------
import XMonad
import XMonad.Layout
import System.Directory
import System.IO 
import System.Exit 
import qualified XMonad.StackSet as W

---------------------------------------------------------------------}}}
-- Actions                                                           {{{
------------------------------------------------------------------------
import XMonad.Actions.CopyWindow
import XMonad.Actions.PerLayoutKeys
import XMonad.Actions.Navigation2D as Nav2d
import XMonad.Actions.CopyWindow 
import XMonad.Actions.CycleWS 
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves 
import XMonad.Actions.WindowGo 
import XMonad.Actions.WithAll 
import qualified XMonad.Actions.Search as S

---------------------------------------------------------------------}}}
-- Data                                                              {{{
------------------------------------------------------------------------
import Data.Foldable
import Data.Char 
import Data.Maybe 
import Data.Monoid
import Control.Monad
import Data.Maybe 
import Data.Tree
import qualified Data.Map as M

---------------------------------------------------------------------}}}
-- Hooks                                                             {{{
------------------------------------------------------------------------
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

---------------------------------------------------------------------}}}
-- Layouts                                                           {{{
------------------------------------------------------------------------
import XMonad.Layout.SubLayouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.Master
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

---------------------------------------------------------------------}}}
-- Layouts Modifier                                                  {{{
------------------------------------------------------------------------
import XMonad.Layout.MultiToggle as MT
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Gaps
import XMonad.Layout.Reflect
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger 

---------------------------------------------------------------------}}}
-- Utilities                                                         {{{
------------------------------------------------------------------------
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Util.Loggers
import XMonad.Util.NamedWindows
import XMonad.Util.Run
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run 
import XMonad.Util.SpawnOnce

---------------------------------------------------------------------}}}
-- Prompt                                                            {{{
------------------------------------------------------------------------
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt

---------------------------------------------------------------------}}}
-- ColorScheme                                                       {{{
------------------------------------------------------------------------
import Colors.GruvboxMaterialDark

---------------------------------------------------------------------}}}
-- Theme                                                             {{{
------------------------------------------------------------------------
myTabTheme = def { fontName            = myTabFont
                 , activeColor         = colorOrange
                 , inactiveColor       = colorBg
                 , activeBorderColor   = colorOrange
                 , inactiveBorderColor = colorBg
                 , activeTextColor     = colorBg
                 , inactiveTextColor   = colorFg
                 , decoHeight          = 18
                 }

myTopBarTheme = def { fontName              = myFont
                    , inactiveBorderColor   = colorBg
                    , inactiveColor         = colorBg
                    , inactiveTextColor     = colorBg
                    , activeBorderColor     = colorOrange
                    , activeColor           = colorOrange
                    , activeTextColor       = colorOrange
                    , urgentBorderColor     = colorbgRed
                    , urgentTextColor       = colorbgRed
                    , decoHeight            = 8
                    }

myPromptTheme = def { font                  = myFont
                    , bgColor               = colorBg
                    , fgColor               = colorFg
                    , fgHLight              = colorFg
                    , bgHLight              = colorbgRed
                    , borderColor           = colorBg
                    , promptBorderWidth     = myBorderWidth
                    , height                = myPromptWidth
                    , position              = myPromptPosition
                    }

warmPromptTheme = myPromptTheme { bgColor               = colorGreen
                                , fgColor               = colorFg
                                , position              = myPromptPosition
                                }

hotPromptTheme = myPromptTheme  { bgColor               = colorbgRed
                                , fgColor               = colorBg
                                , position              = myPromptPosition
                                }

myFont = "xft:monospace:regular:size=10:antialias=true:hinting=true"
myTabFont = "xft:monospace:regular:size=8:antialias=true:hinting=true"
myBorderWidth = 2          
myPromptWidth = 20
myPromptPosition = Top
myNormColor  = colorBg
myFocusColor = colorOrange

---------------------------------------------------------------------}}}
-- Applications                                                      {{{
------------------------------------------------------------------------
myTerminal = "alacritty"   
myBrowser = "firefox-esr"  
myModMask = mod4Mask        
myEditor = myTerminal ++ " -e nvim "    
myResourceManager = myTerminal ++ " -e htop "    

---------------------------------------------------------------------}}}
-- Startup                                                           {{{
------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
    spawn "xsetroot -cursor_name left_ptr"
    spawn "killall trayer"
    spawn ("sleep 2 && trayer --edge top --align right --widthtype request --SetDockType true --SetPartialStrut true --expand true  --transparent false --alpha 0 " ++ colorTrayer ++ " --height 21 --padding 3 --iconspacing 3")
    spawn "conky"
    spawn "picom"
    spawn "feh --bg-fill ~/.config/xmonad/Gruv-street.png"  
    spawnOnce "numlockx"
    spawnOnce "nm-applet"
    setWMName "LG3D"

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "mocp" spawnMocp findMocp manageMocp
                , NS "calculator" spawnCalc findCalc manageCalc
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnMocp  = myTerminal ++ " -t mocp -e mocp"
    findMocp   = title =? "mocp"
    manageMocp = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Single window has gaps;
--mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myNav2DConf = def
    { defaultTiledNavigation    = sideNavigation
    , floatNavigation           = centerNavigation
    , screenNavigation          = lineNavigation
    , layoutNavigation          = [("Full", centerNavigation), ("ReflectX Full", centerNavigation)]
    , unmappedWindowRect        = [("Full", singleWindowRect), ("ReflectX Full", singleWindowRect)]
    }

---------------------------------------------------------------------}}}
-- Main                                                              {{{
------------------------------------------------------------------------
main :: IO ()
main = do
    xmonad
      $ Hacks.javaHack
      $ ewmh
      $ withUrgencyHook NoUrgencyHook
      $ docks
      $ withNavigation2DConfig myNav2DConf
      $ withSB (statusBarProp "xmobar ~/.config/xmobar/xmobar.hs" (copiesPP (xmobarColor colorFg colorBg . wrap
               ("<box type=Bottom width=4 mb=2 color=" ++ colorFg ++ ">") "</box>") myXmobarPP))
      $ myConfig

myConfig = def
    { manageHook         = insertPosition Below Newer <+> myManageHook
    , handleEventHook    = myHandleEventHook
    , modMask            = myModMask
    , terminal           = myTerminal
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , startupHook        = myStartupHook
    , layoutHook         = configurableNavigation noNavigateBorders $ withBorder myBorderWidth $ myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    }
  `additionalKeysP`

---------------------------------------------------------------------}}}
-- Bindings                                                          {{{
------------------------------------------------------------------------
------------------------------------------------------------------------
-- Key Bindings
------------------------------------------------------------------------
    [ ("M-S-w", confirmPrompt hotPromptTheme "kill all windows in this workspace?" $ killAll)
    , ("M-S-r", spawn "xmonad --recompile && xmonad --restart") -- Restarts xmonad
    , ("M-S-e", confirmPrompt hotPromptTheme "Quit Xmonad?" $ io exitSuccess)  -- Quits xmonad
    , ("M-c", toggleCopyToAll)
    -- KB_GROUP Run Prompt
    --, ("M-S-<Return>", spawn "dm-run") -- Dmenu
    , ("M-S-<Return>", spawn (myTerminal ++ " --working-directory \"`xcwd`\""))

    -- KB_GROUP Useful programs to have a keybinding for launch
    , ("M-<Return>", spawn $ myTerminal)
    , ("M-b", spawn $ myBrowser)
    , ("M-n", spawn $ myEditor)
    , ("M1-h", spawn $ myResourceManager)
    , ("M-d", spawn "dmenu_run")

  -- KB_GROUP Kill windows
    , ("M-q", (withFocused $ windows . W.sink) >> kill1)  -- Kill the currently focused client
    , ("M-S-q", killAll) -- Kill all windows of focused client on current ws

  -- KB_GROUP Workspaces
    , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next ws
    , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to prev ws

  -- KB_GROUP Floating windows
    , ("M-f", (sinkAll) >> sendMessage (MT.Toggle FULL))
    , ("M-v", sendMessage ToggleStruts)
    , ("M-x", sendMessage $ MT.Toggle REFLECTX)
    , ("M-y", withFocused toggleFloat)
    , ("M-S-y", sinkAll)                       -- Push ALL floating windows to tile

  -- KB_GROUP Increase/decrease spacing (gaps)
  {-
    , ("M1-j", decWindowSpacing 4)         -- Decrease window spacing
    , ("M1-k", incWindowSpacing 4)         -- Increase window spacing
    , ("M1-h", decScreenSpacing 4)         -- Decrease screen spacing
    , ("M1-l", incScreenSpacing 4)         -- Increase screen spacing
    , ("M1-h", sendMessage $ MirrorExpand)
    , ("M1-j", sendMessage $ MirrorShrink)
    , ("M1-k", sendMessage $ MirrorExpand)
    , ("M1-l", sendMessage $ MirrorShrink)
   -}

  -- KB_GROUP Grid Select (CTR-g followed by a key)
    --, ("M-g", spawnSelected' myAppGrid)                 -- grid select favorite apps
    --, ("C-g t", goToSelected $ mygridConfig myColorizer)  -- goto selected window
    --, ("C-g b", bringSelected $ mygridConfig myColorizer) -- bring selected window

  -- KB_GROUP Windows navigation
    , ("M-j",   Nav2d.windowGo D False)
    , ("M-k",   Nav2d.windowGo U False)
    , ("M-h",   Nav2d.windowGo L False)
    , ("M-l",   Nav2d.windowGo R False)
    , ("M-S-j",   Nav2d.windowSwap D False)
    , ("M-S-k",   Nav2d.windowSwap U False)
    , ("M-S-h",   Nav2d.windowSwap L False)
    , ("M-S-l",   Nav2d.windowSwap R False)
    , ("M-m", windows W.focusDown)    -- Quick fix for monocle layout
    , ("M-S-m", windows W.focusUp)    -- Quick fix for monocle layout
    , ("M-<Backspace>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
    , ("M-S-<Backspace>", rotAllDown)       -- Rotate all the windows in the current stack

  -- KB_GROUP Layouts
    , ("M-<Space>", sendMessage NextLayout)           
    , ("M1-<Space>", spawn "rofi -modi drun -show drun -config ~/.config/rofi/rofidmenu.rasi")           
    --, ("M-d", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

  -- KB_GROUP Increase/decrease windows in the master pane or the stack
    , ("M1-S-k", sendMessage $ IncMasterN 1)      -- Increase # of clients master pane
    , ("M1-S-j", sendMessage $ IncMasterN (-1)) -- Decrease # of clients master pane

  -- KB_GROUP Sublayouts
    , ("M-C-h", sendMessage $ pullGroup L)
    , ("M-C-l", sendMessage $ pullGroup R)
    , ("M-C-k", sendMessage $ pullGroup U)
    , ("M-C-j", sendMessage $ pullGroup D)
    , ("M-C-m", withFocused (sendMessage . MergeAll))
    , ("M-C-u", withFocused (sendMessage . UnMerge))
    , ("M-M1-l", bindByLayout [("Tabbed", windows W.focusDown), ("", onGroup W.focusUp')]) -- Switch focus to prev tab
    , ("M-M1-h", bindByLayout [("Tabbed", windows W.focusUp), ("", onGroup W.focusDown')])  -- Switch focus to next tab

  -- KB_GROUP Scratchpads
    , ("M-s t", namedScratchpadAction myScratchPads "terminal")
    , ("M-s m", namedScratchpadAction myScratchPads "mocp")
    , ("M-s c", namedScratchpadAction myScratchPads "calculator")

  -- KB_GROUP Controls for mocp music player (SUPER-u followed by a key)
    , ("M-u p", spawn "mocp --play")
    , ("M-u l", spawn "mocp --next")
    , ("M-u h", spawn "mocp --previous")
    , ("M-u <Space>", spawn "mocp --toggle-pause")

  -- KB_GROUP Multimedia Keys
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
    , ("M1-m", spawn "amixer -q sset Capture toggle")
    , ("<XF86HomePage>", spawn "qutebrowser https://www.youtube.com/c/DistroTube")
    , ("<XF86Search>", spawn "dm-websearch")
    , ("<XF86Mail>", runOrRaise "thunderbird" (resource =? "thunderbird"))
    , ("<XF86Calculator>", runOrRaise "qalculate-gtk" (resource =? "qalculate-gtk"))
    , ("<XF86Eject>", spawn "toggleeject")
    , ("<Print>", spawn "scrot")
    ]

------------------------------------------------------------------------
-- Mouse Bindings
------------------------------------------------------------------------
  `additionalMouseBindings`
    [ ((0, 8), (\_ -> spawn "amixer set Master 5%- unmute"))
    , ((0, 9), (\_ -> spawn "amixer set Master 5%+ unmute"))
    ]

------------------------------------------------------------------------
-- ScratchPads
------------------------------------------------------------------------
  -- The following lines are needed for named scratchpads.
      where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
            nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

------------------------------------------------------------------------
-- Custom Bindings Helpers
------------------------------------------------------------------------
toggleFloat :: Window -> X ()
toggleFloat w =
  windows
    ( \s ->
        if M.member w (W.floating s)
          then W.sink w s
          else (W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s)
    )

toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
                [] -> windows copyToAll
                _ -> killAllOtherCopies

---------------------------------------------------------------------}}}
-- workspaces                                                        {{{
------------------------------------------------------------------------
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
--myWorkspaces = ["  01  ", "  02  ", "  03  ", "  04  ", "  05  ", "  06  ", "  07  ", "  08  ", "  09  "]
--myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

---------------------------------------------------------------------}}}
-- The Manage Hook                                                   {{{
------------------------------------------------------------------------
myManageHook :: ManageHook
myManageHook =
        manageDocks
    <+> fullscreenManageHook
    <+> composeAll
    [ checkDock                      --> doLower
    , className =? "confirm"         --> doFloat
    , className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "Gimp"            --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "pinentry-gtk-2"  --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , className =? "zoom"            --> doFloat
    , className =? "Yad"             --> doCenterFloat
    , isFullscreen                   --> doFullFloat
    ] <+> namedScratchpadManageHook myScratchPads

---------------------------------------------------------------------------
-- X Event Actions
---------------------------------------------------------------------------
myHandleEventHook = XMonad.Layout.Fullscreen.fullscreenEventHook
                <+> Hacks.windowedFullscreenFixEventHook

---------------------------------------------------------------------------
-- Custom Hook Helpers
---------------------------------------------------------------------------
forceCenterFloat :: ManageHook
forceCenterFloat = doFloatDep move
  where
    move :: W.RationalRect -> W.RationalRect
    move _ = W.RationalRect x y w h

    w, h, x, y :: Rational
    w = 1/3
    h = 1/2
    x = (1-w)/2
    y = (1-h)/2

---------------------------------------------------------------------}}}
-- The Layout Hook                                                   {{{
------------------------------------------------------------------------
myLayoutHook =   avoidStruts
               $ fullscreenFloat
               $ mouseResize
               $ mkToggle (single REFLECTX)
               $ mkToggle (single FULL) 
               $ myLayouts
             where
             myLayouts =       tall
                           ||| grid
                           ||| threeCol
                           ||| threeColMid
                           ||| tabs

tall     = renamed [Replace "MasterStack"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []
grid     = renamed [Replace "Grid"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 5
           $ Grid (16/10)
threeColMid = renamed [Replace "CenteredMaster"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 5
           $ ThreeColMid 1 (3/100) (1/2)
threeCol = renamed [Replace "CenteredFloatingMaster"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 5
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "Tabbed"]
           $ tabbed shrinkText myTabTheme

---------------------------------------------------------------------}}}
-- The XmobarPP                                                      {{{
------------------------------------------------------------------------
myXmobarPP :: PP
myXmobarPP = def
    { ppSep = xmobarColor colorBg "" "  "
    , ppCurrent = xmobarColor colorBg colorOrange . wrap ("<box color=colorOrange>") "</box>"
    , ppHidden = xmobarColor colorFg colorBg 
    , ppHiddenNoWindows = xmobarColor colorBg5 colorBg
    , ppUrgent = xmobarColor colorbgRed colorBg . wrap ("<box type=Bottom width=4 mb=2 color=" ++ colorbgRed ++ ">") "</box>"
    , ppLayout = xmobarColor colorFg colorBg
    , ppTitle = xmobarColor colorFg "" . wrap 
    (xmobarColor colorFg "" "[") (xmobarColor colorFg "" "]") . xmobarColor colorOrange "" . shorten 11 
    }

-- }}}

{- TODOS:
 - REMOVE USELESS IMPORTS
 - MATCH HASKELL STANDARDS
 - GRID SELECT
 - CHECK WINDOW SWALLOW
-}

-- vim: ft=haskell:foldmethod=marker:expandtab:ts=4:shiftwidth=4

import XMonad
import XMonad.Hooks.DynamicLog (xmobar)
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Actions.SpawnOn
import XMonad.Layout.Spacing (smartSpacing)
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Hooks.EwmhDesktops

myLayoutHook = smartBorders ( Grid )

myManageHook = composeAll
  [ className =? "Code"       --> doShift "2"
  , className =? "Firefox"    --> doShift "3"
  , className =? "Origin"     --> doFloat
  , className =? "Wine"       --> doFloat
  , className =? "Lutris"     --> doFloat
  ]


myStartupHook = do
  spawnOn "1" "alacritty"
  spawnOn "2" "code"
  spawnOn "3" "firefox"

myConfig = def
  {
  terminal = "alacritty"
  ,  handleEventHook    = fullscreenEventHook
  ,  modMask     = mod4Mask -- set 'Mod' to windows key
  ,  manageHook  = manageHook defaultConfig <+> manageSpawn <+> manageDocks <+> myManageHook
  ,  layoutHook  = myLayoutHook
  ,  startupHook = myStartupHook
  } `additionalKeys`
  [ 
    (( mod4Mask             , xK_l), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%") 
  , (( mod4Mask             , xK_h), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
  , (( mod4Mask             , xK_s), spawn "/opt/bin/terminate.sh")
  ]
main = xmonad =<< xmobar myConfig


{ variant }:
with variant;
{
  mPrimary = blue;
  mOnPrimary = background;
  mSecondary = green;
  mOnSecondary = background;
  mTertiary = purple;
  mOnTertiary = background;
  mError = red;
  mOnError = background;
  mSurface = background;
  mOnSurface = bright-white;
  mSurfaceVariant = surface-variant;
  mOnSurfaceVariant = foreground;
  mOutline = bright-black;
  mShadow = "#000000";
  mHover = blue;
  mOnHover = background;

  terminal = {
    inherit foreground background;
    selectionFg = selection.foreground;
    selectionBg = selection.background;
    cursorText = background;
    cursor = foreground;

    normal = {
      inherit
        black
        red
        green
        yellow
        blue
        cyan
        white
        ;
      magenta = purple;
    };

    bright = {
      black = bright-black;
      red = bright-red;
      green = bright-green;
      yellow = bright-yellow;
      blue = bright-blue;
      magenta = bright-purple;
      cyan = bright-cyan;
      white = bright-white;
    };
  };
}

gnustep-macports-fixes
----------------------

This is an attempt to rewrite the GNUstep macports ports.

For example, supposing you clone the repository into ~/gnustep-macports-fixes:

    cd ~/gnustep-macports-fixes
    portindex

Next, edit your macports sources file:

    sudo vim /opt/local/etc/macports/sources.conf

and add a line like:

    file:///Users/yourusername/gnustep-macports-fixes


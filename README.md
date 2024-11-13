[![Actions Status](https://github.com/raku-community-modules/Digest-xxHash/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Digest-xxHash/actions) [![Actions Status](https://github.com/raku-community-modules/Digest-xxHash/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Digest-xxHash/actions)

NAME
====

Digest::xxHash - xxHash bindings for Raku

SYNOPSIS
========

```raku
# 32 or 64 bit xxHash from a string
say xxHash("dupa");

# 32 or 64 bit xxHash from a file
say xxHash(:file<filename.txt>);

# 32 or 64 bit xxHash from a file IO handle
say xxHash(filehandle);

# 32 or 64 bit xxHash from Buf
say xxHash(Buf[uint8].new(0x64, 0x75, 0x70, 0x61))

# You may call the 32 or 64 bit specific versions directly if desired,
# bypassing the architecture check.

# 32 bit
say xxHash32("dupa");

# 64 bit
say xxHash64("dupa");
```

DESCRIPTION
===========

The Digest::xxHash distribution exports three subroutines: `xxHash`, `xxHash32` and `xxHash64`.

The `xxHash` subroutine returns a 64 bit xxHash from a string (32 bit if no native 64 bit logic is available).

The `xxHash32` and `xxHash64` subroutines return a 32 bit / 64 bit xxHash respectively (64 bit only if supported by architecture).

Depends on the [libxxhash](https://github.com/Cyan4973/xxHash) native library.

AUTHORS
=======

  * Bartłomiej Palmowski

  * Andy Weidenbaum

  * Steve Schulze

COPYRIGHT AND LICENSE
=====================

Copyright 2013 - 2014 Bartłomiej Palmowski

Copyright 2013 - 2023 Andy Weidenbaum

Copyright 2024 Raku Community

This is free and unencumbered public domain software. For more information, see http://unlicense.org/ or the accompanying UNLICENSE file.


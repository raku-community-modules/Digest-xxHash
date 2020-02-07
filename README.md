# Digest::xxHash

Raku bindings for xxHash.


## Usage

```raku
# 32 or 64 bit xxHash from string, automatically select 64 bit if available else
# fall back to 32 bit depending on architecture.

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

## Dependencies

- Raku
- [libxxhash][libxxhash] ([mac][mac], [pac][pac], [void][void])


## Licensing

This is free and unencumbered public domain software. For more
information, see http://unlicense.org/ or the accompanying UNLICENSE file.

[libxxhash]: https://github.com/Cyan4973/xxHash
[mac]: http://formulae.brew.sh/formula/xxhash
[pac]: https://www.archlinux.org/packages/community/x86_64/xxhash/
[void]: https://github.com/void-linux/void-packages/blob/master/srcpkgs/xxHash/template

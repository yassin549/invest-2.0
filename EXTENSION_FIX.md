# PHP Extension Fix

## Error Found
```
error: attribute 'json' missing
```

## Problem
Some PHP extensions don't exist as separate packages in Nix because they're built into PHP 8.3 core:
- ❌ `json` - Built into PHP core
- ❌ `tokenizer` - Built into PHP core  
- ❌ `ctype` - Built into PHP core
- ❌ `openssl` - Built into PHP core
- ❌ `session` - Built into PHP core
- ❌ `xml` - Should be `dom` instead

## Fix Applied
Updated `nixpacks.toml` to only include extensions that need explicit installation:

```toml
nixPkgs = [
  "php83",
  "php83Packages.composer",
  "php83Extensions.pdo",
  "php83Extensions.pdo_mysql",
  "php83Extensions.mysqli",
  "php83Extensions.mbstring",
  "php83Extensions.dom",           # XML support
  "php83Extensions.curl",
  "php83Extensions.gd",            # Image processing
  "php83Extensions.zip",
  "php83Extensions.bcmath",        # Payment calculations
  "php83Extensions.intl",          # Internationalization
  "php83Extensions.fileinfo"       # File type detection
]
```

## Deploy Now
```bash
git add .
git commit -m "Fix PHP extensions - remove built-in extensions"
git push
```

This should fix the Nix build error and allow the deployment to proceed.

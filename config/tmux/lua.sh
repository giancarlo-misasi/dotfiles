#!/bin/bash
cd -- "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)" || exit
lua theme.lua $@

#!/bin/bash

homeshick=${HOMESHICK_DIR:-$HOME/.homesick/repos/homeshick}/bin/homeshick
$homeshick pull -fb
$homeshick link -fb

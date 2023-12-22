#!/usr/bin/env nu

if (pamixer --get-mute) == true {
    print 0
} else {
    pamixer --get-volume
}
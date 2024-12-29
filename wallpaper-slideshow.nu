#!/usr/bin/env nu


def main [
    --default_wallpapers_path (-w): path, # If the wallpapers folder is empty, copy the wallpapers from this folder
    --interval (-i): duration
] {
    loop {
        mkdir ~/wallpapers
        let files = ^find -type f | split row "\n" | each {|relpath| "~/wallpapers" | path join $relpath | path expand } | shuffle;
        
        if ($files | is-empty) {
            print "No wallpapers"
            if (($default_wallpapers_path | describe) == "string") {
                print "Copying default wallpapers"
                cp -v ...(ls $default_wallpapers_path | get name) ~/wallpapers/
            }
            print "Waiting 1sec"
            sleep 1sec;
        } else {
            for image in $files {
                swww img $image --transition-fps 60 -t wave --transition-duration 4;
                sleep $interval;
            }
        }
    }
}
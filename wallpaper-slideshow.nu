#!/usr/bin/env nu


def main [
    --default_wallpapers_path (-w): path # If the wallpapers folder is empty, copy the wallpapers from this folder
] {
    loop {
        mkdir ~/wallpapers
        let files = ls ~/wallpapers/ | get name | shuffle;
        
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
                sleep 30sec;
            }
        }
    }
}
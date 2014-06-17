#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
    echo usage: $0 [address] [time interval in seconds]
    exit
fi
    echo "HICing $1"
    wget $1 -qO .old.txt
    wait
while  : ; do
    sleep $2
    wget $1 -qO .new.txt
    wait
    DIFF=$(diff .new.txt .old.txt)
    wait
    if [ "$DIFF" != "" ];then
        echo "something changed!"
        .date +%H:%M
        rm .old.txt .new.txt
        break
    fi
    mv .new.txt .old.txt
    wait
    case "$(( ( RANDOM % 4 )  + 1 ))" in
    "1")
        echo still nothing.....
        ;;
    "2")
        echo "nope!"
        ;;
    "3")
        echo "not yet!"
        ;;
    *)
        echo "still looking!"
        ;;
    esac
    echo ""
done

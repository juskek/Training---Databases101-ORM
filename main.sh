#!/usr/bin/env bash

source ./menu.sh

while true; do
    current_dir=$(pwd)

    build="Build docker image"
    run="Run docker container"
    exit="Exit"
    

    options=("$build" "$run" "$exit")

    select_option "${options[@]}"
    result="${options[$?]}"
    
    echo -e "\n===============OUTPUT===============\n"
    echo "You chose: $result"

    case $result in
        "$build")
            pipenv requirements > requirements.txt
            docker-compose build --no-cache
            ;;
        "$run")
            docker-compose up -d
            ;;
        "$exit")
            echo "Exiting..."
            break
            ;;

        *)
            print_error "Invalid option: $result"
            ;;
    esac

    cd "$current_dir" || exit 1
    echo -e "\n===============OUTPUT===============\n"
done

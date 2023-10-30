#!/usr/bin/env bash

source ./menu.sh

while true; do
    current_dir=$(pwd)

    build="Build docker image"
    run="Run docker container"
    restore="Restore db from pgdump backup file"
    generate="Generate ORM types"
    exit="Exit"
    

    options=("$build" "$run" "$restore" "$generate" "$exit")

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
        "$restore")
            cd db-data/ || exit 1
            docker exec -i training---databases101-orm-db-1 psql -U justin -d pokemon < ../restore/backup_dump.sql
            ;;
        "$generate")
            cd db-data/ || exit 1
            docker exec -i training---databases101-orm-web-1 python manage.py inspectdb > ../Databases101ORM/pokemon/models.py
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

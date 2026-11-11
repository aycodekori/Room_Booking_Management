
#!/bin/bash

# Room Management System

ROOM_FILE="rooms.txt"
BOOKING_FILE="bookings.txt"
HISTORY_FILE="history.txt"

touch "$ROOM_FILE" "$BOOKING_FILE" "$HISTORY_FILE"

add_room() {
    read -p "Enter Room Number: " room

    if grep -q "^$room|" "$ROOM_FILE"; then
        echo "Room already exists!"
    else
        echo "$room|Available" >> "$ROOM_FILE"
        echo "Room added successfully!"
    fi
}

view_rooms() {
    echo "------ Room List ------"
    cat "$ROOM_FILE"
}

book_room() {
    read -p "Enter Room Number: " room
    read -p "Enter Customer Name: " name

    if grep -q "^$room|Available$" "$ROOM_FILE"; then

        sed -i "s/^$room|Available$/$room|Booked/" "$ROOM_FILE"

        echo "$room|$name" >> "$BOOKING_FILE"
        echo "Room $room booked by $name" >> "$HISTORY_FILE"

        echo "Room booked successfully!"
    else
        echo "Room unavailable or does not exist!"
    fi
}

cancel_booking() {
    read -p "Enter Room Number: " room

    if grep -q "^$room|Booked$" "$ROOM_FILE"; then

        sed -i "s/^$room|Booked$/$room|Available/" "$ROOM_FILE"

        sed -i "/^$room|/d" "$BOOKING_FILE"

        echo "Booking cancelled for Room $room" >> "$HISTORY_FILE"

        echo "Booking cancelled successfully!"
    else
        echo "Room is not booked!"
    fi
}

search_room() {
    read -p "Enter Room Number: " room

    if grep -q "^$room|" "$ROOM_FILE"; then
        grep "^$room|" "$ROOM_FILE"
    else
        echo "Room not found!"
    fi
}

booking_history() {
    echo "------ Booking History ------"
    cat "$HISTORY_FILE"
}

while true
do
    echo ""
    echo "================================"
    echo "     ROOM MANAGEMENT SYSTEM"
    echo "================================"
    echo "1. Add Room"
    echo "2. View Rooms"
    echo "3. Book Room"
    echo "4. Cancel Booking"
    echo "5. Search Room"
    echo "6. Booking History"
    echo "7. Exit"

    read -p "Enter Your Choice: " choice

    case $choice in
        1) add_room ;;
        2) view_rooms ;;
        3) book_room ;;
        4) cancel_booking ;;
        5) search_room ;;
        6) booking_history ;;
        7) echo "Thank you!"; exit ;;
        *) echo "Invalid Choice!" ;;
    esac
done

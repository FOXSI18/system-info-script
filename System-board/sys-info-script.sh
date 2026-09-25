#!/bin/bash

# ╔════════════════════════════════════════╗
# ║           ◈  USER CONTROLS  ◈          ║
# ╠════════════════════════════════════════╣
# ║                                        ║
# ║   [CTRL + S]  ──◆──>  SAVE             ║
# ║   [CTRL + X]  ──◆──>  QUIT             ║
# ║   ./sys-info-script  ──◆──>  RUN       ║
# ║                                        ║
# ╚════════════════════════════════════════╝

# colors
RED=$'\033[1;31m'
GREEN=$'\033[1;32m'
YELLOW=$'\033[33m'
SP_GREEN=$'\033[38;5;47m' # spring green
MAGENTA=$'\033[38;5;164m'
ORANGE_RED=$'\033[38;5;202m'
NC=$'\033[0m' # no color

# init settings variables
clear_mode=0
status_clear="OFF"
display_mode=0
status_display="v"


# SHOW OPTIONS
print_menu() {
    case "$display_mode" in
        0)
            # Vertical
            echo "╭────────────────╮"
            echo "│ OS INFO        │"
            echo "│────────────────│"
            echo "│[1] Architecture│"
            echo "│[2] Uptime      │"
            echo "│[3] Host        │"
            echo "│[4] Generally   │"
            echo "╰────────────────╯"
            echo ""

            echo "╭────────────────╮"
            echo "│ HARDWARE       │"
            echo "│────────────────│"
            echo "│[5] CPU         │"
            echo "│[6] Hardware    │"
            echo "╰────────────────╯"
            echo ""

            echo "╭────────────────╮"
            echo "│ STORAGE SPACE  │"
            echo "│────────────────│"
            echo "│[7] Disks       │"
            echo "│[8] Free space  │"
            echo "│[9] Free RAM    │"
            echo "╰────────────────╯"
            echo ""

            echo "╭────────────────╮"
            echo "│ LOGS           │"
            echo "│────────────────│"
            echo "│[0] Processes   │"
            echo "╰────────────────╯"
            echo ""

            echo "╭────────────────╮"
            echo "│ OTHERS         │"
            echo "│────────────────│"
            echo "│[s] Settings    │"
            echo "│[r] Src code    │"
            echo "│[q] Quit        │"
            echo "╰────────────────╯"
            ;;

        1)
            # Horizontal
            echo "╭────────────────────╮    ╭────────────────────╮    ╭────────────────────╮    ╭────────────────────╮    ╭────────────────────╮"
            echo "│      OS INFO       │    │      HARDWARE      │    │    STORAGE SPACE   │    │        LOGS        │    │       OTHERS       │"
            echo "├────────────────────┤    ├────────────────────┤    ├────────────────────┤    ├────────────────────┤    ├────────────────────┤"
            echo "│ [1] Architecture   │    │ [5] CPU            │    │ [7] Disks          │    │ [0] Processes      │    │ [s] Settings       │"
            echo "│ [2] Uptime         │    │ [6] Hardware       │    │ [8] Free space     │    │                    │    │ [r] Src code       │"
            echo "│ [3] Host           │    │                    │    │ [9] Free RAM       │    │                    │    │ [q] Quit           │"
            echo "│ [4] Generally      │    │                    │    │                    │    │                    │    │                    │"
            echo "╰────────────────────╯    ╰────────────────────╯    ╰────────────────────╯    ╰────────────────────╯    ╰────────────────────╯"
            ;;
    esac
}

# SETTINGS
open_settings() {
	while true; do
		if [ "$clear_mode" -eq 1 ]; then
                            status_clear="${GREEN}ON ${NC}"
                else
                            status_clear="${RED}OFF${NC}"
                fi

                if [ "$display_mode" -eq 1 ]; then
                            status_display="${MAGENTA}h${NC}"
                else
                            status_display="${SP_GREEN}v${NC}"
                fi


                clear
                echo "╭────────────────╮"
                echo "│    SETTINGS    │"
                echo "│────────────────│"
                echo "│[c] Clear ($status_clear) │"
                echo "│[d] Display ($status_display) │"
                echo "│[q] Quit        │"
                echo -e "╰────────────────╯\n"


                read -n 1 -s -p "" settingV

                case "$settingV" in
			c | C)
				if [ "$clear_mode" -eq 1 ]; then
					clear_mode=0
                                else
                                        clear_mode=1
                                fi
                                ;;
                        d | D)
                                if [ "$display_mode" -eq 1 ]; then
                                        display_mode=0
                                else
                                        display_mode=1
                                fi
                                ;;
                         q | Q)
                                break
                                ;;
                         *)
                                break
                                ;;
                 esac
	done
}


# MAIN FUNCTION
main() {
	echo -e "\n════════════════════════════"
	echo "Welcome to SYSTEM INFO desk!"
	echo -e "════════════════════════════\n"

	local label=1 # while point
	while [ "$label" -ne 0 ]; do # cycle

		echo
		read -n 1 -s -r -p "${YELLOW}Press any key to continue...${NC}"
		echo
		echo

		print_menu # options menu

		read -n 1 -p "Option: " value
		echo ""
		echo ""

		if [ "$clear_mode" -eq 1 ]; then
			clear
		fi


		case "$value" in
			1)
				uname -a # Architecture
				;;
			2)
				uptime # Uptime
				;;
			3)
				hostnamectl # Host
				;;
			4)
				fastfetch # General
				;;
			5)
				lscpu # CPU
				;;
			6)
				lshw -short # Hardware
				;;
			7)
				lsblk # Disks
				;;
			8)
				df -h # Free space
				;;
			9)
				free -h # Free RAM
				;;
			0)
				btop # Processes
				;;
			q | Q)
				label=0 # quit from app
				clear
				;;
			s | S)
				open_settings # settings function
    				;;
			r | R)
				nano sys-info-script.sh # open script.sh
				;;
			*)
				echo "${ORANGE_RED}Please enter available option${NC}"
		esac

	done
}

main # run app

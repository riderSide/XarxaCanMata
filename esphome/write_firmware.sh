# Usage: ./write_firm.sh <firmware_file> -p <port>
# Description: Write firmware to ESP8266 using esptool
# BEFORE RUNNING: Make sure to set the correct port

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <firmware_file> -p <port>"
    exit 1
fi

# Parse arguments
firmware_file=$1
shift
while getopts ":p:" opt; do
  case $opt in
    p)
      port=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done


# Flash the firmware
esptool --port $port erase_flash
esptool --port $port write_flash 0x0 $firmware_file
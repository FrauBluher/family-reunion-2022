#!/bin/bash

# MP4 to GIF converter with palette-based blitting
# Usage: ./mp4togif.sh <input.mp4> <skip_frames> [skip_position]
#
# Arguments:
#   input.mp4     - The MP4 file to convert
#   skip_frames   - Number of frames to skip
#   skip_position - Where to skip frames: 'start', 'end', or 'both' (default: start)

set -e

# GIF frame rate (GIFs work best at 10-30fps, max ~50fps due to centisecond timing)
GIF_FPS=20

# Validate arguments
if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <input.mp4> <skip_frames> [skip_position]"
    echo ""
    echo "Arguments:"
    echo "  input.mp4     - The MP4 file to convert"
    echo "  skip_frames   - Number of frames to skip"
    echo "  skip_position - Where to skip: 'start', 'end', or 'both' (default: start)"
    exit 1
fi

INPUT_FILE="$1"
SKIP_FRAMES="$2"
SKIP_POSITION="${3:-start}"

# Validate input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: Input file '$INPUT_FILE' not found"
    exit 1
fi

# Validate skip_frames is a number
if ! [[ "$SKIP_FRAMES" =~ ^[0-9]+$ ]]; then
    echo "Error: skip_frames must be a positive integer"
    exit 1
fi

# Validate skip_position
if [[ "$SKIP_POSITION" != "start" && "$SKIP_POSITION" != "end" && "$SKIP_POSITION" != "both" ]]; then
    echo "Error: skip_position must be 'start', 'end', or 'both'"
    exit 1
fi

# Generate output filename (handle both .mp4 and .MP4)
OUTPUT_FILE="${INPUT_FILE%.[mM][pP]4}.gif"

# Get video frame rate as a fraction (e.g., 30000/1001 or 30/1)
FPS_FRACTION=$(ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 "$INPUT_FILE" | head -1)

# Calculate numeric FPS for display and time calculations
SOURCE_FPS=$(echo "scale=2; $FPS_FRACTION" | bc)

# Get total frames and duration
TOTAL_FRAMES=$(ffprobe -v error -count_frames -select_streams v:0 -show_entries stream=nb_read_frames -of default=noprint_wrappers=1:nokey=1 "$INPUT_FILE" | head -1)
DURATION=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "$INPUT_FILE" | head -1)

# If stream duration isn't available, try format duration
if [[ -z "$DURATION" || "$DURATION" == "N/A" ]]; then
    DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$INPUT_FILE")
fi

echo "Input: $INPUT_FILE"
echo "Output: $OUTPUT_FILE"
echo "Source FPS: $SOURCE_FPS"
echo "Output GIF FPS: $GIF_FPS"
echo "Total frames: $TOTAL_FRAMES"
echo "Duration: ${DURATION}s"
echo "Skipping $SKIP_FRAMES frames from: $SKIP_POSITION"

# Calculate time offsets based on skip position (use source fps for frame timing)
FRAME_DURATION=$(echo "scale=6; 1 / $SOURCE_FPS" | bc)

case "$SKIP_POSITION" in
    start)
        START_TIME=$(echo "scale=6; $SKIP_FRAMES * $FRAME_DURATION" | bc)
        END_TIME="$DURATION"
        ;;
    end)
        START_TIME="0"
        END_TIME=$(echo "scale=6; $DURATION - ($SKIP_FRAMES * $FRAME_DURATION)" | bc)
        ;;
    both)
        START_TIME=$(echo "scale=6; $SKIP_FRAMES * $FRAME_DURATION" | bc)
        END_TIME=$(echo "scale=6; $DURATION - ($SKIP_FRAMES * $FRAME_DURATION)" | bc)
        ;;
esac

START_TIME=$(echo "$START_TIME" | sed 's/^\./0./')
echo "Start time: ${START_TIME}s"
echo "End time: ${END_TIME}s"

# Create temporary palette file
PALETTE_FILE=$(mktemp /tmp/palette_XXXXXX.png)
trap "rm -f $PALETTE_FILE" EXIT

echo ""
echo "Pass 1: Generating 256-color palette..."

# Generate optimized palette with 256 colors at GIF frame rate
ffmpeg -v warning -i "$INPUT_FILE" \
    -an -vf "fps=$GIF_FPS,palettegen=max_colors=256:stats_mode=diff" \
    -y "$PALETTE_FILE"

echo "Pass 2: Creating GIF at ${GIF_FPS} fps..."

# Create GIF using the generated palette with dithering
# The fps filter converts to GIF-friendly frame rate
ffmpeg -v warning -ss "$START_TIME" -to "$END_TIME" -i "$INPUT_FILE" -i "$PALETTE_FILE" \
    -an -filter_complex "[0:v]fps=$GIF_FPS[v];[v][1:v]paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" \
    -y "$OUTPUT_FILE" \
    -vsync 0

# Get output file size
OUTPUT_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)

echo ""
echo "Done! Created: $OUTPUT_FILE ($OUTPUT_SIZE)"

```
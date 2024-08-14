PROJECT_FILE_LOC=data/repo_structures

# cohere command-r-plus
function crp_loc {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python -m pdb agentless/fl/localize.py \
    --file_level \
    --related_level \
    --fine_grain_line_level \
    --output_folder results/location-command-r-plus \
    --top_n 3 \
    --compress \
    --context_window=10 \
    --temperature 0.8 \
    --num_samples 4 \
    --skip_existing \
    --backend cohere \
    --model command-r-plus-synth
}

function base7b_loc {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/fl/localize.py \
    --file_level \
    --related_level \
    --fine_grain_line_level \
    --output_folder results/location-7b-base \
    --top_n 3 \
    --compress \
    --context_window=10 \
    --temperature 0.8 \
    --num_samples 4 \
    --skip_existing \
    --backend cohere \
    --model base-7b-v2
}

function gpt_loc {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/fl/localize.py \
    --file_level \
    --related_level \
    --fine_grain_line_level \
    --output_folder results/location-4o-mini \
    --top_n 3 \
    --compress \
    --context_window=10 \
    --temperature 0.8 \
    --num_samples 4 \
    --skip_existing \
    --backend openai \
    --model gpt-4o-mini-2024-07-18
}

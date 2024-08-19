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
    --backend cohere \
    --num_threads 1 \
    --model command-r-plus-synth \
    --skip_existing
}

function crp_merge {
python agentless/fl/localize.py --merge \
    --output_folder results/location_merged-command-r-plus \
    --start_file results/location-command-r-plus/loc_outputs.jsonl \
    --num_samples 4
}

function crp_repair {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/repair.py \
    --loc_file results/location_merged-command-r-plus/loc_merged_0-1_outputs.jsonl \
    --output_folder results/repair_run_1_command-r-plus \
    --loc_interval --top_n=3 --context_window=10 \
    --max_samples 21  --cot --diff_format \
    --gen_and_process \
    --backend cohere \
    --num_threads 4 \
    --model command-r-plus-synth

PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/repair.py \
    --loc_file results/location_merged-command-r-plus/loc_merged_2-3_outputs.jsonl \
    --output_folder results/repair_run_2_command-r-plus \
    --loc_interval --top_n=3 --context_window=10 \
    --max_samples 21  --cot --diff_format \
    --gen_and_process \
    --backend cohere \
    --num_threads 4 \
    --model command-r-plus-synth
}

function crp_rerank {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/rerank.py \
    --patch_folder results/repair_run_1_command-r-plus,results/repair_run_2_command-r-plus \
    --num_samples 42 --deduplicate --plausible \
    --output_file results/all_preds_command_r_plus.jsonl
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

function gpt_merge {
python agentless/fl/localize.py --merge \
    --output_folder results/location_merged-4o-mini \
    --start_file results/location-4o-mini/loc_outputs.jsonl \
    --num_samples 4
}

function gpt_repair {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/repair.py \
    --loc_file results/location_merged-4o-mini/loc_merged_0-1_outputs.jsonl \
    --output_folder results/repair_run_1_4o-mini \
    --loc_interval --top_n=3 --context_window=10 \
    --max_samples 21  --cot --diff_format \
    --gen_and_process \
    --backend openai \
    --num_threads 4 \
    --model gpt-4o-mini-2024-07-18

PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/repair.py \
    --loc_file results/location_merged-4o-mini/loc_merged_2-3_outputs.jsonl \
    --output_folder results/repair_run_2_4o-mini \
    --loc_interval --top_n=3 --context_window=10 \
    --max_samples 21  --cot --diff_format \
    --gen_and_process \
    --backend openai \
    --num_threads 4 \
    --model gpt-4o-mini-2024-07-18
}

function gpt_rerank {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/rerank.py \
    --patch_folder results/repair_run_1_4o-mini,results/repair_run_2_4o-mini \
    --num_samples 42 --deduplicate --plausible \
    --output_file results/all_preds_4o_mini.jsonl
}


function gpt4_loc {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/fl/localize.py \
    --file_level \
    --related_level \
    --fine_grain_line_level \
    --output_folder results/location-4o \
    --top_n 3 \
    --compress \
    --context_window=10 \
    --temperature 0.8 \
    --num_samples 4 \
    --skip_existing \
    --backend openai \
    --model gpt-4o-2024-05-13
}

function gpt4_merge {
python agentless/fl/localize.py --merge \
    --output_folder results/location_merged-4o \
    --start_file results/location-4o-mini/loc_outputs.jsonl \
    --num_samples 4
}

function gpt4_repair {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/repair.py \
    --loc_file results/location_merged-4o/loc_merged_0-1_outputs.jsonl \
    --output_folder results/repair_run_1_4o \
    --loc_interval --top_n=3 --context_window=10 \
    --max_samples 21  --cot --diff_format \
    --gen_and_process \
    --backend openai \
    --num_threads 4 \
    --model gpt-4o-2024-05-13

PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/repair.py \
    --loc_file results/location_merged-4o/loc_merged_2-3_outputs.jsonl \
    --output_folder results/repair_run_2_4o \
    --loc_interval --top_n=3 --context_window=10 \
    --max_samples 21  --cot --diff_format \
    --gen_and_process \
    --backend openai \
    --num_threads 4 \
    --model gpt-4o-2024-05-13
}

function gpt4_rerank {
PROJECT_FILE_LOC=$PROJECT_FILE_LOC python agentless/repair/rerank.py \
    --patch_folder results/repair_run_1_4o,results/repair_run_2_4o \
    --num_samples 42 --deduplicate --plausible \
    --output_file results/all_preds_4o.jsonl
}


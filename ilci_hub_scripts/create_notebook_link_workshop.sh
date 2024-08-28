#!/bin/bash

# usage
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path-to-open>"
    echo "example: $0 Onboarding_20240703/03_reading_data/demo_1_read_local_data.ipynb"
    exit 1
fi

# Get relative notebook path e.g.
# Onboarding_20240703/03_reading_data/demo_1_read_local_data.ipynb
path_to_open="$1"

# Define fixed params for the CIAP workshops repo 
hub_url="https://ciap.ilci.scienceversa.com"
repo_owner="CornellILCI"
repo_name="ILCI-CIAP-Workshops"
branch="main"

#python create_nbgitpuller_link.py --hub-url "https://ciap.ilci.scienceversa.com" --repo-owner "CornellILCI" --repo-name "ILCI-CIAP-Workshops" --path-to-open "Onboarding_20240703/03_reading_data/demo_1_read_local_data.ipynb" --branch "main"

create_nbgitpuller_link.py \
  --hub-url "$hub_url" \
  --repo-owner "$repo_owner" \
  --repo-name "$repo_name" \
  --path-to-open "$path_to_open" \
  --branch "$branch"


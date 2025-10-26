#!/usr/bin/env bash
set -eou pipefail

# ==================================================================================================
# Configuration and initialization
# ==================================================================================================

export LC_ALL=C
NEW_LINE='PYTHON_COMPAT=( python3_{11..14} )'

# ==================================================================================================
# Helper functions
# ==================================================================================================

log()
      {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2
}

error()
        {
    log "ERROR: $*"
    exit 1
}

# ==================================================================================================
# Main execution
# ==================================================================================================

main()
       {
    log "Starting Python version update script"

    if [[ $# -eq 0 ]]; then
        error "No directory specified"
    fi

    if [[ $# -gt 1 ]]; then
        error "Multiple directories specified: $*"
    fi

    local target_dir="$1"

    if [[ ! -d "$target_dir" ]]; then
        error "Directory '$target_dir' does not exist"
    fi

    local updated_count=0

    while IFS= read -r -d '' file; do
        if grep -q '^PYTHON_COMPAT=(' "$file"; then
            ((updated_count++)) || true
            sed -i 's|^PYTHON_COMPAT=(.*|'"$NEW_LINE"'|' "$file"
            log "Updated: $file"
        fi
    done < <(find "$target_dir" -type f -name '*.ebuild' -print0)

    log "Script completed: updated $updated_count files"
}

main "$@"

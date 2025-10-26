#!/usr/bin/env bash
set -eou pipefail

# ==================================================================================================
# Configuration and initialization
# ==================================================================================================

export LC_ALL=C
readonly ROOT="../"
readonly PACK_CAT=("app-editors" "media-libs" "media-plugins" "media-video")
readonly KEYWORDS_FILE="${ROOT}/Documentation/package.accept_keywords/vapoursynth"
readonly UNMASK_FILE="${ROOT}/Documentation/package.accept_keywords/vapoursynth-live"
readonly META_EBUILD_CAT="media-plugins"
readonly META_EBUILD_NAME="vapoursynth-plugins-meta"
readonly META_EBUILD_PATH="${ROOT}/${META_EBUILD_CAT}/${META_EBUILD_NAME}/"
TEMP_FILES=()

# ==================================================================================================
# Helper functions
# ==================================================================================================

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >&2
}

error() {
    log "ERROR: $*"
    exit 1
}

validate_environment() {
    [[ -d "${META_EBUILD_PATH}" ]] || error "Meta ebuild path '${META_EBUILD_PATH}' does not exist"

    for category in "${PACK_CAT[@]}"; do
        local category_path="${ROOT}/${category}"
        if [[ ! -d "${category_path}" ]]; then
            log "WARNING: Category directory '${category_path}' does not exist"
        fi
    done
}

cleanup_keywords_files() {
    for file in "${KEYWORDS_FILE}" "${UNMASK_FILE}"; do
        if [[ -f "${file}" ]]; then
            rm -f "${file}" || log "WARNING: Failed to remove ${file}"; continue
            log "Removed existing file: ${file}"
        fi
    done
}

create_keywords_files() {
    local category package package_name

    for category in "${PACK_CAT[@]}"; do
        local category_path="${ROOT}/${category}"

        if [[ ! -d "${category_path}" ]]; then
            continue
        fi

        for package in "${category_path}"/*; do
            if [[ ! -e "${package}" ]]; then
                continue
            fi

            package_name=$(basename "${package}")
            echo "${category}/${package_name} ~*" >> "${KEYWORDS_FILE}"
            echo "~${category}/${package_name}-9999 **" >> "${UNMASK_FILE}"
        done
    done

    log "Created keywords files: ${KEYWORDS_FILE}, ${UNMASK_FILE}"
}

version_increase() {
    local max=0
    local current

    for ebuild in "${META_EBUILD_PATH}"/*.ebuild; do
        [[ -f "${ebuild}" ]] || continue

        current=$(basename "${ebuild}" .ebuild)
        current="${current#"$META_EBUILD_NAME"-}"
        current="${current%"-r"*}"

        if [[ "${current}" =~ ^[0-9]+$ ]]; then
            if (( current > max )); then
                max="${current}"
            fi
        else
            log "WARNING: Skipping invalid version in filename: ${ebuild}"
        fi
    done

    echo "$((max + 1))"
}

create_meta_ebuild() {
    local temp_iuse="" temp_dep="" new_version new_ebuild_path

    temp_iuse=$(mktemp) || error "Failed to create temporary file for IUSE"
    temp_dep=$(mktemp) || error "Failed to create temporary file for DEPEND"

    TEMP_FILES+=("$temp_iuse" "$temp_dep")

    for category in ${META_EBUILD_CAT}; do
        local category_path="${ROOT}/${category}"

        if [[ ! -d "${category_path}" ]]; then
            error "Category directory '${category_path}' does not exist"
        fi

        for package in "${category_path}"/*; do
            [[ -e "${package}" ]] || continue

            local package_name
            package_name=$(basename "${package}")

            if [[ "${package_name}" != "${META_EBUILD_NAME}" ]]; then
                local plugin_name="${package_name#vapoursynth-}"
                printf "\tvapoursynth_plugins_%s\n" "${plugin_name}" >> "${temp_iuse}"
                printf "\tvapoursynth_plugins_%s? ( %s/%s )\n" \
                       "${plugin_name}" "${category}" "${package_name}" >> "${temp_dep}"
            fi
        done
    done

    if [[ ! -s "${temp_iuse}" ]]; then
        error "No plugins found for meta ebuild generation"
    fi

    new_version=$(version_increase)
    new_ebuild_path="${META_EBUILD_PATH}${META_EBUILD_NAME}-${new_version}.ebuild"

    {
        cat << EOF
# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="VapourSynth plugins meta package."
HOMEPAGE="https://www.vapoursynth.com/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="*"
IUSE="
$(cat "${temp_iuse}")
"

RDEPEND="
$(cat "${temp_dep}")
"
EOF
    } > "${new_ebuild_path}"

    log "Created new meta ebuild: ${new_ebuild_path}"
}

# ==================================================================================================
# Main execution
# ==================================================================================================

main() {
    log "Starting VapourSynth package update script"

    validate_environment
    cleanup_keywords_files
    create_keywords_files
    create_meta_ebuild

    rm -f "${TEMP_FILES[@]}"

    log "Script completed successfully"
}

main "$@"

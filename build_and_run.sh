#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    printf 1 "Usage: $(basename $0) [build-args [-- run-args [-- cmd-args] ] ]"
    printf 1 "  NOTE!!! the -rm-flag is hardcoded for build!"
fi

BUILD_ARG=()
RUN_ARG=()
CMD_ARG=()
ARG_SWITCH=0

while [ "${#@}" -ne 0 ]; do
    if [ "$1" == "--" ]; then
        let ARG_SWITCH++
        shift
    fi
    case $ARG_SWITCH in
        0)
            BUILD_ARG+=("$1")
            ;;
        1)
            RUN_ARG+=("$1")
            ;;
        2)
            CMD_ARG+=("$1")
            ;;
    esac
    shift
done

NAME="$(basename $PWD)"

if [ "$(dirname $PWD)/${NAME}" != "${PWD}" ]; then
    printf 2 "Failed to get basename"
    exit 1
fi

TAG="$(date +%Y%m%d-%H%M)"

if git rev-parse >/dev/null 2>&1 ; then
    # I can has git... get revision \o/
    COMMIT="$(git log -1 | awk '/commit/ {print $2}')"
    TAG="${TAG}-${COMMIT:0:6}"
fi

printf 2 "Building ${NAME}:${TAG}..."


if ! docker build -rm "${BUILD_ARG[@]}" -t="${NAME}:${TAG}" . ; then
    printf 2 "Build failed :("
    exit 1
fi

printf 2 "Running ${NAME}:${TAG}..."

docker run "${RUN_ARG[@]}" "${NAME}:${TAG}" "${CMD_ARG[@]}"

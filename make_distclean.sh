#!/bin/bash
#
# Removes all generated content.
# Use this script to clean up environment before deployment
set -x

rm -rf bin full lite web tmp

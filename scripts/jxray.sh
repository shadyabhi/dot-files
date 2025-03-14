#!/bin/bash

# Copyright (c) 2018 JXRay.com

# This script runs the jxray tool. By default it uses the java binary
# on your PATH and sets the JVM memory parameters that are suitable
# for an average-size heap dump. You can override both of these as follows:
#
# $ JXRAY_JAVA_HOME=/my/jdk jxray.sh mydump.hprof mydump.html
# $ JXRAY_JAVA_FLAGS="-Xmx64g" jxray.sh ...
#
# You can also pass the JVM flags via the -J prefix, as follows:
#
# $ jxray.sh -J-Xmx64g -J-verbose:gc mydump.hprof mydump.html

if [ -z ${JXRAY_JAVA_HOME+x} ]; then
  # JXRAY_JAVA_HOME is unset - use the default 'java'
  which java &> /dev/null
  if [ $? -ne 0 ]; then
    echo "java is not found on your PATH"
    exit 1
  fi

  JAVA_BIN="java"
else
  JAVA_BIN="${JXRAY_JAVA_HOME}/bin/java"

  if [[ ! -x "${JAVA_BIN}" ]]; then
    echo "${JAVA_BIN} not found or not executable"
    exit 1
  fi
fi

# JXRay needs JDK 1.8 or later - verify that
JAVA_VERSION=$($JAVA_BIN -version 2>&1)
if [[ $JAVA_VERSION == *"1.6."* || $JAVA_VERSION == *"1.7."* ]]; then
  echo "Old Java version detected: "
  echo $JAVA_VERSION
  echo
  echo "JXRay requires JDK 1.8 or newer"
  exit 1
fi

# By default, use JVM memory settings suitable for an average-size heap dump
if [ -z ${JXRAY_JAVA_FLAGS+x} ]; then
  JXRAY_JAVA_FLAGS="-Xms4g -Xmx12g"
fi

# In JDK 1.8, specify extra flags not needed / nonexistent in the newer JDKs
# Note that in newer JDKs, the CMS GC is deprecated, but it still works and
# seems to be faster for jxray than the default G1. So if you are really
# concerned about speed, you may still use it.
if [[ $JAVA_VERSION == *"1.8."* ]]; then
  JXRAY_JAVA_FLAGS="-d64 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC ${JXRAY_JAVA_FLAGS}"
fi

# Separate JXRay tool flags and JXRay JVM flags
JXRAY_FLAGS=""
for flag in $*; do
  if [[ ${flag} == -J* ]]; then
    JXRAY_JAVA_FLAGS="${JXRAY_JAVA_FLAGS} ${flag:2}"
  else
    JXRAY_FLAGS="${JXRAY_FLAGS} ${flag}"
  fi
done

TOOL_DIR=`dirname $0`

${JAVA_BIN} -Xss40m ${JXRAY_JAVA_FLAGS} \
  -jar ${TOOL_DIR}/jxray.jar \
  ${JXRAY_FLAGS}

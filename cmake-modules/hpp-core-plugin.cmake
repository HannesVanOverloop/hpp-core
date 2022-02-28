# Copyright (c) 2019, Joseph Mirabel
# Authors: Joseph Mirabel (joseph.mirabel@laas.fr)
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.

MACRO(HPP_ADD_PLUGIN PLUGIN_NAME)
  SET(options EXCLUDE_FROM_ALL)
  SET(oneValueArgs )
  SET(multiValueArgs
    SOURCES
    LINK_DEPENDENCIES
    PKG_CONFIG_DEPENDENCIES
    EXPORT)
  CMAKE_PARSE_ARGUMENTS(PLUGIN "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  IF(PLUGIN_EXCLUDE_FROM_ALL)
    SET(_options ${_options} EXCLUDE_FROM_ALL)
  ENDIF()
  ADD_LIBRARY(${PLUGIN_NAME} MODULE ${_options} ${PLUGIN_SOURCES})
  SET_TARGET_PROPERTIES(${PLUGIN_NAME} PROPERTIES PREFIX "" BUILD_WITH_INSTALL_RPATH TRUE)

  TARGET_LINK_LIBRARIES(${PLUGIN_NAME} ${PLUGIN_LINK_DEPENDENCIES})
  FOREACH(DEP ${PLUGIN_PKG_CONFIG_DEPENDENCIES})
    PKG_CONFIG_USE_DEPENDENCY(${PLUGIN_NAME} ${DEP})
  ENDFOREACH()

  IF(NOT PLUGIN_EXCLUDE_FROM_ALL)
    INSTALL(TARGETS ${PLUGIN_NAME}
      EXPORT ${PLUGIN_EXPORT}
      DESTINATION lib/hppPlugins)
  ENDIF()
ENDMACRO()

MACRO(ADD_PLUGIN PLUGIN_NAME)
  MESSAGE(AUTHOR_WARNING "Macro ADD_PLUGIN is deprecated and should be replaced by HPP_ADD_PLUGIN")
  HPP_ADD_PLUGIN(${PLUGIN_NAME} ${ARGN})
ENDMACRO()

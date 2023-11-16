###########################################################
#
# CI_LAB platform build setup
#
# This file is evaluated as part of the "prepare" stage
# and can be used to set up prerequisites for the build,
# such as generating header files
#
###########################################################

# The list of header files that control the CI_LAB configuration
set(CI_LAB_PLATFORM_CONFIG_FILE_LIST
  ci_lab_internal_cfg.h
  ci_lab_platform_cfg.h
  ci_lab_perfids.h
  ci_lab_msgids.h
)

if (CFE_EDS_ENABLED_BUILD)

  # In an EDS-based build, these files come generated from the EDS tool
  set(CI_LAB_CFGFILE_SRC_ci_lab_msgids "ci_lab_eds_msgids.h")

endif()

# Create wrappers around the all the config header files
# This makes them individually overridable by the missions, without modifying
# the distribution default copies
foreach(CI_LAB_CFGFILE ${CI_LAB_PLATFORM_CONFIG_FILE_LIST})
  get_filename_component(CFGKEY "${CI_LAB_CFGFILE}" NAME_WE)
  if (DEFINED CI_LAB_CFGFILE_SRC_${CFGKEY})
    set(DEFAULT_SOURCE "${CI_LAB_CFGFILE_SRC_${CFGKEY}}")
  else()
    set(DEFAULT_SOURCE "${CI_LAB_CFGFILE}")
  endif()
  generate_config_includefile(
    FILE_NAME           "${CI_LAB_CFGFILE}"
    FALLBACK_FILE       "${CMAKE_CURRENT_LIST_DIR}/config/default_${DEFAULT_SOURCE}"
  )
endforeach()

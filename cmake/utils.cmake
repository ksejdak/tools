function(utils_log MSG)
    message(STATUS "  ${MSG}")
endfunction()

function(utils_error MSG)
    message(FATAL_ERROR "  ${MSG}")
endfunction()

macro(utils_getVersion VERSION)
    find_package(Git)
    if (NOT GIT_FOUND)
        utils_error("Git not found")
    endif()

    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --abbrev=0 --tags
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        OUTPUT_VARIABLE TAG_VERSION
        ERROR_VARIABLE TAG_VERSION
    )
    string(STRIP ${TAG_VERSION} TAG_VERSION)
    string(SUBSTRING ${TAG_VERSION} 1 -1 TAG_VERSION)

    if(TAG_VERSION MATCHES "No names found")
        set(TAG_VERSION "0.1.0")
    endif()

    set(VERSION ${TAG_VERSION})
endmacro()

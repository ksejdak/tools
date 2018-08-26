include(tools/cmake/utils.cmake)

function(coverage_addTarget COVERAGE_IGNORE)
    find_program(LCOV_BIN lcov)
    find_package_handle_standard_args(lcov REQUIRED_VARS LCOV_BIN)
    if (NOT LCOV_FOUND)
        utils_error("Lcov not found")
    endif()

    set(COVERAGE_FLAGS --coverage)
    set(COVERAGE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/build/coverage/)

    # Add additional compilation files for code coverage.
    add_compile_options(${COVERAGE_FLAGS})
    set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${COVERAGE_FLAGS}" PARENT_SCOPE)
    set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} ${COVERAGE_FLAGS}" PARENT_SCOPE)

    add_custom_target(coverage
        COMMAND mkdir -p ${COVERAGE_OUTPUT_PATH}
        COMMAND ${LCOV_BIN} -c -d . -o ${COVERAGE_OUTPUT_PATH}/coverage.all
        COMMAND ${LCOV_BIN} -r ${COVERAGE_OUTPUT_PATH}/coverage.all '/usr/*' ${COVERAGE_IGNORE} -o ${COVERAGE_OUTPUT_PATH}/coverage.info
    )
endfunction()

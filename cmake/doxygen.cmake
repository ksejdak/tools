include(tools/cmake/utils.cmake)

function(doxygen_addTarget INPUT)
    find_package(Doxygen)
    if (NOT DOXYGEN_FOUND)
        utils_error("Doxygen not found")
    endif()

    set(DOXYGEN_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/build/docs)
    set(DOXYGEN_GENERATE_LATEX NO)
    set(DOXYGEN_EXTRACT_PRIVATE YES)
    set(DOXYGEN_EXTRACT_PACKAGE YES)
    set(DOXYGEN_EXTRACT_STATIC YES)
    set(DOXYGEN_WARN_NO_PARAMDOC YES)
    set(DOXYGEN_HTML_OUTPUT .)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE README.md)
    set(DOXYGEN_FILE_PATTERNS *.c *.cc *.cxx *.cpp *.c++ *.ii *.ixx *.ipp *.i++ *.inl *.h *.hh *.hxx *.hpp *.h++ *.inc README.md)
    set(DOXYGEN_EXCLUDE bin/ build/ doc/ lib/ test/ tools/)
    set(DOXYGEN_WARN_LOGFILE ${DOXYGEN_OUTPUT_DIRECTORY}/doxygen.warn)

    # Add target to generate doxygen docs in the build directory.
    doxygen_add_docs(doxygen ${INPUT} WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

    # Add target to copy generated doxygen docs to the docs directory.
    add_custom_target(docs
        COMMAND rm -rf ${PROJECT_SOURCE_DIR}/docs/*
        COMMAND cp -R ${PROJECT_SOURCE_DIR}/build/docs/* ${PROJECT_SOURCE_DIR}/docs/
    )
endfunction()

IF(NOT CHECKED_SCHILY)
   SET(CHECKED_SCHILY 1)

   INCLUDE(CheckCSourceCompiles)
   LIST(APPEND EXTRA_LIBS "schily")


   SET(TESTSRC " 
   #include <math.h>
   int main() { return isnan(1); }
   ")

   SET(CMAKE_REQUIRED_LIBRARIES )
   CHECK_C_SOURCE_COMPILES("${TESTSRC}" HAVE_LIBC_ISNAN)

   #//#define HAVE_ISNAN 1    /* isnan() is present in libc or libm */
   # assuming that, see xconfig.h.in, until we meet an OS where is no
   # native isnan(...) function available

   IF(NOT HAVE_LIBC_ISNAN)
      SET(CMAKE_REQUIRED_LIBRARIES m)
      LIST(APPEND EXTRA_LIBS m)
      CHECK_C_SOURCE_COMPILES("${TESTSRC}" HAVE_LIBM_ISNAN)
      IF(NOT HAVE_LIBM_ISNAN)
         MESSAGE(FATAL_ERROR "isnan function not found anywhere on ${CMAKE_SYSTEM_NAME}")
      ENDIF(NOT HAVE_LIBM_ISNAN)
   ENDIF(NOT HAVE_LIBC_ISNAN)

ENDIF(NOT CHECKED_SCHILY)


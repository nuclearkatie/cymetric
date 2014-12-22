"""C++ header wrapper for specific parts of cyclus."""
from libcpp.map cimport map
from libcpp.set cimport set
from libcpp.vector cimport vector
from libcpp.string cimport string as std_string


cdef extern from "cyclus.h" namespace "boost::spirit":

    cdef cppclass hold_any:
        pass

cdef extern from "cyclus.h" namespace "cyclus":

    ctypedef vector[hold_any] QueryRow

    cdef enum DbTypes:
        # primitive types
        BOOL
        INT
        FLOAT
        DOUBLE
        STRING
        VL_STRING
        BLOB
        UUID

    cdef enum CmpOpCode:
        LT
        GT
        LE
        GE
        EQ
        NE

    cdef cppclass Cond:
        Cond() except +
        Cond(std_string, std_string, hold_any) except +
    
        std_string field
        std_string op
        CmpOpCode opcode
        hold_any val


    cdef cppclass QueryResult:
        QueryResult() except +

        void Reset() except +
        T GetVal[T](std_string) except +
        T GetVal[T](std_string, int) except +

        vector[std_string] fields
        vector[DbTypes] types
        vector[QueryRow] rows        


    cdef cppclass FullBackend:
        FullBackend() except + 

        QueryResult Query(std_string, vector[Cond]*) except +
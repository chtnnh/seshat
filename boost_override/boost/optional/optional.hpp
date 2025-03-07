#ifndef BOOST_OPTIONAL_OPTIONAL_HPP
#define BOOST_OPTIONAL_OPTIONAL_HPP

// Include our custom none_t.hpp instead of the system one
#include "boost/none_t.hpp"
#include "boost/none.hpp"

// Forward to the system's boost implementation but bypass the error
#include "/usr/local/include/boost/optional/optional_fwd.hpp"

// Define some basic structs to make it work
namespace boost {
    template<class T>
    class optional {
    private:
        bool initialized;
        T storage;
        
    public:
        optional() : initialized(false) {}
        optional(none_t) : initialized(false) {}
        optional(const T& v) : initialized(true), storage(v) {}
        
        bool is_initialized() const { return initialized; }
        T& get() { return storage; }
        const T& get() const { return storage; }
        
        T& operator*() { return storage; }
        const T& operator*() const { return storage; }
        
        operator bool() const { return initialized; }
    };
}

#endif // BOOST_OPTIONAL_OPTIONAL_HPP 
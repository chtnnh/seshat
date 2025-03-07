#ifndef BOOST_VECTOR_BOOL_FIX_HPP
#define BOOST_VECTOR_BOOL_FIX_HPP

#include <vector>
#include <boost/range/iterator.hpp>

namespace boost {
    
    // Specialization for std::vector<bool> to handle its peculiarities
    template<>
    struct range_const_iterator<std::vector<bool> > {
        typedef std::vector<bool>::const_iterator type;
    };
    
    template<>
    struct range_iterator<std::vector<bool> > {
        typedef std::vector<bool>::iterator type;
    };
    
}

#endif // BOOST_VECTOR_BOOL_FIX_HPP 
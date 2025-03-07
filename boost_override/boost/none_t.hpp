// Copyright (C) 2003, Fernando Luis Cacciola Carballal.
//
// Use, modification, and distribution is subject to the Boost Software
// License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at
// http://www.boost.org/LICENSE_1_0.txt)
//
// See http://www.boost.org/libs/optional for documentation.
//
// You are welcome to contact the author at:
//  fernando_cacciola@hotmail.com
//

#ifndef BOOST_NONE_T_HPP
#define BOOST_NONE_T_HPP

namespace boost {

struct none_t
{
  struct init_tag{};
  explicit none_t(init_tag){} 
};

} // namespace boost

#endif // BOOST_NONE_T_HPP 
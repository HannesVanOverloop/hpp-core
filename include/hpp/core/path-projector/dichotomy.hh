// Copyright (c) 2014, LAAS-CNRS
// Authors: Joseph Mirabel (joseph.mirabel@laas.fr)
//
// This file is part of hpp-core.
// hpp-core is free software: you can redistribute it
// and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation, either version
// 3 of the License, or (at your option) any later version.
//
// hpp-core is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty
// of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Lesser Public License for more details.  You should have
// received a copy of the GNU Lesser General Public License along with
// hpp-core. If not, see <http://www.gnu.org/licenses/>.

#ifndef HPP_CORE_PATHPROJECTOR_DICHOTOMY_HH
# define HPP_CORE_PATHPROJECTOR_DICHOTOMY_HH

# include "hpp/core/path-projector.hh"
namespace hpp {
  namespace core {
    namespace pathProjector {
      class HPP_CORE_DLLAPI Dichotomy : public PathProjector
      {
        public:
          static DichotomyPtr_t create (const core::DistancePtr_t distance,
              value_type maxPathLength)
          {
            return DichotomyPtr_t (new Dichotomy (distance, maxPathLength));
          }

        protected:
          bool impl_apply (const PathPtr_t& path,
			   PathPtr_t& projection) const;

          Dichotomy (const core::DistancePtr_t distance, value_type maxPathLength);

        private:
          value_type maxPathLength_;
      };
    } // namespace pathProjector
  } // namespace core
} // namespace hpp
#endif // HPP_CORE_PATHPROJECTOR_DICHOTOMY_HH
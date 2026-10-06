-- Generated from ChapterSphericalBessel.lean — theorem BookProof.ChapterSphericalBessel.sj0_satisfies_ode
import Mathlib
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel



open scoped Topology

theorem BookProof.ChapterSphericalBessel.sj0_satisfies_ode {r : ℝ} (hr : r ≠ 0) :
    r ^ 2 * deriv (deriv sj0) r + 2 * r * deriv sj0 r + r ^ 2 * sj0 r = 0 := by sorry

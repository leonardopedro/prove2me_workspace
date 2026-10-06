-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.gIter_ode_zero
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.gIter_ode_zero {r : ℝ} (hr : r ≠ 0) :
    r * deriv (deriv (gIter 0)) r + 2 * deriv (gIter 0) r + r * gIter 0 r = 0 := by sorry

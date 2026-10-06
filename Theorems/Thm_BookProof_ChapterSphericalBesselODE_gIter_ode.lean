-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.gIter_ode
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.gIter_ode (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    r * deriv (deriv (gIter l)) r + (2 * l + 2) * deriv (gIter l) r + r * gIter l r = 0 := by sorry

-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.second_deriv_gIter
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.second_deriv_gIter (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    deriv (deriv (gIter l)) r = -gIter (l + 1) r - r * deriv (gIter (l + 1)) r := by sorry

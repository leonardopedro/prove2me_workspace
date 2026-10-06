-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.deriv_gIter_eq
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.deriv_gIter_eq (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    deriv (gIter l) r = -r * gIter (l + 1) r := by sorry

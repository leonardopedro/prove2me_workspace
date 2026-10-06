-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.gIter_pred_eq
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.gIter_pred_eq (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    gIter l r = (2 * l + 3) * gIter (l + 1) r + r * deriv (gIter (l + 1)) r := by sorry

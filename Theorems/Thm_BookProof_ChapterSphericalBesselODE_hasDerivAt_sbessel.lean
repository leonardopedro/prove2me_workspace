-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.hasDerivAt_sbessel
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.hasDerivAt_sbessel (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    HasDerivAt (sbessel l) (r ^ l * ((l : ℝ) * gIter l r / r + deriv (gIter l) r)) r := by sorry

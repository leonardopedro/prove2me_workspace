-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.sbessel_recurrence
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.sbessel_recurrence (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    sbessel l r + sbessel (l + 2) r = ((2 * (l + 1) + 1) / r) * sbessel (l + 1) r := by sorry

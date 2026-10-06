-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.diffAt_deriv_sbessel
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.diffAt_deriv_sbessel (l : ℕ) {x : ℝ} (hx : x ≠ 0) :
    DifferentiableAt ℝ (deriv (sbessel l)) x := by sorry

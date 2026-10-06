-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.sbessel_rayleigh_raise
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.sbessel_rayleigh_raise (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    sbessel (l + 1) r = -(r ^ l) * deriv (fun s => sbessel l s / s ^ l) r := by sorry

-- Generated from ChapterSphericalBesselODE.lean — theorem BookProof.ChapterSphericalBesselODE.hasDerivAt_sbessel_scaled
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalBesselODE



open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalBesselODE.hasDerivAt_sbessel_scaled (l : ℕ) {p x : ℝ} (hp : p ≠ 0) (hx : x ≠ 0) :
    HasDerivAt (fun s : ℝ => sbessel l (p * s)) (deriv (sbessel l) (p * x) * p) x := by sorry

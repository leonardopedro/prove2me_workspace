-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.hasDerivAt_sbessel_scaled
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_hasDerivAt_sbessel
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) {p x : ℝ} (hp : p ≠ 0) (hx : x ≠ 0) :
    HasDerivAt (fun s : ℝ => sbessel l (p * s)) (deriv (sbessel l) (p * x) * p) x := by

  have hpx : p * x ≠ 0 := mul_ne_zero hp hx
  have hc : HasDerivAt (fun s : ℝ => p * s) p x := by
    simpa using (hasDerivAt_id x).const_mul p
  have hb : HasDerivAt (sbessel l) (deriv (sbessel l) (p * x)) (p * x) := by
    have h := hasDerivAt_sbessel l hpx
    rwa [h.deriv]
  exact hb.comp x hc

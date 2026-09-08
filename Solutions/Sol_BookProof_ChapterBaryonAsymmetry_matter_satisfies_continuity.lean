-- Generated from ChapterBaryonAsymmetry.lean — solution of BookProof.ChapterBaryonAsymmetry.matter_satisfies_continuity
import Mathlib
import Definitions.Def_ChapterBaryonAsymmetry
open BookProof.ChapterBaryonAsymmetry













open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (ρm0 a : ℝ) (ha : 0 < a) :
    a * deriv (fun x => matterDensity ρm0 x) a + 3 * (1 + 0) * matterDensity ρm0 a = 0 := by

  have h : HasDerivAt (fun x : ℝ => matterDensity ρm0 x)
      (ρm0 * (-(3 * a ^ 2) / (a ^ 3) ^ 2)) a := by
    have hp : HasDerivAt (fun x : ℝ => x ^ 3) (3 * a ^ 2) a := by simpa using hasDerivAt_pow 3 a
    have hinv : HasDerivAt (fun x : ℝ => (x ^ 3)⁻¹) (-(3 * a ^ 2) / (a ^ 3) ^ 2) a :=
      hp.inv (by positivity)
    simpa [matterDensity, div_eq_mul_inv] using hinv.const_mul ρm0
  rw [h.deriv]
  simp only [matterDensity]
  field_simp
  ring

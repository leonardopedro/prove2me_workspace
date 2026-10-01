-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.coeff_hermiteR_self
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 hmom w)
  filter_upwards [hzero] with x hx
  have hne : ((gaussH :=
  x : ℝ) : ℂ) ≠ 0 := by
      exact_mod_cast ne_of_gt (gaussH_pos x)
    exact (mul_eq_zero.mp hx).resolve_left hne
  
  theorem coeff_hermiteR_self (n : ℕ) : (hermiteR n).coeff n = 1 := by
    simp [hermiteR, Polyn

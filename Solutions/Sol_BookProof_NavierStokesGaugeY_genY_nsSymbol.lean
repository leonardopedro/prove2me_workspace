-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genY_nsSymbol
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_genY_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY_genY_uField
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) (i j : Fin 3) : genY j (nsSymbol nu i) = 0 := by

  have hC : genY j (C nu) = 0 := by simp [genY_apply]
  simp only [nsSymbol, map_sub, map_sum, genY_leibniz, genY_uField, genY_X_uD, genY_X_uL, hC,
    zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

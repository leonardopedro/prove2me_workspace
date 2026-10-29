-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genX_nsSymbol
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_genX_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY_genX_uField
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

@[simp] private theorem genX_apply (j : Fin 3) (p : NSAlg) :
    BookProof.NavierStokesGaugeY.genX j p = pderiv (NSVar.x j) p := rfl

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) (i j : Fin 3) : genX j (nsSymbol nu i) = 0 := by

  have hC : genX j (C nu) = 0 := by simp
  have huD : ∀ k : Fin 3, genX j (X (NSVar.uD i k)) = 0 := by
    intro k; simp
  have huL : genX j (X (NSVar.uL i)) = 0 := by simp
  simp only [nsSymbol, map_sub, map_sum, genX_leibniz, genX_uField, huD, huL, hC,
    zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_nsSymbol2
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_uField2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_uDField
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY


private theorem genY2_apply (j : Fin 3) (p : NSAlg) :
    genY2 j p = pderiv (NSVar.y j) p
      - (∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p)
      - ∑ i : Fin 3, X (NSVar.uL i) * pderiv (NSVar.uD i j) p := by
  simp [genY2]
@[simp] private theorem genY2_X_uL (j i : Fin 3) : genY2 j (X (NSVar.uL i)) = 0 := by
  simp [genY2_apply, pderiv_X]

set_option maxHeartbeats 1000000 in

@[simp] private theorem genY2_C (j : Fin 3) (c : ℂ) : genY2 j (C c) = 0 := by
  simp [genY2_apply]

theorem solution (nu : ℂ) (i j : Fin 3) : genY2 j (nsSymbol2 nu i) = 0 := by
  simp only [nsSymbol2, map_sub, map_sum, genY2_leibniz, genY2_uField2, genY2_uDField,
    genY2_X_uL, genY2_C, zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

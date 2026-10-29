-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genY_nsSymbol
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Theorems.Thm_BookProof_NavierStokesGaugeY_genY_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY_genY_uField
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow


private theorem genY_apply (j : Fin 3) (p : NSAlg) :
    genY j p = pderiv (NSVar.y j) p - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p := by
  simp [genY]

set_option maxHeartbeats 1000000 in

@[simp] private theorem genY_X_uD (i j k : Fin 3) : genY k (X (NSVar.uD i j)) = 0 := by
  simp [genY_apply]

@[simp] private theorem genY_X_uL (i k : Fin 3) : genY k (X (NSVar.uL i)) = 0 := by
  simp [genY_apply]

theorem solution (nu : ℂ) (i j : Fin 3) : genY j (nsSymbol nu i) = 0 := by
  have hC : genY j (C nu) = 0 := by simp [genY_apply]
  simp only [nsSymbol, map_sub, map_sum, genY_leibniz, genY_uField, genY_X_uD, genY_X_uL, hC,
    zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_uDField
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_leibniz
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY


private theorem genY2_apply (j : Fin 3) (p : NSAlg) :
    genY2 j p = pderiv (NSVar.y j) p
      - (∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p)
      - ∑ i : Fin 3, X (NSVar.uL i) * pderiv (NSVar.uD i j) p := by
  simp [genY2]
@[simp] private theorem genY2_X_uD (j i m : Fin 3) :
    genY2 j (X (NSVar.uD i m)) = if j = m then -X (NSVar.uL i) else 0 := by
  by_cases h : j = m
  · subst h
    simp [genY2_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm]
  · simp [genY2_apply, pderiv_X, h, Ne.symm h]

set_option maxHeartbeats 1000000 in

@[simp] private theorem genY2_X_uL (j i : Fin 3) : genY2 j (X (NSVar.uL i)) = 0 := by
  simp [genY2_apply, pderiv_X]

@[simp] private theorem genY2_X_y (j m : Fin 3) :
    genY2 j (X (NSVar.y m)) = if j = m then 1 else 0 := by
  by_cases h : j = m
  · subst h; simp [genY2_apply, pderiv_X]
  · simp [genY2_apply, pderiv_X, h, Ne.symm h]

theorem solution (i j k : Fin 3) : genY2 j (uDField i k) = 0 := by
  rw [uDField, map_add, genY2_X_uD, genY2_leibniz, genY2_X_uL, genY2_X_y]
  by_cases h : j = k <;> simp [h]

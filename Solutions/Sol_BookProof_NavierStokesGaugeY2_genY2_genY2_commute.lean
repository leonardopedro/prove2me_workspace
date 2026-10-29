-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_genY2_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_end_ext_of_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY2_commutator_leibniz
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

private theorem genY2_C (j : Fin 3) (c : ℂ) : genY2 j (C c) = 0 := by
  simp [genY2_apply]

private theorem genY2_one (j : Fin 3) : genY2 j (1 : NSAlg) = 0 := by
  simpa using genY2_C j 1

private theorem genY2_X_x (j m : Fin 3) : genY2 j (X (NSVar.x m)) = 0 := by
  simp [genY2_apply, pderiv_X]

private theorem genY2_X_y (j m : Fin 3) :
    genY2 j (X (NSVar.y m)) = if j = m then 1 else 0 := by
  by_cases h : j = m
  · subst h; simp [genY2_apply, pderiv_X]
  · simp [genY2_apply, pderiv_X, h, Ne.symm h]

private theorem genY2_X_u (j i : Fin 3) :
    genY2 j (X (NSVar.u i)) = -X (NSVar.uD i j) := by
  simp [genY2_apply, pderiv_X, Pi.single_apply, apply_ite]

private theorem genY2_X_uD (j i m : Fin 3) :
    genY2 j (X (NSVar.uD i m)) = if j = m then -X (NSVar.uL i) else 0 := by
  by_cases h : j = m
  · subst h
    simp [genY2_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm]
  · simp [genY2_apply, pderiv_X, h, Ne.symm h]

private theorem genY2_X_uL (j i : Fin 3) : genY2 j (X (NSVar.uL i)) = 0 := by
  simp [genY2_apply, pderiv_X]

set_option maxHeartbeats 1000000 in

theorem solution (j k : Fin 3) : ⁅genY2 j, genY2 k⁆ = 0 := by
  refine end_ext_of_leibniz _
    (commutator_leibniz _ _ (genY2_leibniz j) (genY2_leibniz k)) (fun c => ?_) (fun v => ?_)
  · simp [Ring.lie_def, genY2_C]
  · rw [Ring.lie_def]
    cases v with
    | x m => simp [genY2_X_x]
    | y m => by_cases h : j = m <;> by_cases h' : k = m <;> simp [h, h', genY2_X_y, genY2_one]
    | u i =>
        by_cases h : j = k
        · subst h; simp [genY2_X_u, genY2_X_uD, genY2_X_uL]
        · simp [h, Ne.symm h, genY2_X_u, genY2_X_uD, genY2_X_uL]
    | uD i m => by_cases h : j = m <;> by_cases h' : k = m <;> simp [h, h', genY2_X_uD, genY2_X_uL]
    | uL i => simp [genY2_X_uL]

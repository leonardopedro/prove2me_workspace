-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY_genY2_bracket_X_u
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY
open BookProof.NavierStokesGaugeY


private theorem genY_apply (j : Fin 3) (p : NSAlg) :
    genY j p = pderiv (NSVar.y j) p - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p := by
  simp [genY]

private theorem genY2_apply (j : Fin 3) (p : NSAlg) :
    genY2 j p = pderiv (NSVar.y j) p
      - (∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p)
      - ∑ i : Fin 3, X (NSVar.uL i) * pderiv (NSVar.uD i j) p := by
  simp [genY2]

private theorem genY2_X_u (j i : Fin 3) :
    genY2 j (X (NSVar.u i)) = -X (NSVar.uD i j) := by
  simp [genY2_apply, pderiv_X, Pi.single_apply, apply_ite]

private theorem genY2_X_uD (j i m : Fin 3) :
    genY2 j (X (NSVar.uD i m)) = if j = m then -X (NSVar.uL i) else 0 := by
  by_cases h : j = m
  · subst h
    simp [genY2_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm]
  · simp [genY2_apply, pderiv_X, h, Ne.symm h]

set_option maxHeartbeats 1000000 in

theorem solution (i j : Fin 3) :
    ⁅genY j, genY2 j⁆ (X (NSVar.u i)) = -X (NSVar.uL i) := by
  rw [Ring.lie_def]
  simp [genY_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm, genY2_X_u, genY2_X_uD]

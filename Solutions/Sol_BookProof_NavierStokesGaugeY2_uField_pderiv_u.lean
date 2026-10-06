-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.uField_pderiv_u
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (m i : Fin 3) :
    pderiv (NSVar.u m) (uField i) = if m = i then 1 else 0 := by

  have h2 : ∀ k : Fin 3, pderiv (NSVar.u m) (X (NSVar.uD i k) * X (NSVar.y k) : NSAlg) = 0 := by
    intro k; rw [pderiv_mul]; simp [pderiv_X]
  rw [uField, map_add, map_sum, Finset.sum_eq_zero (fun k _ => h2 k)]
  simp [pderiv_X, Pi.single_apply, @eq_comm _ i m]

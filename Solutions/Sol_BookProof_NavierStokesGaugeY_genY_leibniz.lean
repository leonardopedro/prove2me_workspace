-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genY_leibniz
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) (p q : NSAlg) :
    genY j (p * q) = genY j p * q + p * genY j q := by

  have key : ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) (p * q)
      = (∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p) * q
        + p * ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) q := by
    rw [Finset.sum_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [pderiv_mul]; ring
  rw [genY_apply, genY_apply, genY_apply, key, pderiv_mul]
  ring

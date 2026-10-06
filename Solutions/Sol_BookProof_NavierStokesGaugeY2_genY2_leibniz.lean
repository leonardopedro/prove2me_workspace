-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_leibniz
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) (p q : NSAlg) :
    genY2 j (p * q) = genY2 j p * q + p * genY2 j q := by

  have key : ∀ (f : Fin 3 → NSVar) (c : Fin 3 → NSAlg),
      ∑ i : Fin 3, c i * pderiv (f i) (p * q)
        = (∑ i : Fin 3, c i * pderiv (f i) p) * q + p * ∑ i : Fin 3, c i * pderiv (f i) q := by
    intro f c
    rw [Finset.sum_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [pderiv_mul]; ring
  rw [genY2_apply, genY2_apply, genY2_apply, key (fun i => NSVar.u i) _,
    key (fun i => NSVar.uD i j) _, pderiv_mul]
  ring

-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.pderiv_swap
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (a b : NSVar) (p : NSAlg) :
    pderiv a (pderiv b p) = pderiv b (pderiv a p) := by

  induction p using MvPolynomial.induction_on with
  | C c => simp
  | add p q hp hq => simp [hp, hq]
  | mul_X p n hp =>
      simp only [pderiv_mul, pderiv_X, Pi.single_apply, map_add, map_zero,
        Derivation.map_one_eq_zero, apply_ite (⇑(pderiv a)), apply_ite (⇑(pderiv b)), hp]
      split_ifs <;> ring

-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.hasDerivAt_eval_update
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Fin d → ℂ) (t : ℂ) :
    HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x i s) p)
      (MvPolynomial.eval (Function.update x i t) (pderiv i p)) t := by

  classical
  induction p using MvPolynomial.induction_on with
  | C a => simpa using (hasDerivAt_const t (a : ℂ))
  | add p q hp hq => simpa [map_add] using hp.add hq
  | mul_X p j hp =>
      by_cases hj : j = i
      · subst hj
        have hX : HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x j s) (X j))
            1 t := by simpa using hasDerivAt_id t
        have h := hp.mul hX
        have hpd : pderiv j (p * X j) = X j * pderiv j p + p := by
          rw [Derivation.leibniz]
          simp [smul_eq_mul]
          ring
        rw [hpd]
        simp only [map_add, map_mul, MvPolynomial.eval_X, Function.update_self] at h ⊢
        convert h using 1
        ring
      · have hX : HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x i s) (X j))
            0 t := by
          simp only [MvPolynomial.eval_X, Function.update_apply, hj]
          exact hasDerivAt_const _ _
        have h := hp.mul hX
        have hpd : pderiv i (p * X j) = X j * pderiv i p := by
          rw [Derivation.leibniz]
          simp [Ne.symm hj]
        rw [hpd]
        simp only [map_mul, MvPolynomial.eval_X] at h ⊢
        convert h using 1
        ring

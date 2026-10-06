-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.pderiv_prod_eq_zero
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {S : Finset (Fin d)} {W : Fin d → MvPolynomial (Fin d) ℂ}
    {i : Fin d} (h : ∀ j ∈ S, pderiv i (W j) = 0) : pderiv i (∏ j ∈ S, W j) = 0 := by

  classical
  induction S using Finset.induction_on with
  | empty => simp
  | insert a S ha ih =>
      rw [Finset.prod_insert ha, Derivation.leibniz,
        h a (Finset.mem_insert_self a S),
        ih (fun j hj => h j (Finset.mem_insert_of_mem hj))]
      simp

-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.realCoeff_prod
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_realCoeff_one
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_mul
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {S : Finset (Fin d)} {f : Fin d → MvPolynomial (Fin d) ℂ}
    (h : ∀ j ∈ S, RealCoeff (f j)) : RealCoeff (∏ j ∈ S, f j) := by

  classical
  induction S using Finset.induction_on with
  | empty => simpa using realCoeff_one
  | insert a S ha ih =>
      rw [Finset.prod_insert ha]
      exact RealCoeff.mul (h a (Finset.mem_insert_self a S))
        (ih fun j hj => h j (Finset.mem_insert_of_mem hj))

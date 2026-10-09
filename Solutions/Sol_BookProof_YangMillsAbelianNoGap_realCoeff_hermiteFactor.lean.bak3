-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.realCoeff_hermiteFactor
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Theorems.Thm_BookProof_YangMillsAbelianNoGap_realCoeff_one
import Theorems.Thm_BookProof_GaussCoordCombo_hermiteFactor_succ_eq
import Theorems.Thm_BookProof_HermiteProductCore_hermiteFactor_zero
import Theorems.Thm_BookProof_YangMillsHermite_starP_X
import Theorems.Thm_BookProof_YangMillsHermite_starP_mul
import Theorems.Thm_BookProof_YangMillsHermite_starP_pderiv
import Theorems.Thm_BookProof_YangMillsHermite_starP_sub
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (n : ℕ) : RealCoeff (hermiteFactor i n) := by

  induction n with
  | zero => rw [hermiteFactor_zero]; exact realCoeff_one
  | succ n ih =>
      rw [hermiteFactor_succ_eq, RealCoeff, starP_sub, starP_mul, starP_X, starP_pderiv,
        show starP (hermiteFactor i n) = hermiteFactor i n from ih]

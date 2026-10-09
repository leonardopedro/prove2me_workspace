-- Generated from ChapterYangMillsAbelianNoGap.lean — solution of BookProof.YangMillsAbelianNoGap.gaussInt_one_eq
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Theorems.Thm_BookProof_HermiteCore_gint_one
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_monomial
open BookProof.YangMillsAbelianNoGap




open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    gaussInt (1 : MvPolynomial (Fin d) ℂ) = (((Real.sqrt (2 * Real.pi)) ^ d : ℝ) : ℂ) := by

  have h0 : (monomial (0 : Fin d →₀ ℕ) (1 : ℂ)) = 1 := by simp
  have h := gaussInt_monomial (0 : Fin d →₀ ℕ)
  rw [h0] at h
  have hm : gaussMoment 0 = Real.sqrt (2 * Real.pi) := by
    simpa [gaussMoment] using BookProof.HermiteCore.gint_one
  rw [h]
  simp [hm]

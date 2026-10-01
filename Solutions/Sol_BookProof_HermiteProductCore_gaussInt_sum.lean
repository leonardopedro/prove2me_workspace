-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussInt_sum
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_add
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
un x => ?_)
  simp [add_mul]

theorem solution (c : ℂ) (r : MvPolynomial (Fin d) ℂ) :
    gaussInt (c • r) = c * gaussInt r := by
  rw [gauss := 

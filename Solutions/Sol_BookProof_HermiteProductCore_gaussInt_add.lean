-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussInt_add
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_integrable_gwFun
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (r s : MvPolynomial (Fin d) ℂ) :
    gaussInt (r + s) = gaussInt r + gaussInt s := by

  rw [gaussInt, gaussInt, gaussInt, ← integral_add (integrable_gwFun r) (integrable_gwFun s)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp [add_mul]

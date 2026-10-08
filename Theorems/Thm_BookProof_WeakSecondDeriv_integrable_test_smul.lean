-- Generated from ChapterWeakSecondDerivative.lean — theorem BookProof.WeakSecondDeriv.integrable_test_smul
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv



open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]

theorem BookProof.WeakSecondDeriv.integrable_test_smul {φ : ℝ → ℝ} (hφ : IsTestFun φ) {r : ℝ → F}
    (hr : LocallyIntegrable r volume) : Integrable (fun x => φ x • r x) volume := by sorry

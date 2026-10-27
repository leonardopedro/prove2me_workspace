-- Generated from ChapterMehlerOrthogonalInvariance.lean — solution of BookProof.ChapterMehlerOrthogonalInvariance.measurable_headRotation
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
open BookProof.ChapterMehlerOrthogonalInvariance



open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (O : Matrix (Fin k) (Fin k) ℝ) :
    Measurable (headRotation k O) := by

  unfold headRotation
  exact (tailSplitEquiv k).symm.measurable.comp
    (((by fun_prop : Measurable fun h : Fin k → ℝ => O *ᵥ h).comp measurable_fst).prodMk
      (measurable_id.comp measurable_snd) |>.comp (tailSplitEquiv k).measurable)

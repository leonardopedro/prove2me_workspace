-- Generated from ChapterMehlerOrthogonalInvariance.lean — solution of BookProof.ChapterMehlerOrthogonalInvariance.charFun_map_isometryEquiv
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
open BookProof.ChapterMehlerOrthogonalInvariance



open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] [MeasurableSpace E] [BorelSpace E]
    (mu : Measure E) (L : E ≃ₗᵢ[ℝ] E) (t : E) :
    charFun (mu.map L) t = charFun mu (L.symm t) := by

  rw [charFun_apply, charFun_apply, integral_map (by fun_prop) (by fun_prop)]
  congr 1
  ext x
  congr 2
  simpa using L.inner_map_map x (L.symm t)

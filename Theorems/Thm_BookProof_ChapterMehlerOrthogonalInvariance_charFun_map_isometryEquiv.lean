-- Generated from ChapterMehlerOrthogonalInvariance.lean — theorem BookProof.ChapterMehlerOrthogonalInvariance.charFun_map_isometryEquiv
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
open BookProof.ChapterMehlerOrthogonalInvariance


open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterMehlerOrthogonalInvariance.charFun_map_isometryEquiv {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] [MeasurableSpace E] [BorelSpace E]
    (mu : Measure E) (L : E ≃ₗᵢ[ℝ] E) (t : E) :
    charFun (mu.map L) t = charFun mu (L.symm t) := by sorry

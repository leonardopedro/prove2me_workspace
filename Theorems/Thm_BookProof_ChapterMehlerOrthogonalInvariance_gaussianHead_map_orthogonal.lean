-- Generated from ChapterMehlerOrthogonalInvariance.lean — theorem BookProof.ChapterMehlerOrthogonalInvariance.gaussianHead_map_orthogonal
import Mathlib
import Definitions.Def_ChapterMehlerOrthogonalInvariance
import Definitions.Def_ChapterA4
open BookProof.ChapterMehlerOrthogonalInvariance


open MeasureTheory ProbabilityTheory Matrix
open scoped RealInnerProductSpace

noncomputable section


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterMehlerOrthogonalInvariance.gaussianHead_map_orthogonal {k : ℕ} (O : Matrix (Fin k) (Fin k) ℝ)
    (hO : Oᵀ * O = 1) :
    (gaussianHead k).map (fun x => O *ᵥ x) = gaussianHead k := by sorry

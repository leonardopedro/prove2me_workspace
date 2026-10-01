-- Generated from ChapterSirkSpectralGeometry.lean — theorem BookProof.ChapterSirkSpectralGeometry.numRange_subset_realSegment_of_shiftInvert
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterHashimotoShiftInvert
open BookProof.ChapterH9
open BookProof.ChapterSirkSpectralGeometry

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine

theorem BookProof.ChapterSirkSpectralGeometry.numRange_subset_realSegment_of_shiftInvert {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) :
    numRange R ⊆ realSegment 0 γ⁻¹ := by sorry

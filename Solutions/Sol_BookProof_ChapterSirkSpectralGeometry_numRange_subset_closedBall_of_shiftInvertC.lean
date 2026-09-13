-- Generated from ChapterSirkSpectralGeometry.lean — solution of BookProof.ChapterSirkSpectralGeometry.numRange_subset_closedBall_of_shiftInvertC
import Mathlib
import Definitions.Def_ChapterSirkSpectralGeometry
import Theorems.Thm_BookProof_ChapterH9_numRange_subset_closedBall
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
open BookProof.ChapterSirkSpectralGeometry









noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0) :
    numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ :=
  (numRange_subset_closedBall X).trans
      (Metric.closedBall_subset_closedBall (hX.opNorm_le hsym hγ))

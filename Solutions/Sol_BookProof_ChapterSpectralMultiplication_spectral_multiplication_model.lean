-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.spectral_multiplication_model
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_isProbabilityMeasure_spectralMeasure
import Theorems.Thm_BookProof_ChapterSpectralMultiplication_spectralUnitary_intertwines
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))

set_option maxHeartbeats 1000000 in
theorem solution (hxi : ‖xi‖ = 1) :
    ∃ (mu : Measure (spectrum ℂ T)) (_ : IsProbabilityMeasure mu)
      (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      (∀ u : Lp ℂ 2 mu, U (mulRep mu (coordFn T) u) = T (U u)) ∧
      (∀ v : H, U.symm (T v) = mulRep mu (coordFn T) (U.symm v)) := by

  refine ⟨spectralMeasure T hT xi, isProbabilityMeasure_spectralMeasure T hT xi hxi,
    spectralUnitary T hT xi hcyc, spectralUnitary_intertwines T hT xi hcyc, ?_⟩
  intro v
  have h := spectralUnitary_intertwines T hT xi hcyc ((spectralUnitary T hT xi hcyc).symm v)
  rw [LinearIsometryEquiv.apply_symm_apply] at h
  rw [← h, LinearIsometryEquiv.symm_apply_apply]

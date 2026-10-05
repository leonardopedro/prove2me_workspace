-- Generated from ChapterSpectralMultiplication.lean — theorem BookProof.ChapterSpectralMultiplication.spectral_multiplication_model
import Definitions.Def_ChapterAbelianGelfandModel
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)
variable (hcyc : DenseRange (cfcVec T hT xi))


open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel


theorem BookProof.ChapterSpectralMultiplication.spectral_multiplication_model (hxi : ‖xi‖ = 1) :
    ∃ (mu : Measure (spectrum ℂ T)) (_ : IsProbabilityMeasure mu)
      (U : Lp ℂ 2 mu ≃ₗᵢ[ℂ] H),
      (∀ u : Lp ℂ 2 mu, U (mulRep mu (coordFn T) u) = T (U u)) ∧
      (∀ v : H, U.symm (T v) = mulRep mu (coordFn T) (U.symm v)) := by sorry

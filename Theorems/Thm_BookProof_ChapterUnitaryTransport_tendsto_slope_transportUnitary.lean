-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.tendsto_slope_transportUnitary
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace



theorem BookProof.ChapterUnitaryTransport.tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by sorry

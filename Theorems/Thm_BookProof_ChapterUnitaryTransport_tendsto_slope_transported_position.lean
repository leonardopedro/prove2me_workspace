-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.tendsto_slope_transported_position
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

 f) y

theorem BookProof.ChapterUnitaryTransport.tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp := by sorry

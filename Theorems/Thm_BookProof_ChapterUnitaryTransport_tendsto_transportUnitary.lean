-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.tendsto_transportUnitary
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

theorem BookProof.ChapterUnitaryTransport.tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by sorry

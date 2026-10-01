-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.transportUnitary_add
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

theorem BookProof.ChapterUnitaryTransport.transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by sorry

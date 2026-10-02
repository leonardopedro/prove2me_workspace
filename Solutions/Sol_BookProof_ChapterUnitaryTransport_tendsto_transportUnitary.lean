-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.tendsto_transportUnitary
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by

  have h1 := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  rw [LinearIsometryEquiv.apply

-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.tendsto_slope_transported_position
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_tendsto_slope_transportUnitary
import Theorems.Thm_BookProof_ChapterUnboundedPosition_tendsto_slope_phaseUnitary
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
 f) y

theorem solution (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp :=
  f) y)) :=
    tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnita

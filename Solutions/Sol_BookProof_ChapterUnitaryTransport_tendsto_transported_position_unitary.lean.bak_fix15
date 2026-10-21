-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.tendsto_transported_position_unitary
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_tendsto_transportUnitary
import Theorems.Thm_BookProof_ChapterUnboundedPosition_tendsto_phaseUnitary
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  hds y) :=
    tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnita

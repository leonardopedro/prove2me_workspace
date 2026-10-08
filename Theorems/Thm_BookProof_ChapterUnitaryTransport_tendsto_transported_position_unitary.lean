-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.tendsto_transported_position_unitary
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


theorem BookProof.ChapterUnitaryTransport.tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) := by sorry

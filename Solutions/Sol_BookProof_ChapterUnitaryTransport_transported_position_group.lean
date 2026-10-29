-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.transported_position_group
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_transportUnitary_add
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterStoneSeparable
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in

theorem solution (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

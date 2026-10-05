-- Generated from ChapterCayleyInverse.lean — solution of BookProof.ChapterCayleyInverse.oneSubU_apply
import Mathlib
import Definitions.Def_ChapterCayleyInverse



open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (V : H ≃ₗᵢ[ℂ] H)

set_option maxHeartbeats 1000000 in
theorem solution (x : H) : oneSubU V x = x - V x := rfl

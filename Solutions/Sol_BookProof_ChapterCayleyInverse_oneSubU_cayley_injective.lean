-- Generated from ChapterCayleyInverse.lean — solution of BookProof.ChapterCayleyInverse.oneSubU_cayley_injective
import Mathlib
import Definitions.Def_ChapterCayleyInverse
open BookProof.ChapterCayleyInverse



open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (V : H ≃ₗᵢ[ℂ] H)
variable (hinj : Function.Injective (oneSubU V))
variable [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective (oneSubU (cayley T)) := by

  intro a b hab
  exact one_sub_cayley_injective T hab

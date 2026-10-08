-- Generated from ChapterCayleyInverse.lean — solution of BookProof.ChapterCayleyInverse.invCayleyDomain_cayley
import Mathlib
import Definitions.Def_ChapterCayleyInverse
import Theorems.Thm_BookProof_ChapterCayleyTransform_range_one_sub_cayley
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
theorem solution : invCayleyDomain (cayley T) = T.domain := by

  apply SetLike.ext_prime
  rw [invCayleyDomain, LinearMap.coe_range]
  exact range_one_sub_cayley T

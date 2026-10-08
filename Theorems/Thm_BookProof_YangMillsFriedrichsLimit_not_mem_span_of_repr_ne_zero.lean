-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.not_mem_span_of_repr_ne_zero
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
open BookProof.YangMillsFriedrichsLimit



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.YangMillsFriedrichsLimit.not_mem_span_of_repr_ne_zero (b : HilbertBasis ℕ ℂ F)
    (x : F) (hx : ∀ i, b.repr x i ≠ 0) : x ∉ Submodule.span ℂ (Set.range b) := by sorry

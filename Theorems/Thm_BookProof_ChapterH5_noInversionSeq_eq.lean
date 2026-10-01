-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.noInversionSeq_eq
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}


noncomputable section




theorem BookProof.ChapterH5.noInversionSeq_eq (H : E →ₗ[K] E) (γ : K) (v : E) (k : ℕ) :
    noInversionSeq H γ v k = (((H - γ • 1) ^ k) v) := by sorry

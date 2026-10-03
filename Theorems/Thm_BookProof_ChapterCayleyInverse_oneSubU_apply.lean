-- Generated from ChapterCayleyInverse.lean — theorem BookProof.ChapterCayleyInverse.oneSubU_apply
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterCayleyTransform
import Mathlib
import Definitions.Def_ChapterCayleyInverse
import Definitions.Def_ChapterA4

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (V : H ≃ₗᵢ[ℂ] H)


open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform


theorem BookProof.ChapterCayleyInverse.oneSubU_apply (x : H) : oneSubU V x = x - V x := by sorry

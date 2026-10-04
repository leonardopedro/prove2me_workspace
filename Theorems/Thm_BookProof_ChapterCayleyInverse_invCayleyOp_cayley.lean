-- Generated from ChapterCayleyInverse.lean — theorem BookProof.ChapterCayleyInverse.invCayleyOp_cayley
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterCayleyInverse
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.ChapterCayleyTransform
open BookProof.ChapterCayleyInverse

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (V : H ≃ₗᵢ[ℂ] H)
variable (hinj : Function.Injective (oneSubU V))
variable [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform


theorem BookProof.ChapterCayleyInverse.invCayleyOp_cayley (x : T.domain) (hmem : (x : H) ∈ invCayleyDomain (cayley T)) :
    invCayleyOp (cayley T) (oneSubU_cayley_injective T) ⟨(x : H), hmem⟩ = T.op x := by sorry

-- Generated from ChapterCayleyInverse.lean — theorem BookProof.ChapterCayleyInverse.cayley_ofUnitary
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterCayleyInverse
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterCayleyTransform
open BookProof.ChapterCayleyInverse

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable (V : H ≃ₗᵢ[ℂ] H)
variable (hinj : Function.Injective (oneSubU V))
variable [CompleteSpace H]


open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform


theorem BookProof.ChapterCayleyInverse.cayley_ofUnitary (hdense : Dense ((invCayleyDomain V : Submodule ℂ H) : Set H))
    (y : H) : cayley (ofUnitary V hinj hdense) y = V y := by sorry

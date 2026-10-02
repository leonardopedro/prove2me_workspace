-- Generated from ChapterStoneTheorem.lean — theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.ext'
import Mathlib
import Definitions.Def_ChapterStoneTheorem
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.ChapterUnitaryTransport
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped InnerProductSpace



theorem BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint.ext' : ∀ {T S : UnboundedSelfAdjoint H}, T.domain = S.domain →
    (∀ (x : H) (hx : x ∈ T.domain) (hx' : x ∈ S.domain), T.op ⟨x, hx⟩ = S.op ⟨x, hx'⟩) → T = S := by sorry

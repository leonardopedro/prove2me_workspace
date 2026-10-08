-- Generated from ChapterCayleyTransform.lean — theorem BookProof.ChapterCayleyTransform.add_cayley_shift
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterCayleyTransform


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


theorem BookProof.ChapterCayleyTransform.add_cayley_shift (x : T.domain) :
    T.shift (-1) x + cayley T (T.shift (-1) x) = (2 : ℂ) • T.op x := by sorry

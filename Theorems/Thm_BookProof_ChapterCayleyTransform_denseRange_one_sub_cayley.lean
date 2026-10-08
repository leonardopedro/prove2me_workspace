-- Generated from ChapterCayleyTransform.lean — theorem BookProof.ChapterCayleyTransform.denseRange_one_sub_cayley
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.ChapterCayleyTransform


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


theorem BookProof.ChapterCayleyTransform.denseRange_one_sub_cayley :
    DenseRange (fun y : H => y - cayley T y) := by sorry

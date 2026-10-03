-- Generated from ChapterBrstUnboundedLeakage.lean — theorem BookProof.BrstUnboundedLeakage.truncGen_isSelfAdjoint
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterBrstUnboundedLeakage
import Definitions.Def_ChapterBrstTruncationLeakage
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.BrstLeakage
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)
variable (V : Submodule ℂ H) [FiniteDimensional ℂ V] (hV : V ≤ T.domain)


open NormedSpace Filter Topology
open scoped InnerProductSpace


open BookProof.BrstLeakage BookProof.ChapterStoneResolvent


theorem BookProof.BrstUnboundedLeakage.truncGen_isSelfAdjoint : IsSelfAdjoint (truncGen T V hV) := by sorry

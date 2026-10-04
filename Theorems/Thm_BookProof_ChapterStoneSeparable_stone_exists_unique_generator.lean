-- Generated from ChapterStoneSeparable.lean — theorem BookProof.ChapterStoneSeparable.stone_exists_unique_generator
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneTheorem
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterA4
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneTheorem
open BookProof.ChapterStoneSeparable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

theorem BookProof.ChapterStoneSeparable.stone_exists_unique_generator (G : WeakMeasurableUnitaryGroup H) :
    ∃! T : UnboundedSelfAdjoint H, ∀ t : ℝ, T.stoneU t = G.U t := by sorry

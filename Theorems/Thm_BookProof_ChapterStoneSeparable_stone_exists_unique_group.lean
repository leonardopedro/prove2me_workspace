-- Generated from ChapterStoneSeparable.lean — theorem BookProof.ChapterStoneSeparable.stone_exists_unique_group
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneConverse
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneTheorem
open BookProof.ChapterStoneTheorem
open BookProof.ChapterStoneSeparable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

theorem BookProof.ChapterStoneSeparable.stone_exists_unique_group (T : UnboundedSelfAdjoint H) :
    ∃! G : WeakMeasurableUnitaryGroup H,
      ∀ x : T.domain, HasDerivAt (fun t : ℝ => G.U t (x : H)) ((-Complex.I) • T.op x) 0 := by sorry

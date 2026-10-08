-- Generated from ChapterStoneConverse.lean — theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.mem_genDomain_of_hasDerivAt
import Mathlib
import Definitions.Def_ChapterStoneConverse
import Definitions.Def_ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable


open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.mem_genDomain_of_hasDerivAt {x y : H} (h : HasDerivAt (fun t : ℝ => G.U t x) y 0) :
    x ∈ G.genDomain := by sorry

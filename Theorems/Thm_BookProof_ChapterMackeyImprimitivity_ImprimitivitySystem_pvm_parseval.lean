-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.pvm_parseval
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity


open scoped InnerProductSpace
open Finset


variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable (S : ImprimitivitySystem G X E)

theorem BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem.pvm_parseval (ψ : E) : ∑ x : X, ‖S.p x ψ‖ ^ 2 = ‖ψ‖ ^ 2 := by sorry

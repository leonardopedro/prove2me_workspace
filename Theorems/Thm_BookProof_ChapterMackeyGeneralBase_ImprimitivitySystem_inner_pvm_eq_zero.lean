-- Generated from ChapterMackeyGeneralBase.lean — theorem BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.inner_pvm_eq_zero
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
import Definitions.Def_ChapterMackeyImprimitivity
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.ChapterMackeyGeneralBase

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)


open scoped InnerProductSpace


open BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.inner_pvm_eq_zero {x y : X} (hxy : x ≠ y) (ψ φ : E) :
    ⟪S.p x ψ, S.p y φ⟫_ℂ = 0 := by sorry

-- Generated from ChapterMackeyGeneralBase.lean — theorem BookProof.ChapterMackeyGeneralBase.mackeyMap_injective
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyGeneralBase

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)
variable (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
variable {S x₀ s}


open scoped InnerProductSpace


open BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterMackeyGeneralBase.mackeyMap_injective : Function.Injective (mackeyMap S s) := by sorry

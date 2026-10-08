-- Generated from ChapterMackeyGeneralBase.lean — theorem BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.pvm_hasSum_norm_sq
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterMackeyGeneralBase
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyGeneralBase
open BookProof.ChapterMackeyGeneralBase


open scoped InnerProductSpace


open BookProof.ChapterOrthogonalSums

variable {G : Type*} [Group G] {X : Type*} [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

variable (S : ImprimitivitySystem G X E)

theorem BookProof.ChapterMackeyGeneralBase.ImprimitivitySystem.pvm_hasSum_norm_sq (ψ : E) : HasSum (fun x => ‖S.p x ψ‖ ^ 2) (‖ψ‖ ^ 2) := by sorry

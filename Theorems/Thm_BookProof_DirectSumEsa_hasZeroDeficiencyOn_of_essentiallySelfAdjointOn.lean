-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.hasZeroDeficiencyOn_of_essentiallySelfAdjointOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.DirectSumEsa


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
open BookProof.NavierStokesFlow

theorem BookProof.DirectSumEsa.hasZeroDeficiencyOn_of_essentiallySelfAdjointOn {Dom : Submodule ℂ F}
    (A : Dom →ₗ[ℂ] Dom) (h : EssentiallySelfAdjointOn Dom (Dom.subtype.comp A)) :
    HasZeroDeficiencyOn Dom A := by sorry

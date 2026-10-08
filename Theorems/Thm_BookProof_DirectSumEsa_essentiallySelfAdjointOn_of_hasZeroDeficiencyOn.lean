-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.essentiallySelfAdjointOn_of_hasZeroDeficiencyOn
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

theorem BookProof.DirectSumEsa.essentiallySelfAdjointOn_of_hasZeroDeficiencyOn {Dom : Submodule ℂ F}
    (A : Dom →ₗ[ℂ] Dom) (h : HasZeroDeficiencyOn Dom A) :
    EssentiallySelfAdjointOn Dom (Dom.subtype.comp A) := by sorry

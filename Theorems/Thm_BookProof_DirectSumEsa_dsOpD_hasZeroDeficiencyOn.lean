-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.dsOpD_hasZeroDeficiencyOn
import Definitions.Def_ChapterFarisLavine
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

theorem BookProof.DirectSumEsa.dsOpD_hasZeroDeficiencyOn (A : ∀ i, D i →ₗ[ℂ] D i)
    (h : ∀ i, HasZeroDeficiencyOn (D i) (A i)) :
    HasZeroDeficiencyOn (dsCore D) (dsOpD A) := by sorry

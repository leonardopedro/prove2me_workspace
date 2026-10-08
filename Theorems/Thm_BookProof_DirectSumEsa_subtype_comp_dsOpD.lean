-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.subtype_comp_dsOpD
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.DirectSumEsa.subtype_comp_dsOpD (A : ∀ i, D i →ₗ[ℂ] D i) :
    (dsCore D).subtype.comp (dsOpD A) = dsOp (fun i => (D i).subtype.comp (A i)) := by sorry

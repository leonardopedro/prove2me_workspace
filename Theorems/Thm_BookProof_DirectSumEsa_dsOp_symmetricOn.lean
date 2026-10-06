-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.dsOp_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.DirectSumEsa

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable {D : ∀ i, Submodule ℂ (G i)}


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section


theorem BookProof.DirectSumEsa.dsOp_symmetricOn (H : ∀ i, D i →ₗ[ℂ] G i) (hsym : ∀ i, SymmetricOn (D i) (H i)) :
    SymmetricOn (dsCore D) (dsOp H) := by sorry

-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.dsOpD_coe
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section


theorem BookProof.DirectSumEsa.dsOpD_coe (A : ∀ i, D i →ₗ[ℂ] D i) (x : dsCore D) :
    ((dsOpD A x : dsCore D) : lp G 2)
      = (dsOp (fun i => (D i).subtype.comp (A i)) x : lp G 2) := by sorry

-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.dsOpD_coe
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa



open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (A : ∀ i, D i →ₗ[ℂ] D i) (x : dsCore D) :
    ((dsOpD A x : dsCore D) : lp G 2)
      = (dsOp (fun i => (D i).subtype.comp (A i)) x : lp G 2) := rfl

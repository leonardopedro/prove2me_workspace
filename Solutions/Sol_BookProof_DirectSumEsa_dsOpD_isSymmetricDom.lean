-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.dsOpD_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_symmetricOn
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
theorem solution (A : ∀ i, D i →ₗ[ℂ] D i)
    (hsym : ∀ i, IsSymmetricDom (A i)) : IsSymmetricDom (dsOpD A) := fun x y => dsOp_symmetricOn (fun i => (D i).subtype.comp (A i)) (fun i u v => hsym i u v) x y

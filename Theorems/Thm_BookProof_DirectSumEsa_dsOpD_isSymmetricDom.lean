-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.dsOpD_isSymmetricDom
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow.FullEsa
open BookProof.NavierStokesFlow.FullEsa.NSFullData
open BookProof.DirectSumEsa


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
open BookProof.NavierStokesFlow.FullEsa

theorem BookProof.DirectSumEsa.dsOpD_isSymmetricDom (A : ∀ i, D i →ₗ[ℂ] D i)
    (hsym : ∀ i, IsSymmetricDom (A i)) : IsSymmetricDom (dsOpD A) := by sorry

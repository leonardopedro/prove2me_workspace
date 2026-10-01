-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}




open FullEsa

 :
      (diagOp fun k => ∑ i, p i k ^ 2) + (diagOp fun k => ∑ i, q i k ^ 2)
          + (LinearMap.id : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ)
        = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by
    rw [diagOp_one, FullEsa.diagOp_add, FullEsa.diagOp_add]
    all_goals rfl
  exact h1

/-- **The one-particle comparison operator is essentially self-adjoint** in the
momentum representation, with no hypothe := by sorry

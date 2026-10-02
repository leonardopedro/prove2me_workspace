-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Theorems.Thm_BookProof_NavierStokesFlow_FarisLavineLift_diagComparison_eq
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)

set_option maxHeartbeats 1000000 in
 :
      (diagOp fun k => ∑ i, p i k ^ 2) + (diagOp fun k => ∑ i, q i k ^ 2)
          + (LinearMap.id : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ)
        = diagOp (fun k => (∑ i, p i k ^ 2) + (∑ i, q i k ^ 2) + 1) := by
    rw [diagOp_one, FullEsa.diagOp_add, FullEsa.diagOp_add]
    all_goals rfl
  exact h1

/-- **The one-particle comparison operator is essentially self-adjoint** in the
momentum representation, with no hypothe :=
  sis whatsoever on the symbols: this is
  the fiber-space form of the

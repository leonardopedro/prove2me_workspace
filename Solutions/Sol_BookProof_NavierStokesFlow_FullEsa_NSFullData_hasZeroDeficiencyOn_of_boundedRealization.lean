-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.NSFullData.hasZeroDeficiencyOn_of_boundedRealization
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_hasZeroDeficiencyOn_of_boundedRealization
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa
open BookProof.NavierStokesFlow.FullEsa.NSFullData



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F)
    (hsym : (A : F →ₗ[ℂ] F).IsSymmetric) (hHA : ∀ x : d.D, (d.hamiltonian x : F) = A (x : F)) :
    HasZeroDeficiencyOn d.D d.hamiltonian :=
  _root_.BookProof.NavierStokesFlow.FullEsa.hasZeroDeficiencyOn_of_boundedRealization
      d.hamiltonian A hsym d.dense hHA

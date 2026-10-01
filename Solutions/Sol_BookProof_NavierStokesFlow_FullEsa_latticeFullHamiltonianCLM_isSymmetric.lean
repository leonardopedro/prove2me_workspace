-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.latticeFullHamiltonianCLM_isSymmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_latticeFullHamiltonianCLM_isSelfAdjoint
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 15 → LinfZ) (nu : ℝ) :
    ((latticeFullHamiltonianCLM v nu : L2Z →L[ℂ] L2Z) : L2Z →ₗ[ℂ] L2Z).IsSymmetric := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.1 (latticeFullHamiltonianCLM_isSelfAdjoint v nu)

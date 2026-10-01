-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.latticeFullData_hamiltonian_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_latticeFullData_advection_apply
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 15 → LinfZ) (nu : ℝ)
    (x : (latticeFullData v nu).D) :
    ((latticeFullData v nu).hamiltonian x : L2Z) = latticeFullHamiltonianCLM v nu (x : L2Z) := by

  simp only [NSFullData.hamiltonian, LinearMap.sum_apply, LinearMap.add_apply,
    LinearMap.comp_apply, Submodule.coe_add, Submodule.coe_sum,
    latticeFullHamiltonianCLM, ContinuousLinearMap.sum_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.mul_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hmom : ∀ y : (latticeFullData v nu).D,
      (((latticeFullData v nu).mom i y : (latticeFullData v nu).D) : L2Z) = momentum (y : L2Z) :=
    fun _ => rfl
  rw [hmom, latticeFullData_advection_apply, latticeFullData_advection_apply, hmom]

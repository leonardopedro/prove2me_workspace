-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.latticeFullHamiltonianCLM_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_FullEsa_latticeAdvectionCLM_mem_finiteModes
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 15 → LinfZ) (nu : ℝ)
    {f : L2Z} (hf : f ∈ finiteModes) : latticeFullHamiltonianCLM v nu f ∈ finiteModes := by

  simp only [latticeFullHamiltonianCLM, ContinuousLinearMap.sum_apply,
    ContinuousLinearMap.add_apply, ContinuousLinearMap.mul_apply]
  refine Submodule.sum_mem _ fun i _ => Submodule.add_mem _ ?_ ?_
  · exact momentum_mem_finiteModes (latticeAdvectionCLM_mem_finiteModes v nu i hf)
  · exact latticeAdvectionCLM_mem_finiteModes v nu i (momentum_mem_finiteModes hf)

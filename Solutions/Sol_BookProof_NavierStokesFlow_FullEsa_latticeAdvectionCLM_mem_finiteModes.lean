-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.latticeAdvectionCLM_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_NavierStokesFlow_velocityOp_mem_finiteModes
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 15 → LinfZ) (nu : ℝ) (i : Fin 3)
    {f : L2Z} (hf : f ∈ finiteModes) : latticeAdvectionCLM v nu i f ∈ finiteModes := by

  simp only [latticeAdvectionCLM, ContinuousLinearMap.sub_apply, ContinuousLinearMap.sum_apply,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.mul_apply]
  refine Submodule.sub_mem _ (Submodule.sum_mem _ fun j _ => ?_)
    (Submodule.smul_mem _ _ (velocityOp_mem_finiteModes _ hf))
  exact velocityOp_mem_finiteModes _ (velocityOp_mem_finiteModes _ hf)

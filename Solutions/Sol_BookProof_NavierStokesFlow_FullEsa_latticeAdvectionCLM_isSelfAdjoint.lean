-- Generated from ChapterNavierStokesFullEsa.lean — solution of BookProof.NavierStokesFlow.FullEsa.latticeAdvectionCLM_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEsa
import Theorems.Thm_BookProof_ChapterGaugeShiftExample_velocityOp_commute
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FullEsa



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable (d : NSFullData F)

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 15 → LinfZ) (nu : ℝ) (i : Fin 3) :
    IsSelfAdjoint (latticeAdvectionCLM v nu i) := by

  have hv : ∀ k, IsSelfAdjoint (velocityOp (v k)) := fun k => velocityOp_isSelfAdjoint (v k)
  change star (latticeAdvectionCLM v nu i) = latticeAdvectionCLM v nu i
  rw [latticeAdvectionCLM, star_sub, star_smul, star_sum]
  congr 1
  · refine Finset.sum_congr rfl fun j _ => ?_
    rw [star_mul, (hv _).star_eq, (hv _).star_eq]
    exact (velocityOp_commute _ _).symm
  · rw [(hv _).star_eq]
    congr 1
    exact Complex.conj_ofReal nu

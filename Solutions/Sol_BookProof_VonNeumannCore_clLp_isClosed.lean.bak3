-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.clLp_isClosed
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_EsaClosure_clGraph_isClosed
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) :
    IsClosed ((clLp A : Submodule ℂ (WithLp 2 (F × F))) : Set (WithLp 2 (F × F))) := by

  have hcont : Continuous fun p : WithLp 2 (F × F) => WithLp.ofLp p := by fun_prop
  exact (clGraph_isClosed A).preimage hcont

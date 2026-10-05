-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.frDom_dense
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_eq_zero_of_inner_frDom_eq_zero
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) :
    Dense ((frDom A : Submodule ℂ F) : Set F) := by

  rw [Submodule.dense_iff_topologicalClosure_eq_top, Submodule.topologicalClosure_eq_top_iff,
    Submodule.eq_bot_iff]
  intro x hx
  exact eq_zero_of_inner_frDom_eq_zero A hdense fun u hu => hx u hu

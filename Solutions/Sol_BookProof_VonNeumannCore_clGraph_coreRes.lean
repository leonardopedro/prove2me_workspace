-- Generated from ChapterVonNeumannCore.lean — solution of BookProof.VonNeumannCore.clGraph_coreRes
import Mathlib
import Definitions.Def_ChapterVonNeumannCore
import Theorems.Thm_BookProof_VonNeumannCore_topologicalClosure_coreGraph
import Theorems.Thm_BookProof_VonNeumannCore_opGraph_coreRes
open BookProof.VonNeumannCore




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) :
    clGraph (coreRes A hdense hsym) = clGraph A := by

  unfold clGraph
  rw [opGraph_coreRes A hdense hsym]
  exact topologicalClosure_coreGraph A hdense hsym

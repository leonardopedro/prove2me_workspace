-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.univ_two
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.GroupAverage




open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)
variable (G) in
variable {D : Submodule ℂ F}
variable {T : D →ₗ[ℂ] F}

set_option maxHeartbeats 1000000 in
theorem solution : (Finset.univ : Finset (Multiplicative (ZMod 2)))
    = {1, Multiplicative.ofAdd 1} := by
 decide

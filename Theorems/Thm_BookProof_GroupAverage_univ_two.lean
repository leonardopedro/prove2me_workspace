-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.univ_two
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.GroupAverage



open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable (rep : UnitaryRep G F)
variable {D : Submodule ℂ F}
variable {T : D →ₗ[ℂ] F}

theorem BookProof.GroupAverage.univ_two : (Finset.univ : Finset (Multiplicative (ZMod 2)))
    = {1, Multiplicative.ofAdd 1} := by sorry

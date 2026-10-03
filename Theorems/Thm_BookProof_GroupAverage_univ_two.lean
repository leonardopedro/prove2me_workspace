-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.univ_two
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterA4

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)
variable (G) in
variable {D : Submodule ℂ F}
variable {T : D →ₗ[ℂ] F}




noncomputable section


theorem BookProof.GroupAverage.univ_two : (Finset.univ : Finset (Multiplicative (ZMod 2)))
    = {1, Multiplicative.ofAdd 1} := by sorry

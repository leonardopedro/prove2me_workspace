-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.UnitaryRep.avgProj_mem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterA4
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.ChapterWignerLittleGroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)
variable (G) in
variable {D : Submodule ℂ F}




noncomputable section


theorem BookProof.GroupAverage.UnitaryRep.avgProj_mem (hD : ∀ (g : G) (x : F), x ∈ D → rep.act g x ∈ D) :
    ∀ x ∈ D, rep.avgProj x ∈ D := by sorry

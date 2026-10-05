-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.UnitaryRep.avgProj_mem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterFockStatisticsCompletion
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage
open BookProof.GroupAverage

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)
variable (G) in
variable {D : Submodule ℂ F}



open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section


theorem BookProof.GroupAverage.UnitaryRep.avgProj_mem (hD : ∀ (g : G) (x : F), x ∈ D → rep.act g x ∈ D) :
    ∀ x ∈ D, rep.avgProj x ∈ D := by sorry

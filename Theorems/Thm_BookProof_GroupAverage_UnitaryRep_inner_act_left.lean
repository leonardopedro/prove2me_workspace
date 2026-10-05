-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.UnitaryRep.inner_act_left
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterFockStatisticsCompletion
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage
open BookProof.GroupAverage

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)



open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section


theorem BookProof.GroupAverage.UnitaryRep.inner_act_left (g : G) (x y : F) :
    (inner ℂ (rep.act g x) y : ℂ) = inner ℂ x (rep.act g⁻¹ y) := by sorry

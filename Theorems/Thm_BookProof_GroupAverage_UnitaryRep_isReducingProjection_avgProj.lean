-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.UnitaryRep.isReducingProjection_avgProj
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



open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section


theorem BookProof.GroupAverage.UnitaryRep.isReducingProjection_avgProj : IsReducingProjection rep.avgProj where
  idem x := by sorry

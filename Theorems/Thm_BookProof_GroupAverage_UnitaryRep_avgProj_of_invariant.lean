-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.UnitaryRep.avgProj_of_invariant
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




noncomputable section


theorem BookProof.GroupAverage.UnitaryRep.avgProj_of_invariant {x : F} (hx : ∀ g : G, rep.act g x = x) : rep.avgProj x = x := by sorry

-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.UnitaryRep.essentiallySelfAdjointOn_invariantSector
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage
open BookProof.GroupAverage



open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable (rep : UnitaryRep G F)
variable {D : Submodule ℂ F}
variable {T : D →ₗ[ℂ] F}

theorem BookProof.GroupAverage.UnitaryRep.essentiallySelfAdjointOn_invariantSector
    {hD : ∀ (g : G) (x : F), x ∈ D → rep.act g x ∈ D}
    (hT : ∀ (g : G) (x : D), T ⟨rep.act g (x : F), hD g _ x.2⟩ = rep.act g (T x))
    (hesa : EssentiallySelfAdjointOn D T) :
    EssentiallySelfAdjointOn (redDom rep.avgProj D)
      (redOp T rep.isReducingProjection_avgProj (rep.commutes_avgProj hT)) := by sorry

-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.UnitaryRep.symmetricOn_invariantSector
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterFarisLavineCore
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
variable {T : D →ₗ[ℂ] F}




noncomputable section


theorem BookProof.GroupAverage.UnitaryRep.symmetricOn_invariantSector
    {hD : ∀ (g : G) (x : F), x ∈ D → rep.act g x ∈ D}
    (hT : ∀ (g : G) (x : D), T ⟨rep.act g (x : F), hD g _ x.2⟩ = rep.act g (T x))
    (hsym : SymmetricOn D T) :
    SymmetricOn (redDom rep.avgProj D)
      (redOp T rep.isReducingProjection_avgProj (rep.commutes_avgProj hT)) := by sorry

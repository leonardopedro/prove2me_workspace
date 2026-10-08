-- Generated from ChapterGroupAverageEsa.lean — theorem BookProof.GroupAverage.avgProj_repOfInvolution
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage



open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable (rep : UnitaryRep G F)
variable {D : Submodule ℂ F}
variable {T : D →ₗ[ℂ] F}

theorem BookProof.GroupAverage.avgProj_repOfInvolution (U : F →ₗ[ℂ] F) (hU2 : ∀ x, U (U x) = x)
    (hUi : ∀ x y : F, (inner ℂ (U x) (U y) : ℂ) = inner ℂ x y) (x : F) :
    (repOfInvolution U hU2 hUi).avgProj x = symProj U x := by sorry

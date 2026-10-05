-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.hfermionicFock_esa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_FockStatistics_essentiallySelfAdjointOn_cfermionic
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics




open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (hfermionicFockDom Hs D) (hfermionicFockOp Hs D A) :=
  dsOp_essentiallySelfAdjointOn _
      (fun n => essentiallySelfAdjointOn_cfermionic A hdense hsym hesa n)

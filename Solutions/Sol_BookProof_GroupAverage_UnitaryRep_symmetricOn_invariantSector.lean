-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.symmetricOn_invariantSector
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_isReducingProjection_avgProj
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_mem
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_commutes_avgProj
import Theorems.Thm_BookProof_ReducedEsa_symmetricOn_redOp
open BookProof.GroupAverage
open BookProof.GroupAverage.UnitaryRep




open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)
variable (G) in
variable {D : Submodule ℂ F}
variable {T : D →ₗ[ℂ] F}

set_option maxHeartbeats 1000000 in
theorem solution
    {hD : ∀ (g : G) (x : F), x ∈ D → rep.act g x ∈ D}
    (hT : ∀ (g : G) (x : D), T ⟨rep.act g (x : F), hD g _ x.2⟩ = rep.act g (T x))
    (hsym : SymmetricOn D T) :
    SymmetricOn (redDom rep.avgProj D)
      (redOp T rep.isReducingProjection_avgProj (rep.commutes_avgProj hT)) := symmetricOn_redOp _ _ hsym

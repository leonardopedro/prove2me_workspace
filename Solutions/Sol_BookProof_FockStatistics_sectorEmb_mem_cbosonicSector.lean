-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.sectorEmb_mem_cbosonicSector
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_FockStatistics_cbosonicProj_sectorEmb
import Theorems.Thm_BookProof_PermSector_isReducingProjection_bosonicProj
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
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) {x : (Hs.pow n).carrier}
    (hx : x ∈ sector (bosonicProj Hs n)) : sectorEmb Hs n x ∈ sector (cbosonicProj Hs n) :=
  ⟨sectorEmb Hs n x, by
      rw [cbosonicProj_sectorEmb]
      exact congrArg (sectorEmb Hs n) ((isReducingProjection_bosonicProj Hs n).apply_of_mem_range hx)⟩

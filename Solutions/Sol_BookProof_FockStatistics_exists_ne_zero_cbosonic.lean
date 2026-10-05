-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.exists_ne_zero_cbosonic
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_FockStatistics_sectorEmb_mem_cbosonicSector
import Theorems.Thm_BookProof_PermSector_exists_ne_zero_bosonic
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
theorem solution (n : ℕ) {a : Hs.carrier} (haD : a ∈ D) (ha0 : a ≠ 0) :
    ∃ x : redDom (cbosonicProj Hs n) (fockSectorDom Hs D n), x ≠ 0 := by

  obtain ⟨y, hy0⟩ := exists_ne_zero_bosonic Hs D D n le_rfl haD ha0
  set v : (Hs.pow n).carrier := ((y : sector (bosonicProj Hs n)) : (Hs.pow n).carrier) with hv
  have hvsec : v ∈ sector (bosonicProj Hs n) := (y : sector (bosonicProj Hs n)).2
  have hvdom : v ∈ sectorDom Hs D n := sectorCore_le_sectorDom Hs D D n y.2
  have hv0 : v ≠ 0 := by
    intro h
    exact hy0 (Subtype.ext (Subtype.ext h))
  refine ⟨⟨⟨sectorEmb Hs n v, sectorEmb_mem_cbosonicSector Hs n hvsec⟩,
    ⟨v, hvdom, rfl⟩⟩, ?_⟩
  intro h
  refine hv0 ((sectorEmb Hs n).injective ?_)
  have := congrArg Subtype.val (congrArg Subtype.val h)
  simpa using this

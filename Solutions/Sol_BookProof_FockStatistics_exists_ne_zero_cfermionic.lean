-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.exists_ne_zero_cfermionic
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_FockStatistics_sectorEmb_mem_cfermionicSector
import Theorems.Thm_BookProof_PermSector_exists_ne_zero_fermionic
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
theorem solution (n : ℕ) (f : Fin n → Hs.carrier) (hfD : ∀ i, f i ∈ D)
    (hf0 : ∀ i, f i ≠ 0) (hortho : ∀ i j, i ≠ j → (inner ℂ (f i) (f j) : ℂ) = 0) :
    ∃ x : redDom (cfermionicProj Hs n) (fockSectorDom Hs D n), x ≠ 0 := by

  obtain ⟨y, hy0⟩ := exists_ne_zero_fermionic Hs D D n le_rfl f hfD hf0 hortho
  set v : (Hs.pow n).carrier := ((y : sector (fermionicProj Hs n)) : (Hs.pow n).carrier) with hv
  have hvsec : v ∈ sector (fermionicProj Hs n) := (y : sector (fermionicProj Hs n)).2
  have hvdom : v ∈ sectorDom Hs D n := sectorCore_le_sectorDom Hs D D n y.2
  have hv0 : v ≠ 0 := by
    intro h
    exact hy0 (Subtype.ext (Subtype.ext h))
  refine ⟨⟨⟨sectorEmb Hs n v, sectorEmb_mem_cfermionicSector Hs n hvsec⟩,
    ⟨v, hvdom, rfl⟩⟩, ?_⟩
  intro h
  refine hv0 ((sectorEmb Hs n).injective ?_)
  have := congrArg Subtype.val (congrArg Subtype.val h)
  simpa using this

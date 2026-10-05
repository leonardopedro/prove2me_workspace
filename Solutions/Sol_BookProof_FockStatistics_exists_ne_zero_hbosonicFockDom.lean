-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.exists_ne_zero_hbosonicFockDom
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_FockStatistics_exists_ne_zero_cbosonic
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
    ∃ x : hbosonicFockDom Hs D, x ≠ 0 := by

  classical
  obtain ⟨y, hy0⟩ := exists_ne_zero_cbosonic Hs D n haD ha0
  refine ⟨⟨lp.single 2 n ((y : sector (cbosonicProj Hs n))),
    single_mem_dsCore (D := fun n : ℕ => redDom (cbosonicProj Hs n) (fockSectorDom Hs D n))
      n y⟩, ?_⟩
  intro h
  refine hy0 (Subtype.ext ?_)
  have h0 := congrArg (fun z : hbosonicFockDom Hs D =>
    ((z : hbosonicFock Hs) : ∀ n, ↥(sector (cbosonicProj Hs n))) n) h
  simpa using h0

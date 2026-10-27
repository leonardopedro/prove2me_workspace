-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.exists_ne_zero_hfermionicFockDom
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_FockStatistics_exists_ne_zero_cfermionic
import Theorems.Thm_BookProof_DirectSumEsa_single_mem_dsCore
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
theorem solution (n : ℕ) (f : Fin n → Hs.carrier)
    (hfD : ∀ i, f i ∈ D) (hf0 : ∀ i, f i ≠ 0)
    (hortho : ∀ i j, i ≠ j → (inner ℂ (f i) (f j) : ℂ) = 0) :
    ∃ x : hfermionicFockDom Hs D, x ≠ 0 := by

  classical
  obtain ⟨y, hy0⟩ := exists_ne_zero_cfermionic Hs D n f hfD hf0 hortho
  refine ⟨⟨lp.single 2 n ((y : sector (cfermionicProj Hs n))),
    single_mem_dsCore (D := fun n : ℕ => redDom (cfermionicProj Hs n) (fockSectorDom Hs D n))
      n y⟩, ?_⟩
  intro h
  refine hy0 (Subtype.ext ?_)
  have h0 := congrArg (fun z : hfermionicFockDom Hs D =>
    ((z : hfermionicFock Hs) : ∀ n, ↥(sector (cfermionicProj Hs n))) n) h
  simpa using h0

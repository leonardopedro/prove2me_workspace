-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.exists_rep_cyclic_decomposition
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_self_mem_repCyclicSubspace
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_repCyclicSubspace_le_orthogonal
import Theorems.Thm_BookProof_ChapterAbelianDirectSum_repInvariant_iSup_repCyclicSubspace
open BookProof.ChapterAbelianDirectSum



noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ S : Set H, OrthogonalRepCyclicFamily pi S ∧
      (⨆ x ∈ S, repCyclicSubspace pi x).topologicalClosure = ⊤ := by

  obtain ⟨S, hS⟩ :=
    zorn_subset {S : Set H | OrthogonalRepCyclicFamily pi S} (fun c hc hchain => by
      refine ⟨⋃₀ c, ⟨?_, ?_⟩, fun s hs => Set.subset_sUnion_of_mem hs⟩
      · rintro x ⟨s, hs, hx⟩
        exact ((hc hs).1) x hx
      · rintro x ⟨s, hs, hx⟩ y ⟨t, ht, hy⟩ hxy
        rcases hchain.total hs ht with h | h
        · exact ((hc ht).2) x (h hx) y hy hxy
        · exact ((hc hs).2) x hx y (h hy) hxy)
  refine ⟨S, hS.1, ?_⟩
  set N : Submodule ℂ H := ⨆ x ∈ S, repCyclicSubspace pi x with hN
  haveI : CompleteSpace N.topologicalClosure :=
    (Submodule.isClosed_topologicalClosure N).completeSpace_coe
  by_contra hne
  have hbot : N.topologicalClosureᗮ ≠ ⊥ := by
    intro h
    exact hne (Submodule.orthogonal_eq_bot_iff.1 h)
  obtain ⟨v, hv, hv0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hbot
  set u : H := ‖v‖⁻¹ • v with hu
  have hnv : ‖v‖ ≠ 0 := norm_ne_zero_iff.2 hv0
  have hunorm : ‖u‖ = 1 := by
    rw [hu, norm_smul]
    simp [hnv]
  have humem : u ∈ N.topologicalClosureᗮ := Submodule.smul_mem _ _ hv
  have hcyc : repCyclicSubspace pi u ≤ N.topologicalClosureᗮ :=
    repCyclicSubspace_le_orthogonal pi (repInvariant_iSup_repCyclicSubspace pi S) humem
  have hle : ∀ x ∈ S, repCyclicSubspace pi x ≤ N.topologicalClosure := fun x hx =>
    le_trans (le_iSup₂ (f := fun x (_ : x ∈ S) => repCyclicSubspace pi x) x hx)
      (Submodule.le_topologicalClosure N)
  have hnew : (insert u S) ∈ {S : Set H | OrthogonalRepCyclicFamily pi S} := by
    constructor
    · rintro x (rfl | hx)
      · exact hunorm
      · exact hS.1.1 x hx
    · have key : ∀ x ∈ S, repCyclicSubspace pi u ≤ (repCyclicSubspace pi x)ᗮ := fun x hx =>
        le_trans hcyc (Submodule.orthogonal_le (hle x hx))
      have key' : ∀ x ∈ S, repCyclicSubspace pi x ≤ (repCyclicSubspace pi u)ᗮ := fun x hx =>
        le_trans (le_trans (hle x hx) (Submodule.le_orthogonal_orthogonal _))
          (Submodule.orthogonal_le hcyc)
      rintro x (rfl | hx) y (rfl | hy) hxy
      · exact absurd rfl hxy
      · exact key y hy
      · exact key' x hx
      · exact hS.1.2 x hx y hy hxy
  have hnotmem : u ∉ S := by
    intro hmem
    have h1 : u ∈ N.topologicalClosure := hle u hmem (self_mem_repCyclicSubspace pi u)
    have : u = 0 := inner_self_eq_zero.1 ((Submodule.mem_orthogonal _ _).1 humem u h1)
    rw [this] at hunorm
    simp at hunorm
  exact hnotmem (hS.2 hnew (Set.subset_insert u S) (Set.mem_insert u S))

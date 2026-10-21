-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.exists_orthCyclicFamily
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_mem_familyOrbit_self
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_pvm_mem_familyOrbit
import Theorems.Thm_BookProof_ChapterWignerOrbitClassification_SameOrbit_symm
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] (P : Pvm X H) :
    ∃ S : Set H, OrthCyclicFamily P S ∧
      Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H) := by

  have hub : ∀ c ⊆ {S : Set H | OrthCyclicFamily P S}, IsChain (· ⊆ ·) c →
      ∃ ub ∈ {S : Set H | OrthCyclicFamily P S}, ∀ s ∈ c, s ⊆ ub := by
    intro c hc hchain
    refine ⟨⋃₀ c, ⟨?_, ?_⟩, fun s hs => Set.subset_sUnion_of_mem hs⟩
    · rintro ψ ⟨s, hs, hψ⟩
      exact (hc hs).unit ψ hψ
    · rintro ψ ⟨s, hs, hψ⟩ φ ⟨t, ht, hφ⟩ hne
      rcases hchain.total hs ht with hst | hts
      · exact (hc ht).orth ψ (hst hψ) φ hφ hne
      · exact (hc hs).orth ψ hψ φ (hts hφ) hne
  obtain ⟨S, hSmax⟩ := zorn_subset {S : Set H | OrthCyclicFamily P S} hub
  have hS : OrthCyclicFamily P S := hSmax.1
  refine ⟨S, hS, ?_⟩
  set K : Submodule ℂ H := Submodule.span ℂ (familyOrbit P S) with hK
  rw [Submodule.dense_iff_topologicalClosure_eq_top, Submodule.topologicalClosure_eq_top_iff]
  by_contra hne
  obtain ⟨w, hwK, hw0⟩ := K.orthogonal.ne_bot_iff.mp hne
  -- normalize
  set u : H := (‖w‖ : ℂ)⁻¹ • w with hu
  have hwnorm : ‖w‖ ≠ 0 := by simpa using hw0
  have hunorm : ‖u‖ = 1 := by
    rw [hu, norm_smul, norm_inv, Complex.norm_real, Real.norm_eq_abs, abs_norm,
      inv_mul_cancel₀ hwnorm]
  have huK : u ∈ Kᗮ := Submodule.smul_mem _ _ hwK
  -- the cyclic subspace of `u` is orthogonal to every member of the family
  have horth : ∀ ψ ∈ S, OrthOrbit P ψ u := by
    intro ψ hψ E hE
    have h1 : ⟪ψ, P.p E u⟫_ℂ = ⟪P.p E ψ, u⟫_ℂ := (P.symm hE _ _).symm
    have h2 : P.p E ψ ∈ K := Submodule.subset_span (pvm_mem_familyOrbit hψ hE)
    rw [h1]
    exact (Submodule.mem_orthogonal K u).mp huK _ h2
  -- `u` is not already in the family
  have hunotS : u ∉ S := by
    intro hmem
    have huu : ⟪u, u⟫_ℂ = 0 :=
      (Submodule.mem_orthogonal K u).mp huK u (Submodule.subset_span (mem_familyOrbit_self hmem))
    have h0 : u = 0 := inner_self_eq_zero.mp huu
    rw [h0] at hunorm
    simp at hunorm
  -- so the family was not maximal
  have hbig : OrthCyclicFamily P (insert u S) := by
    constructor
    · intro ψ hψ
      rcases hψ with rfl | hψ
      · exact hunorm
      · exact hS.unit ψ hψ
    · intro ψ hψ φ hφ hne'
      rcases hψ with rfl | hψ
      · rcases hφ with rfl | hφ
        · exact absurd rfl hne'
        · exact (horth φ hφ).symm
      · rcases hφ with rfl | hφ
        · exact horth ψ hψ
        · exact hS.orth ψ hψ φ hφ hne'
  have hfin := hSmax.2 hbig (Set.subset_insert _ _)
  exact hunotS (hfin (Set.mem_insert _ _))

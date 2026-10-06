-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.sum_shift
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_mem_cube
import Theorems.Thm_BookProof_HermiteCarleman_sub_add_single
open BookProof.HermiteCarleman




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (d N : ℕ) (i : Fin d) (F : (Fin d →₀ ℕ) → ℂ)
    (hF : ∀ a : Fin d →₀ ℕ, a i = 0 → F a = 0) :
    ∑ a ∈ cube d N, F a = ∑ b ∈ inn d N i, F (b + Finsupp.single i 1) := by

  classical
  rw [← Finset.sum_filter_of_ne (p := fun a : Fin d →₀ ℕ => a i ≠ 0)
    (fun a _ hne => fun h0 => hne (hF a h0))]
  refine Finset.sum_nbij' (fun a => a - Finsupp.single i 1) (fun b => b + Finsupp.single i 1)
    ?_ ?_ ?_ ?_ ?_
  · intro a ha
    simp only [Finset.mem_filter, mem_cube] at ha
    rw [inn, Finset.mem_filter, mem_cube]
    refine ⟨fun j => le_trans (by simp) (ha.1 j), ?_⟩
    have h1 : (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 := by simp
    rw [h1]
    have h2 := ha.1 i
    have h3 := ha.2
    omega
  · intro b hb
    rw [inn, Finset.mem_filter, mem_cube] at hb
    simp only [Finset.mem_filter, mem_cube]
    refine ⟨fun j => ?_, ?_⟩
    · by_cases hj : j = i
      · subst hj; simp; omega
      · simpa [hj] using hb.1 j
    · simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    exact sub_add_single ha.2
  · intro b _; simp
  · intro a ha
    simp only [Finset.mem_filter] at ha
    rw [sub_add_single ha.2]

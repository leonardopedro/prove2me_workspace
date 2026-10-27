-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.sum_cube_split
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_mem_cube
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
theorem solution (d N : ℕ) (i : Fin d) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ cube d N, F a = ∑ a ∈ inn d N i, F a + ∑ a ∈ face d N i, F a := by

  classical
  rw [inn, face, ← Finset.sum_filter_add_sum_filter_not (cube d N) (fun a => a i < N) F]
  congr 1
  refine Finset.sum_congr ?_ fun _ _ => rfl
  ext a
  simp only [Finset.mem_filter, mem_cube]
  constructor
  · rintro ⟨h1, h2⟩; exact ⟨h1, by have := h1 i; omega⟩
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩

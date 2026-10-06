-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.shifted_faces_le
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_mem_face
import Theorems.Thm_BookProof_HermiteCarleman_sum_range_of_disjoint
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
variable {u : (Fin d →₀ ℕ) → ℂ} {lam : (Fin d →₀ ℕ) → ℝ} {amp : Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (i : Fin d) (M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ face d N i, ‖u (a + Finsupp.single i 1)‖ ^ 2 ≤ B := by

  classical
  have hinj : ∀ N : ℕ, ∑ a ∈ face d N i, ‖u (a + Finsupp.single i 1)‖ ^ 2
      = ∑ b ∈ (face d N i).image (fun a => a + Finsupp.single i 1), ‖u b‖ ^ 2 := by
    intro N
    rw [Finset.sum_image]
    intro x _ y _ hxy
    exact add_right_cancel hxy
  simp_rw [hinj]
  refine sum_range_of_disjoint hbes
    (fun N => (face d N i).image (fun a => a + Finsupp.single i 1)) (fun M N hMN => ?_) M
  rw [Finset.disjoint_left]
  intro b hbM hbN
  rw [Finset.mem_image] at hbM hbN
  obtain ⟨x, hx, rfl⟩ := hbM
  obtain ⟨y, hy, hxy⟩ := hbN
  rw [mem_face] at hx hy
  have hxyi : x i = y i := by
    have h := congrArg (fun f : Fin d →₀ ℕ => f i) hxy
    simp at h
    omega
  exact hMN (by rw [← hx.2, ← hy.2, hxyi])

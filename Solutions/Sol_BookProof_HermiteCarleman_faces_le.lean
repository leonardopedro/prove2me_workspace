-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.faces_le
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
    ∑ N ∈ Finset.range M, ∑ a ∈ face d N i, ‖u a‖ ^ 2 ≤ B := by

  refine sum_range_of_disjoint hbes (fun N => face d N i) (fun M N hMN => ?_) M
  rw [Finset.disjoint_left]
  intro a haM haN
  rw [mem_face] at haM haN
  exact hMN (haM.2 ▸ haN.2 ▸ rfl)

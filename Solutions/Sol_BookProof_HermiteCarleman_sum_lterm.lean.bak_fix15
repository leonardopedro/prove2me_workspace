-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.sum_lterm
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_sum_shift
import Theorems.Thm_BookProof_HermiteCarleman_lterm_shift
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
theorem solution (N : ℕ) (i : Fin d) :
    ∑ a ∈ cube d N, lterm u amp i a
      = (starRingEnd ℂ) (∑ a ∈ inn d N i, rterm u amp i a) := by

  rw [sum_shift d N i (lterm u amp i) (fun a ha => by rw [lterm, ha]; simp), map_sum]
  exact Finset.sum_congr rfl fun b _ => lterm_shift i b

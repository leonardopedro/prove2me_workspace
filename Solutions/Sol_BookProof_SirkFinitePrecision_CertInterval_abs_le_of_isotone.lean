-- Generated from ChapterSirkFinitePrecision.lean — solution of BookProof.SirkFinitePrecision.CertInterval.abs_le_of_isotone
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval







noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {α : Type*} (f : α → ℝ) (S : Set α) (I : CertInterval)
    (hF : ∀ z ∈ S, I.Mem (f z)) (R : ℝ) (hR : max |I.lo| |I.hi| ≤ R) {z : α} (hz : z ∈ S) :
    |f z| ≤ R := by

  have h := hF z hz
  have h1 : |I.lo| ≤ R := le_trans (le_max_left _ _) hR
  have h2 : |I.hi| ≤ R := le_trans (le_max_right _ _) hR
  rw [abs_le]
  exact ⟨by linarith [neg_abs_le I.lo, h.1], by linarith [le_abs_self I.hi, h.2]⟩

-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.diagOp_add_one_surjective
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {d : Finset (Fin n) → ℝ} (hd : ∀ S, 1 ≤ d S)
    (f : FermiFock n) : ∃ ψ : FermiFock n, diagOp d ψ + ψ = f := by

  refine ⟨WithLp.toLp 2 (fun S => f S / ((d S : ℂ) + 1)), ?_⟩
  ext S
  have hne : ((d S : ℂ) + 1) ≠ 0 := by
    have h1 : (0:ℝ) < d S + 1 := by linarith [hd S]
    intro hzero
    have : ((d S + 1 : ℝ) : ℂ) = 0 := by push_cast; simpa using hzero
    exact absurd (Complex.ofReal_eq_zero.mp this) (ne_of_gt h1)
  have : (d S : ℂ) * (f S / ((d S : ℂ) + 1)) + f S / ((d S : ℂ) + 1) = f S := by
    field_simp
  simpa using this

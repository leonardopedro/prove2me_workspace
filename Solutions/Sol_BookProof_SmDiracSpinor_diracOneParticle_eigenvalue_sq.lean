-- Generated from ChapterSmDiracSpinor.lean — solution of BookProof.SmDiracSpinor.diracOneParticle_eigenvalue_sq
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Theorems.Thm_BookProof_SmDiracSpinor_diracOneParticle_sq
open BookProof.SmDiracSpinor




open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {v : Fin 4 → ℂ} {mu : ℂ} (hv : v ≠ 0)
    (heig : (diracOneParticle k m1 m2).mulVec v = mu • v) :
    mu ^ 2 = (∑ j : Fin 3, (k j : ℂ) ^ 2) + (m1 : ℂ) ^ 2 + (m2 : ℂ) ^ 2 := by

  set E : ℂ := (∑ j : Fin 3, (k j : ℂ) ^ 2) + (m1 : ℂ) ^ 2 + (m2 : ℂ) ^ 2 with hE
  have h1 : (diracOneParticle k m1 m2 * diracOneParticle k m1 m2).mulVec v = E • v := by
    rw [diracOneParticle_sq, Matrix.smul_mulVec, Matrix.one_mulVec]
  have h2 : (diracOneParticle k m1 m2 * diracOneParticle k m1 m2).mulVec v = (mu ^ 2) • v := by
    rw [← Matrix.mulVec_mulVec, heig, Matrix.mulVec_smul, heig, smul_smul, sq]
  have h3 : (mu ^ 2 - E) • v = 0 := by
    rw [sub_smul, ← h2, h1, sub_self]
  rcases smul_eq_zero.mp h3 with h | h
  · exact sub_eq_zero.mp h
  · exact absurd h hv

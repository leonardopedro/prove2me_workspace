-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.fermiBilin_add
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin n) (Fin n) ℂ) :
    fermiBilin (A + B) = fermiBilin A + fermiBilin B := by

  simp only [fermiBilin, Matrix.add_apply, add_smul]
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib

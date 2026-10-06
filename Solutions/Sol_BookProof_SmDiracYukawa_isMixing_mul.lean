-- Generated from ChapterSmDiracYukawa.lean — solution of BookProof.SmDiracYukawa.isMixing_mul
import Mathlib
import Definitions.Def_ChapterSmDiracYukawa
open BookProof.SmDiracYukawa




open Finset Matrix
open BookProof.SmCar BookProof.FarisLavine

variable {n : ℕ}

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A B : Matrix (Fin 3) (Fin 3) ℂ} (hA : IsMixing A) (hB : IsMixing B) :
    IsMixing (A * B.conjTranspose) := by

  unfold IsMixing
  rw [Matrix.conjTranspose_mul, Matrix.conjTranspose_conjTranspose, Matrix.mul_assoc,
    ← Matrix.mul_assoc B.conjTranspose B A.conjTranspose, hB.conjTranspose_mul,
    Matrix.one_mul]
  exact hA

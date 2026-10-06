-- Generated from ChapterCPTHamiltonian.lean — solution of BookProof.ChapterCPTHamiltonian.castMat_conjTranspose
import Mathlib
import Definitions.Def_ChapterCPTHamiltonian
open BookProof.ChapterCPTHamiltonian



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 4) (Fin 4) ℤ) :
    ((Int.castRingHom ℂ).mapMatrix M)ᴴ = (Int.castRingHom ℂ).mapMatrix Mᵀ := by

  ext i j
  simp [RingHom.mapMatrix_apply, Matrix.map_apply, Matrix.conjTranspose_apply,
    Matrix.transpose_apply]

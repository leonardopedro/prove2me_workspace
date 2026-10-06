-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.hasLambda_of_intModel
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_castMat_neg_one
import Theorems.Thm_BookProof_ChapterA3_inv_of_sq_neg_one
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (Sz Λz : Matrix (Fin 4) (Fin 4) ℤ)
    (hSS : Sz * Sz = -1)
    (hconj : ∀ μ, -Sz * mgammaZ μ * Sz = ∑ ν, Λz μ ν • mgammaZ ν) :
    HasLambda ((Int.castRingHom ℝ).mapMatrix Sz)
      ((Int.castRingHom ℝ).mapMatrix Λz) := by

  intro μ
  have hSSr : (Int.castRingHom ℝ).mapMatrix Sz * (Int.castRingHom ℝ).mapMatrix Sz = -1 := by
    rw [← map_mul, hSS, castMat_neg_one]
  have hinv : ((Int.castRingHom ℝ).mapMatrix Sz)⁻¹ = -((Int.castRingHom ℝ).mapMatrix Sz) :=
    inv_of_sq_neg_one hSSr
  rw [hinv]
  have hmg : mgammaR μ = (Int.castRingHom ℝ).mapMatrix (mgammaZ μ) := rfl
  have hL : -((Int.castRingHom ℝ).mapMatrix Sz) * mgammaR μ * (Int.castRingHom ℝ).mapMatrix Sz
      = (Int.castRingHom ℝ).mapMatrix (-Sz * mgammaZ μ * Sz) := by
    rw [hmg]; simp only [map_mul, map_neg]
  rw [hL, hconj μ, map_sum]
  apply Finset.sum_congr rfl
  intro ν _
  have hcast : ((Int.castRingHom ℝ).mapMatrix Λz) μ ν = ((Λz μ ν : ℤ) : ℝ) := by
    simp [RingHom.mapMatrix_apply, Matrix.map_apply]
  rw [hcast, map_zsmul, Int.cast_smul_eq_zsmul]
  rfl

-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.hasAdLambda_smul
import Mathlib
import Definitions.Def_ChapterA3e
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {G A : Matrix (Fin 4) (Fin 4) ℝ} (c : ℝ)
    (h : HasAdLambda G A) : HasAdLambda (c • G) (c • A) := by

  intro μ
  have := h μ
  simp only [Matrix.smul_mul, Matrix.mul_smul, Matrix.smul_apply, smul_eq_mul]
  rw [show ∑ ν, (c * A μ ν) • mgammaR ν = c • ∑ ν, A μ ν • mgammaR ν from ?_]
  · rw [← h μ, smul_sub]
  · rw [Finset.smul_sum]
    exact Finset.sum_congr rfl fun ν _ => by rw [smul_smul]

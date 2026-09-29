-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.det_one_add_smul_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin 3) (Fin 3) ℝ) :
    HasDerivAt (fun t : ℝ => (1 + t • A).det) A.trace 0 := by

  have h : ∀ t : ℝ, (1 + t • A).det
      = 1 + t * A.trace
        + t ^ 2 * (A 0 0 * A 1 1 - A 0 1 * A 1 0 + A 0 0 * A 2 2 - A 0 2 * A 2 0
            + A 1 1 * A 2 2 - A 1 2 * A 2 1)
        + t ^ 3 * A.det := by
    intro t
    simp [Matrix.det_fin_three, Matrix.trace_fin_three]
    ring
  simp only [h]
  have h1 : HasDerivAt
      (fun t : ℝ => 1 + t * A.trace
        + t ^ 2 * (A 0 0 * A 1 1 - A 0 1 * A 1 0 + A 0 0 * A 2 2 - A 0 2 * A 2 0
            + A 1 1 * A 2 2 - A 1 2 * A 2 1)
        + t ^ 3 * A.det)
      (0 + 1 * A.trace + ((2 : ℕ) * 0 ^ ((2 : ℕ) - 1)) * (A 0 0 * A 1 1 - A 0 1 * A 1 0
          + A 0 0 * A 2 2 - A 0 2 * A 2 0 + A 1 1 * A 2 2 - A 1 2 * A 2 1)
        + ((3 : ℕ) * 0 ^ ((3 : ℕ) - 1)) * A.det) 0 :=
    (((hasDerivAt_const (0 : ℝ) (1 : ℝ)).add ((hasDerivAt_id (0 : ℝ)).mul_const A.trace)).add
        ((hasDerivAt_pow 2 (0 : ℝ)).mul_const _)).add ((hasDerivAt_pow 3 (0 : ℝ)).mul_const A.det)
  simpa using h1

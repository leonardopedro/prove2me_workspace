import Mathlib

/-!
# Chapter — Euler's formula for the 2-state density matrix

Formalization of the *density-matrix* identity in `book.tex`, chapter
*"Wave-function collapse versus Euler's formula"*, §*"Euler's formula for the
probability clock"* (`book.tex` line ~3300).  For the 2-state probability clock
with wave function `Ψ(t) = (cos t, sin t)`, the book writes the density matrix
`Ψ Ψ†` as a *multi-dimensional Euler's formula*:

> `Ψ Ψ† = [[cos²t, cos t sin t], [cos t sin t, sin²t]]`
>        `= ½·I + [[½,0],[0,-½]]·(cos 2t + J sin 2t)`,
>   where `J = [[0,1],[-1,0]]` plays the role of the imaginary unit,

and the *collapse* of the wave function is "setting the off-diagonal part
(i.e. the part proportional to `J`) of the original density matrix to zero",
producing the classical probability distribution on the diagonal
`[[cos²t,0],[0,sin²t]]`.

This module complements `BookProof.ChapterE` (which proves the *collapsed*
diagonal identity `collapse_density`) by formalizing the *full pre-collapse
density matrix* in Euler form, the fact that `J² = -1`, and the standard
density-matrix properties (unit trace, symmetry, and purity/idempotency).

All results are `sorry`-free and `axiom`-clean (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped Matrix

namespace BookProof.ChapterEulerDensityMatrix

/-- The 2-state clock wave function `Ψ(t) = (cos t, sin t)`. -/
noncomputable def clockPsi (t : ℝ) : Fin 2 → ℝ := ![Real.cos t, Real.sin t]

/-- The density matrix `ρ(t) = Ψ Ψᵀ` (the outer product of the wave function
with itself). -/
noncomputable def densityMatrix (t : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  Matrix.vecMulVec (clockPsi t) (clockPsi t)

/-- The matrix `J = [[0,1],[-1,0]]` that plays the role of the imaginary unit
in Euler's formula for the density matrix. -/
def Jdens : Matrix (Fin 2) (Fin 2) ℝ := !![0, 1; -1, 0]

/-- The diagonal generator `Z = [[½,0],[0,-½]]`. -/
noncomputable def Zdiag : Matrix (Fin 2) (Fin 2) ℝ := !![1 / 2, 0; 0, -1 / 2]

/-- The wave function is a unit vector: `Ψ·Ψ = cos²t + sin²t = 1`. -/
theorem clockPsi_normSq (t : ℝ) : clockPsi t ⬝ᵥ clockPsi t = 1 := by
  simp only [clockPsi, dotProduct, Fin.sum_univ_two, Matrix.cons_val_zero,
    Matrix.cons_val_one]
  nlinarith [Real.sin_sq_add_cos_sq t]

/-- The density matrix written out explicitly:
`ρ(t) = [[cos²t, cos t sin t], [cos t sin t, sin²t]]`. -/
theorem densityMatrix_eq (t : ℝ) :
    densityMatrix t =
      !![Real.cos t ^ 2, Real.cos t * Real.sin t;
         Real.cos t * Real.sin t, Real.sin t ^ 2] := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [densityMatrix, clockPsi, Matrix.vecMulVec_apply] <;> ring

/-- The `(0,0)` entry is the Born probability `cos²t` of the first state. -/
theorem densityMatrix_apply_zero (t : ℝ) : densityMatrix t 0 0 = Real.cos t ^ 2 := by
  rw [densityMatrix_eq]; simp

/-- The `(1,1)` entry is the Born probability `sin²t` of the second state. -/
theorem densityMatrix_apply_one (t : ℝ) : densityMatrix t 1 1 = Real.sin t ^ 2 := by
  rw [densityMatrix_eq]; simp

/-- `J` squares to `-1`: it plays the role of the imaginary unit. -/
theorem Jdens_sq : Jdens * Jdens = -1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Jdens, Matrix.mul_apply, Fin.sum_univ_two]

/-- Auxiliary evaluation of the Euler-form right-hand side. -/
theorem euler_rhs (t : ℝ) :
    (1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
        + Zdiag * ((Real.cos (2 * t)) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
            + (Real.sin (2 * t)) • Jdens)
      = !![1 / 2 + Real.cos (2 * t) / 2, Real.sin (2 * t) / 2;
           Real.sin (2 * t) / 2, 1 / 2 - Real.cos (2 * t) / 2] := by
  have hM : (Real.cos (2 * t)) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
        + (Real.sin (2 * t)) • Jdens
      = !![Real.cos (2 * t), Real.sin (2 * t); -Real.sin (2 * t), Real.cos (2 * t)] := by
    rw [Matrix.one_fin_two]; ext i j; fin_cases i <;> fin_cases j <;> simp [Jdens]
  have h1 : (1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ) = !![1 / 2, 0; 0, 1 / 2] := by
    rw [Matrix.one_fin_two]; ext i j; fin_cases i <;> fin_cases j <;> simp
  rw [hM, h1, show Zdiag = !![1 / 2, 0; 0, -1 / 2] from rfl, Matrix.mul_fin_two]
  ext i j; fin_cases i <;> fin_cases j <;> simp <;> ring

/-- **Euler's formula for the density matrix.**
`ρ(t) = ½·I + Z·(cos 2t·I + sin 2t·J)`, the "complex number" `cos 2t + J sin 2t`
scaled by the diagonal generator `Z`. -/
theorem density_euler (t : ℝ) :
    densityMatrix t =
      (1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
        + Zdiag * ((Real.cos (2 * t)) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
            + (Real.sin (2 * t)) • Jdens) := by
  rw [densityMatrix_eq, euler_rhs]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Real.cos_two_mul, Real.sin_two_mul, Real.sin_sq] <;> ring

/-- **Collapse of the wave function.**  Removing the `J`-proportional part
`sin 2t · (Z·J)` from the density matrix yields exactly the classical
probability distribution on the diagonal `[[cos²t,0],[0,sin²t]]` — the book's
"setting the off-diagonal part to zero". -/
theorem density_collapse (t : ℝ) :
    densityMatrix t - (Real.sin (2 * t)) • (Zdiag * Jdens)
      = !![Real.cos t ^ 2, 0; 0, Real.sin t ^ 2] := by
  rw [densityMatrix_eq, show Zdiag = !![1 / 2, 0; 0, -1 / 2] from rfl, Jdens,
    Matrix.mul_fin_two]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [Real.sin_two_mul] <;> ring

/-- The density matrix has unit trace (probabilities sum to `1`). -/
theorem densityMatrix_trace (t : ℝ) : Matrix.trace (densityMatrix t) = 1 := by
  simp [densityMatrix_eq, Matrix.trace, Matrix.diag, Fin.sum_univ_two]

/-- The density matrix is symmetric (`ρᵀ = ρ`). -/
theorem densityMatrix_symm (t : ℝ) : (densityMatrix t)ᵀ = densityMatrix t := by
  rw [densityMatrix_eq]; ext i j; fin_cases i <;> fin_cases j <;> simp

/-- The density matrix is idempotent (`ρ² = ρ`): the clock state is a *pure*
state. -/
theorem densityMatrix_idempotent (t : ℝ) :
    densityMatrix t * densityMatrix t = densityMatrix t := by
  rw [densityMatrix_eq]
  have h := Real.sin_sq_add_cos_sq t
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
  · linear_combination (Real.cos t ^ 2) * h
  · linear_combination (Real.cos t * Real.sin t) * h
  · linear_combination (Real.cos t * Real.sin t) * h
  · linear_combination (Real.sin t ^ 2) * h

end BookProof.ChapterEulerDensityMatrix

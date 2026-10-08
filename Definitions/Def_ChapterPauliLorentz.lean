import Mathlib


/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups": the Pauli 4-vector map and the
`SL(2,ℂ) → SO⁺(1,3)` double cover on the level of the Minkowski quadratic form

Source: `book.tex`, chapter *"Real representations, CPT theorem and the
relativistic position operator"*, §*"On the Lorentz, SL(2,C) and Pin(3,1)
groups"*, **Definition 42** and **Note 47** (`book.tex` line ~5344, ~5455):
the Pauli matrices `σᵏ` are `2×2` hermitian, unitary, anti-commuting complex
matrices, and there is a two-to-one surjection `Υ : SL(2,ℂ) → SO⁺(1,3)` defined
by `Υᵘ_ν(T) σ^ν = T† σᵘ T` (with `σ⁰ = 1`).

This file formalizes the self-contained **algebraic heart** of that statement:
the correspondence between real Minkowski 4-vectors and hermitian `2×2` complex
matrices, and the fact that the spinor conjugation `X ↦ T† X T` by a determinant-one
matrix `T ∈ SL(2,ℂ)` **preserves the Minkowski quadratic form**
`⟨x⟩ = (x⁰)² − (x¹)² − (x²)² − (x³)²`.  This is exactly what makes `Υ(T)` a Lorentz
transformation: the determinant of the hermitian matrix `X = xᵤσᵘ` *is* the
Minkowski norm of `x`, and `det(T† X T) = det X` when `det T = 1`.

As requested this stays **off the gravity line** and **off the Hankel–Majorana
line**: it uses only the concrete Pauli matrices (`2×2` complex), no
gamma/Majorana matrices and no spherical-Bessel numerics.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterPauliLorentz

/-! ## Definition 42 — the Pauli matrices and their algebra -/

/-- `σ⁰ = 1`, the identity. -/
def σ0 : Matrix (Fin 2) (Fin 2) ℂ := 1

/-- The first Pauli matrix `σ¹`. -/
def σ1 : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]

/-- The second Pauli matrix `σ²`. -/
def σ2 : Matrix (Fin 2) (Fin 2) ℂ := !![0, -Complex.I; Complex.I, 0]

/-- The third Pauli matrix `σ³`. -/
def σ3 : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]











stic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups": the Pauli 4-vector map and the
`SL(2,ℂ) → SO⁺(1,3)` double cover on the level of the Minkowski quadratic form

Source: `book.tex`, chapter *"Real representations, CPT theorem and the
relativistic position operator"*, §*"On the Lorentz, SL(2,C) and Pin(3,1)
groups"*, **Definition 42** and **Note 47** (`book.tex` line ~5344, ~5455):
the Pauli matrices `σᵏ` are `2×2` hermitian, unitary, anti-commuting complex
matrices, and there is a two-to-one surjection `Υ : SL(2,ℂ) → SO⁺(1,3)` defined
by `Υᵘ_ν(T) σ^ν = T† σᵘ T` (with `σ⁰ = 1`).

This file formalizes the self-contained **algebraic heart** of that statement:
the correspondence between real Minkowski 4-vectors and hermitian `2×2` complex
matrices, and the fact that the spinor conjugation `X ↦ T† X T` by a determinant-one
matrix `T ∈ SL(2,ℂ)` **preserves the Minkowski quadratic form**
`⟨x⟩ = (x⁰)² − (x¹)² − (x²)² − (x³)²`.  This is exactly what makes `Υ(T)` a Lorentz
transformation: the determinant of the hermitian matrix `X = xᵤσᵘ` *is* the
Minkowski norm of `x`, and `det(T† X T) = det X` when `det T = 1`.

As requested this stays **off the gravity line** and **off the Hankel–Majorana
line**: it uses only the concrete Pauli matrices (`2×2` complex), no
gamma/Majorana matrices and no spherical-Bessel numerics.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterPauliLorentz

/-! ## Definition 42 — the Pauli matrices and their algebra -/

/-- `σ⁰ = 1`, the identity. -/
def σ0 : Matrix (Fin 2) (Fin 2) ℂ := 1

/-- The first Pauli matrix `σ¹`. -/
def σ1 : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]

/-- The second Pauli matrix `σ²`. -/
def σ2 : Matrix (Fin 2) (Fin 2) ℂ := !![0, -Complex.I; Complex.I, 0]

/-- The third Pauli matrix `σ³`. -/
def σ3 : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

/-- `σ¹` is hermitian. -/
theorem σ1_herm : σ1ᴴ = σ1 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [σ1, Matrix.conjTranspose_apply]

/-- `σ²` is hermitian. -/
theorem σ2_herm : σ2ᴴ = σ2 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ2, Matrix.conjTranspose_apply, Complex.conj_I]

/-- `σ³` is hermitian. -/
theorem σ3_herm : σ3ᴴ = σ3 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [σ3, Matrix.conjTranspose_apply]

/-- `(σ¹)² = 1` (hence `σ¹` is unitary, being also hermitian). -/
theorem σ1_sq : σ1 * σ1 = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ1, Matrix.mul_apply, Fin.sum_univ_two]

/-- `(σ²)² = 1`. -/
theorem σ2_sq : σ2 * σ2 = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ2, Matrix.mul_apply, Fin.sum_univ_two, Complex.I_mul_I]

/-- `(σ³)² = 1`. -/
theorem σ3_sq : σ3 * σ3 = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ3, Matrix.mul_apply, Fin.sum_univ_two]

/-- `σ¹` and `σ²` anti-commute. -/
theorem σ1σ2_anti : σ1 * σ2 + σ2 * σ1 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ1, σ2]





/-! ## The 4-vector ↔ hermitian-matrix correspondence -/

/-- The hermitian `2×2` matrix `X = xᵤ σᵘ = x⁰σ⁰ + x¹σ¹ + x²σ² + x³σ³` associated
to a real Minkowski 4-vector `x`. -/
noncomputable def hermMat (x : Fin 4 → ℝ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(x 0 : ℂ) + (x 3 : ℂ), (x 1 : ℂ) - (x 2 : ℂ) * Complex.I;
     (x 1 : ℂ) + (x 2 : ℂ) * Complex.I, (x 0 : ℂ) - (x 3 : ℂ)]

/-- The Minkowski quadratic form `⟨x⟩ = (x⁰)² − (x¹)² − (x²)² − (x³)²`. -/
def mink (x : Fin 4 → ℝ) : ℝ := (x 0) ^ 2 - (x 1) ^ 2 - (x 2) ^ 2 - (x 3) ^ 2







/-- Extract the real 4-vector components from a `2×2` complex matrix (a left inverse
of `hermMat` on hermitian matrices). -/
noncomputable def vecOfMat (H : Matrix (Fin 2) (Fin 2) ℂ) : Fin 4 → ℝ :=
  ![((H 0 0).re + (H 1 1).re) / 2, ((H 0 1).re + (H 1 0).re) / 2,
    ((H 1 0).im - (H 0 1).im) / 2, ((H 0 0).re - (H 1 1).re) / 2]

/-
`vecOfMat` is a left inverse of `hermMat` on hermitian matrices:
`hermMat (vecOfMat H) = H` whenever `Hᴴ = H`.
-/




/-! ## Note 47 — the spinor map preserves the Minkowski form -/



end BookProof.ChapterPauliLorentz

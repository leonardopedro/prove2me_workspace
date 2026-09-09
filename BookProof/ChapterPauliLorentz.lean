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

/-- `σ²` and `σ³` anti-commute. -/
theorem σ2σ3_anti : σ2 * σ3 + σ3 * σ2 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ2, σ3]

/-- `σ¹` and `σ³` anti-commute. -/
theorem σ1σ3_anti : σ1 * σ3 + σ3 * σ1 = 0 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ1, σ3]

/-! ## The 4-vector ↔ hermitian-matrix correspondence -/

/-- The hermitian `2×2` matrix `X = xᵤ σᵘ = x⁰σ⁰ + x¹σ¹ + x²σ² + x³σ³` associated
to a real Minkowski 4-vector `x`. -/
noncomputable def hermMat (x : Fin 4 → ℝ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(x 0 : ℂ) + (x 3 : ℂ), (x 1 : ℂ) - (x 2 : ℂ) * Complex.I;
     (x 1 : ℂ) + (x 2 : ℂ) * Complex.I, (x 0 : ℂ) - (x 3 : ℂ)]

/-- The Minkowski quadratic form `⟨x⟩ = (x⁰)² − (x¹)² − (x²)² − (x³)²`. -/
def mink (x : Fin 4 → ℝ) : ℝ := (x 0) ^ 2 - (x 1) ^ 2 - (x 2) ^ 2 - (x 3) ^ 2

/-- `hermMat x` is the Pauli expansion `x⁰σ⁰ + x¹σ¹ + x²σ² + x³σ³`. -/
theorem hermMat_eq_pauli (x : Fin 4 → ℝ) :
    hermMat x = (x 0 : ℂ) • σ0 + (x 1 : ℂ) • σ1 + (x 2 : ℂ) • σ2 + (x 3 : ℂ) • σ3 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [hermMat, σ0, σ1, σ2, σ3] <;> ring

/-- `hermMat x` is hermitian. -/
theorem hermMat_isHermitian (x : Fin 4 → ℝ) : (hermMat x)ᴴ = hermMat x := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [hermMat, Matrix.conjTranspose_apply, Complex.conj_I] ; ring

/-- **The key determinant identity:** the determinant of the hermitian matrix
`X = xᵤσᵘ` equals the Minkowski norm of `x`. -/
theorem det_hermMat (x : Fin 4 → ℝ) : (hermMat x).det = (mink x : ℂ) := by
  simp only [hermMat, Matrix.det_fin_two, Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.empty_val', Matrix.cons_val_fin_one, mink]
  push_cast
  linear_combination (x 2 : ℂ) ^ 2 * Complex.I_sq

/-- Extract the real 4-vector components from a `2×2` complex matrix (a left inverse
of `hermMat` on hermitian matrices). -/
noncomputable def vecOfMat (H : Matrix (Fin 2) (Fin 2) ℂ) : Fin 4 → ℝ :=
  ![((H 0 0).re + (H 1 1).re) / 2, ((H 0 1).re + (H 1 0).re) / 2,
    ((H 1 0).im - (H 0 1).im) / 2, ((H 0 0).re - (H 1 1).re) / 2]

/-
`vecOfMat` is a left inverse of `hermMat` on hermitian matrices:
`hermMat (vecOfMat H) = H` whenever `Hᴴ = H`.
-/
theorem hermMat_vecOfMat {H : Matrix (Fin 2) (Fin 2) ℂ} (hH : Hᴴ = H) :
    hermMat (vecOfMat H) = H := by
  unfold hermMat vecOfMat;
  ext i j; fin_cases i <;> fin_cases j <;> simp [ Complex.ext_iff ];
  · exact ⟨ by ring, by
    have := congr_fun ( congr_fun hH 0 ) 0; norm_num [ Complex.ext_iff ] at this; linarith ⟩;
  · have := congr_fun ( congr_fun hH 1 ) 0;    norm_num [ Complex.ext_iff ] at this; constructor <;>
      linarith;
  · have := congr_fun ( congr_fun hH 0 ) 1;    norm_num [ Complex.ext_iff ] at this; constructor <;>
      linarith;
  · have := congr_fun ( congr_fun hH 1 ) 1;    norm_num [ Complex.ext_iff ] at this; constructor <;>
      linarith;

/-- `hermMat` is injective on 4-vectors: `X = xᵤσᵘ` determines `x` on its four
components.  Together with `hermMat_vecOfMat` this exhibits the real-linear
bijection between Minkowski 4-vectors and hermitian `2×2` complex matrices. -/
theorem hermMat_injective {x y : Fin 4 → ℝ} (h : hermMat x = hermMat y) :
    x 0 = y 0 ∧ x 1 = y 1 ∧ x 2 = y 2 ∧ x 3 = y 3 := by
  have h00 := congrFun (congrFun h 0) 0
  have h11 := congrFun (congrFun h 1) 1
  have h01 := congrFun (congrFun h 0) 1
  simp only [hermMat, Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.empty_val', Matrix.cons_val_fin_one] at h00 h11 h01
  rw [Complex.ext_iff] at h00 h11 h01
  simp only [Complex.add_re, Complex.add_im, Complex.sub_re, Complex.sub_im, Complex.mul_re,
    Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
    at h00 h11 h01
  exact ⟨by linarith [h00.1, h11.1], by linarith [h01.1], by linarith [h01.2],
    by linarith [h00.1, h11.1]⟩

/-! ## Note 47 — the spinor map preserves the Minkowski form -/

/-- **Note 47 (algebraic core).**  For `T ∈ SL(2,ℂ)` (i.e. `det T = 1`) and any real
Minkowski 4-vector `x`, the spinor conjugation `X ↦ T† X T` maps the hermitian
matrix `X = xᵤσᵘ` to another hermitian matrix `T† X T = yᵤσᵘ` whose 4-vector `y`
has the **same Minkowski norm** as `x`.  This is precisely why the induced map
`Υ(T)` is a Lorentz transformation. -/
theorem spinorMap_preserves_mink (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1)
    (x : Fin 4 → ℝ) :
    mink (vecOfMat (Tᴴ * hermMat x * T)) = mink x := by
  set H := Tᴴ * hermMat x * T with hHdef
  have hHerm : Hᴴ = H := by
    rw [hHdef, Matrix.conjTranspose_mul, Matrix.conjTranspose_mul,
      Matrix.conjTranspose_conjTranspose, hermMat_isHermitian, Matrix.mul_assoc]
  -- the transformed matrix is again `hermMat` of its extracted 4-vector
  have hrecon : hermMat (vecOfMat H) = H := hermMat_vecOfMat hHerm
  -- determinants agree
  have hdet : (hermMat (vecOfMat H)).det = (hermMat x).det := by
    rw [hrecon, hHdef, Matrix.det_mul, Matrix.det_mul, Matrix.det_conjTranspose, hT]
    simp
  rw [det_hermMat, det_hermMat] at hdet
  exact_mod_cast hdet

end BookProof.ChapterPauliLorentz

import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3b
import BookProof.ChapterA3c

/-!
# Chapter A, §A.3 — Note 47: the covering map `Υ : SL(2,ℂ) → O(1,3)`

This file formalizes **Note 47** of `FORMALIZATION_ROADMAP.md` (book §A.3,
line 5440), the `SL(2,ℂ)` side of **Lemma 48**.  The book defines a two-to-one
surjection `Υ : SL(2,ℂ) → SO⁺(1,3)` by
`Υ^μ_ν(T) σ^ν = T† σ^μ T`, where `σ⁰ = 1` and `σ^j` are the Pauli matrices.

We build the concrete `2×2` Pauli model and prove:

* `pauliσ_herm` — each `σ^μ` is Hermitian.
* `pauliσ_trace` — the trace-orthogonality `tr(σ^μ σ^ν) = 2 δ^{μν}`.
* `pauli_expand` — every `2×2` complex matrix is `∑_μ (½ tr(σ^μ M)) σ^μ`, so the
  four Pauli matrices are a basis of `Mat₂(ℂ)`.
* `UpsilonC` / `upsilon_recon` — the (complex) coefficient matrix `Υ(T)` with
  `T† σ^ν T = ∑_μ Υ(T)^μ_ν σ^μ`.
* `upsilonC_antihom` — `Υ(T U) = Υ(U) Υ(T)` (an anti-homomorphism, since
  `(TU)† = U† T†`; the book's "homomorphism" is this with the group law read on
  the image).
* `Upsilon` / `upsilonC_real` — the entries of `Υ(T)` are **real**, giving the
  real Lorentz matrix `Upsilon T`.
* `det_pauli_comb` — `det(∑_ν x_ν σ^ν) = x₀² − x₁² − x₂² − x₃²`, the Minkowski
  norm as a determinant (the geometric heart of the construction).
* `upsilon_mem_lorentz` — for `T ∈ SL(2,ℂ)` (`det T = 1`), `Υ(T) ∈ O(1,3)`.

`Σ` and the full Lemma-48 identity `Λ(S) = Υ(Σ⁻¹ S Σ)` (matching the
`γ⁰γ³`/`σ³` eigenspaces) remain future work; the group-level Lorentz image of
`Spin⁺(3,1)` is already covered via the exponential route in `ChapterA3g.lean`.
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterA3

/-! ## The Pauli matrices -/

/-- The four Pauli matrices `σ^μ`: `σ⁰ = 1` and the three Pauli matrices. -/
noncomputable def pauliσ : Fin 4 → Matrix (Fin 2) (Fin 2) ℂ
  | 0 => !![1,0;0,1]
  | 1 => !![0,1;1,0]
  | 2 => !![0,-Complex.I;Complex.I,0]
  | 3 => !![1,0;0,-1]

/-- Each Pauli matrix is Hermitian. -/
theorem pauliσ_herm (μ : Fin 4) : (pauliσ μ)ᴴ = pauliσ μ := by
  fin_cases μ <;>
    (ext i j; fin_cases i <;> fin_cases j <;>
      simp [pauliσ, Matrix.conjTranspose_apply])

/-- Trace orthogonality: `tr(σ^μ σ^ν) = 2 δ^{μν}`. -/
theorem pauliσ_trace (μ ν : Fin 4) :
    (pauliσ μ * pauliσ ν).trace = if μ = ν then 2 else 0 := by
  fin_cases μ <;> fin_cases ν <;>
    simp [pauliσ, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two, Matrix.diag] <;> ring_nf

/-- The Pauli coefficient functional `c_μ(M) = ½ tr(σ^μ M)`. -/
noncomputable def pauliCoeff (M : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) : ℂ :=
  2⁻¹ * (pauliσ μ * M).trace

/-- Every `2×2` complex matrix expands in the Pauli basis. -/
theorem pauli_expand (M : Matrix (Fin 2) (Fin 2) ℂ) :
    M = ∑ μ, pauliCoeff M μ • pauliσ μ := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliσ, pauliCoeff, Fin.sum_univ_four, Matrix.trace, Matrix.mul_apply,
      Fin.sum_univ_two, Matrix.diag, Matrix.add_apply] <;> ring_nf <;>
    (try simp only [Complex.I_sq]) <;> ring

/-
The Pauli coefficient of a Pauli combination recovers the coefficient.
-/
theorem pauliCoeff_comb (c : Fin 4 → ℂ) (μ : Fin 4) :
    pauliCoeff (∑ ν, c ν • pauliσ ν) μ = c μ := by
  unfold pauliCoeff;
  simp [ Matrix.mul_sum, Matrix.trace_sum, pauliσ_trace ];
  ring

/-! ## The map `Υ` -/

/-- The complex coefficient matrix `Υ(T)`, `Υ(T)^μ_ν = ½ tr(σ^μ T† σ^ν T)`. -/
noncomputable def UpsilonC (T : Matrix (Fin 2) (Fin 2) ℂ) :
    Matrix (Fin 4) (Fin 4) ℂ :=
  Matrix.of fun μ ν => pauliCoeff (Tᴴ * pauliσ ν * T) μ

/-
Reconstruction: `T† σ^ν T = ∑_μ Υ(T)^μ_ν σ^μ`.
-/
theorem upsilon_recon (T : Matrix (Fin 2) (Fin 2) ℂ) (ν : Fin 4) :
    Tᴴ * pauliσ ν * T = ∑ μ, UpsilonC T μ ν • pauliσ μ := by
  convert pauli_expand ( Tᴴ * pauliσ ν * T ) using 1

/-
`Υ` is an anti-homomorphism: `Υ(T U) = Υ(U) Υ(T)`.
-/
theorem upsilonC_antihom (T U : Matrix (Fin 2) (Fin 2) ℂ) :
    UpsilonC (T * U) = UpsilonC U * UpsilonC T := by
  ext μ ν; simp only [UpsilonC, conjTranspose_mul, of_apply, mul_apply] ;
  have h_expand : Tᴴ * pauliσ ν * T = ∑ x, pauliCoeff (Tᴴ * pauliσ ν * T) x • pauliσ x := by
    convert pauli_expand ( Tᴴ * pauliσ ν * T ) using 1;
  conv_lhs => rw [ show Uᴴ * Tᴴ * pauliσ ν * ( T * U ) = Uᴴ * ( Tᴴ * pauliσ ν * T ) * U
      by simp only [mul_assoc] ];
  conv_lhs => rw [ h_expand ];
  simp [ mul_assoc, mul_comm, mul_left_comm, Finset.mul_sum _ _ _, Finset.sum_mul, pauliCoeff ]

/-! ## Reality of `Υ` -/

/-
The entries of `Υ(T)` are real (fixed by complex conjugation).
-/
theorem upsilonC_real (T : Matrix (Fin 2) (Fin 2) ℂ) (μ ν : Fin 4) :
    conj (UpsilonC T μ ν) = UpsilonC T μ ν := by
  unfold UpsilonC pauliCoeff;
  field_simp;
  convert congr_arg ( fun x : ℂ => x / 2 ) ( show ( starRingEnd ℂ ) ( Matrix.trace ( pauliσ μ * ( Tᴴ
      * pauliσ ν * T ) ) ) = Matrix.trace ( pauliσ μ * ( Tᴴ * pauliσ ν * T ) ) from ?_ ) using 1;
  · norm_num [ Complex.ext_iff, div_eq_mul_inv ];
  · -- By the properties of the trace and the Hermitian nature of the Pauli matrices, we can show
    -- that the trace of the conjugate transpose is equal to the trace of the original matrix.
    have h_trace_conj : ∀ (M : Matrix (Fin 2) (Fin 2) ℂ),      (starRingEnd ℂ) (Matrix.trace M) =
        Matrix.trace (Mᴴ) := by
      simp [ Matrix.trace, Matrix.conjTranspose ];
    rw [ h_trace_conj, Matrix.conjTranspose_mul, Matrix.conjTranspose_mul, Matrix.conjTranspose_mul
        ];
    rw [ ← Matrix.trace_mul_comm ] ; simp [ Matrix.mul_assoc, pauliσ_herm ] ;

/-- The real Lorentz matrix `Υ(T)`. -/
noncomputable def Upsilon (T : Matrix (Fin 2) (Fin 2) ℂ) :
    Matrix (Fin 4) (Fin 4) ℝ :=
  Matrix.of fun μ ν => (UpsilonC T μ ν).re

/-
The complexification of the real `Υ(T)` is the complex `Υ(T)`.
-/
theorem toC_Upsilon (T : Matrix (Fin 2) (Fin 2) ℂ) :
    toC (Upsilon T) = UpsilonC T := by
  ext μ ν; simp only [toC, map_apply] ;
  exact Complex.conj_eq_iff_re.mp ( upsilonC_real T μ ν ) ▸ rfl

/-! ## The Minkowski norm as a determinant -/

/-- The Minkowski quadratic form `Q(x) = x₀² − x₁² − x₂² − x₃²`. -/
def Qc (x : Fin 4 → ℂ) : ℂ := (x 0)^2 - (x 1)^2 - (x 2)^2 - (x 3)^2

/-- `det(∑_ν x_ν σ^ν) = x₀² − x₁² − x₂² − x₃²`. -/
theorem det_pauli_comb (x : Fin 4 → ℂ) :
    (∑ μ, x μ • pauliσ μ).det = Qc x := by
  simp only [pauliσ, Fin.sum_univ_four, Matrix.det_fin_two, Matrix.add_apply, Matrix.smul_apply,
    Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.empty_val', Matrix.cons_val_fin_one, smul_eq_mul, Qc]
  ring_nf
  simp only [Complex.I_sq]
  ring

/-
Under `Υ(T)`, `T† (∑ x_ν σ^ν) T = ∑_μ (Υ(T) x)_μ σ^μ`.
-/
theorem upsilon_apply_comb (T : Matrix (Fin 2) (Fin 2) ℂ) (x : Fin 4 → ℂ) :
    Tᴴ * (∑ ν, x ν • pauliσ ν) * T = ∑ μ, (∑ ν, UpsilonC T μ ν * x ν) • pauliσ μ := by
  set v : Fin 4 → ℂ := fun ν => x ν;
  -- By definition of $U$, we know that $Tᴴ * pauliσ ν * T = ∑ μ, U μ ν • pauliσ μ$.
  have hU : ∀ ν, Tᴴ * pauliσ ν * T = ∑ μ, UpsilonC T μ ν • pauliσ μ := fun ν => upsilon_recon T ν
  convert congr_arg ( fun m => ∑ ν, v ν • m ν ) ( funext hU ) using 1;
  · simp [ Matrix.sum_mul, mul_assoc, Finset.mul_sum _ _ _ ];
    rfl;
  · simp only [mul_comm, Finset.sum_smul, Finset.smul_sum, smul_smul];
    exact Finset.sum_comm

/-
`Υ(T)` preserves the Minkowski form when `det T = 1`.
-/
theorem upsilonC_Qc (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) (x : Fin 4 → ℂ) :
    Qc (fun μ => ∑ ν, UpsilonC T μ ν * x ν) = Qc x := by
  rw [ ← det_pauli_comb, ← det_pauli_comb ];
  rw [ ← upsilon_apply_comb ];
  simp [ hT, Matrix.det_mul ]

/-! ## Polarization -/

/-- The bilinear form `x ↦ xᵀ M x` of a matrix. -/
noncomputable def bilC (M : Matrix (Fin 4) (Fin 4) ℂ) (x : Fin 4 → ℂ) : ℂ :=
  ∑ i, ∑ j, x i * M i j * x j

/-
**Polarization.** A symmetric `4×4` complex matrix is determined by its
quadratic form.
-/
theorem bilC_ext {A B : Matrix (Fin 4) (Fin 4) ℂ} (hA : Aᵀ = A) (hB : Bᵀ = B)
    (h : ∀ x : Fin 4 → ℂ, bilC A x = bilC B x) : A = B := by
  -- The quadratic form at the indicator of `{i, j}` is `M i i + M i j + M j i + M j j`.
  have expand : ∀ (M : Matrix (Fin 4) (Fin 4) ℂ) (i j : Fin 4),
      bilC M (fun k => if k = i ∨ k = j then 1 else 0)
        = (if i = j then M i i else M i i + M i j + M j i + M j j) := by
    intro M i j
    fin_cases i <;> fin_cases j <;> simp [bilC, Fin.sum_univ_four] <;> ring
  -- Specializing at `i = j` gives the diagonal entries.
  have h_diag (i : Fin 4) : A i i = B i i := by
    have hi := h (fun k => if k = i ∨ k = i then 1 else 0)
    rw [expand, expand] at hi
    simpa using hi
  -- Specializing at `i ≠ j` and using symmetry gives `2 * A i j = 2 * B i j`.
  have h_off_diag (i j : Fin 4) (hij : i ≠ j) : A i j = B i j := by
    have hh := h (fun k => if k = i ∨ k = j then 1 else 0)
    rw [expand, expand] at hh
    simp only [if_neg hij] at hh
    have hAij : A j i = A i j := congr_fun (congr_fun hA i) j
    have hBij : B j i = B i j := congr_fun (congr_fun hB i) j
    rw [hAij, hBij, h_diag i, h_diag j] at hh
    linear_combination hh / 2
  exact Matrix.ext fun i j => if hij : i = j then hij ▸ h_diag i else h_off_diag i j hij

/-
The bilinear form of the (complexified) Minkowski metric is `Qc`.
-/
theorem bilC_minkowski (x : Fin 4 → ℂ) : bilC (toC minkowskiMat) x = Qc x := by
  unfold bilC Qc toC minkowskiMat; simp only [map_apply, of_apply, Fin.sum_univ_four, Fin.isValue] ;
      ring;
  unfold minkowskiR; norm_num [ Fin.ext_iff, minkowskiZ ] ; ring;

/-
Conjugation identity `xᵀ (Aᵀ M A) x = (A x)ᵀ M (A x)`.
-/
theorem bilC_conj (A M : Matrix (Fin 4) (Fin 4) ℂ) (x : Fin 4 → ℂ) :
    bilC (Aᵀ * M * A) x = bilC M (fun i => ∑ j, A i j * x j) := by
  unfold bilC; simp [ Matrix.mul_apply, Fin.sum_univ_four ] ; ring!;

/-
`toC minkowskiMat` is symmetric.
-/
theorem toC_minkowski_symm : (toC minkowskiMat)ᵀ = toC minkowskiMat := by
  ext i j; simp only [toC, transpose_apply, map_apply, Complex.ofReal_inj] ;
  fin_cases i <;> fin_cases j <;> rfl

/-- The complex metric-preservation identity `Υ(T)ᵀ η Υ(T) = η`. -/
theorem upsilonC_metric (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) :
    (UpsilonC T)ᵀ * toC minkowskiMat * UpsilonC T = toC minkowskiMat := by
  apply bilC_ext
  · -- symmetry of the left side
    rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose,
      toC_minkowski_symm, ← Matrix.mul_assoc]
  · exact toC_minkowski_symm
  · intro x
    rw [bilC_conj, bilC_minkowski, bilC_minkowski, upsilonC_Qc T hT]

/-! ## `Υ(T) ∈ O(1,3)` -/

/-
The real metric-preservation identity `Υ(T)ᵀ η Υ(T) = η`.
-/
theorem upsilon_metric (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) :
    (Upsilon T)ᵀ * minkowskiMat * Upsilon T = minkowskiMat := by
  -- Apply the complex identity `upsilonC_metric` to conclude the proof.
  have := upsilonC_metric T hT;
  simp_all only [← ext_iff];
  convert this using 1;
  simp [ ← toC_Upsilon, Matrix.mul_apply ];
  simp [ toC ];
  norm_cast

/-
**Note 47.** For `T ∈ SL(2,ℂ)`, `Υ(T)` lands in the Lorentz group `O(1,3)`.
-/
theorem upsilon_mem_lorentz (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T.det = 1) :
    Upsilon T ∈ LorentzO := by
  -- From(Note 47, proof): `upsilon_metric T hT : Λᵀ * η * Λ = η`. Let `η := minkowskiMat`.
  set η := minkowskiMat
  have hη2 : η * η = 1 := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [η, minkowskiMat, minkowskiR, minkowskiZ, Matrix.mul_apply]
  have h : (Upsilon T)ᵀ * η * Upsilon T = η := upsilon_metric T hT
  generalize_proofs at *
  have h_mul : (η * (Upsilon T)ᵀ * η) * Upsilon T = 1 := by
    simp_all [Matrix.mul_assoc]
  have h_mul_comm : Upsilon T * (η * (Upsilon T)ᵀ * η) = 1 := by
    rw [← mul_eq_one_comm, h_mul]
  apply_fun (fun x => x * η) at h_mul_comm
  simp_all only [Matrix.mul_assoc, mul_one, one_mul]
  exact funext fun i => funext fun j => by
    simpa [Matrix.mul_assoc] using congr_fun (congr_fun h_mul_comm i) j

end BookProof.ChapterA3

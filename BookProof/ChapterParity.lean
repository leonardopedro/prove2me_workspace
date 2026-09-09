import Mathlib
import BookProof.ChapterA3

/-!
# Chapter "On the physical parity transformation and antiparticles" — the finite algebraic core

This file formalizes the self-contained, finite-dimensional algebraic content of the
`book.tex` chapter *"On the physical parity transformation and antiparticles"*
(`book.tex` line ~7522).  The chapter's central physical thesis — that at the quantum
level all fields are **real representations** (self-adjoint operators), so that CP and
P coincide and the (generalized) parity transformation is **order four** — rests on a
handful of concrete linear-algebra facts, which are what we discharge here.

The surrounding physical modelling (canonical quantization of a real Hilbert space, the
Standard-Model Lagrangian, path-integral measures) is left as prose.

Deliverable groups:

* **Hermitian decomposition of a field.** *"Any non-Hermitian field can always be
  decomposed into a sum of two Hermitian fields"* (Lee–Wick, quoted in the chapter):
  every square complex matrix `X` is `A + i B` with `A`, `B` Hermitian.
* **The Higgs (generalized) parity is order four.** The internal part of the Higgs
  parity transformation `φ ↦ i σ₂ φ` is `i σ₂`, which satisfies `(i σ₂)² = -1` and hence
  `(i σ₂)⁴ = 1` while `(i σ₂)² ≠ 1`: the parity is a genuine `ℤ₄` (order-4) symmetry.
* **The fermion parity operator `i γ⁰` is order four ⇒ the double cover is `Pin(3,1)`.**
  On Majorana spinors the parity acts through `i γ⁰ = mgamma 0` of the concrete `A3`
  model; `(i γ⁰)² = -1` (order four), in contrast to the naive Dirac `γ⁰` for which
  `(γ⁰)² = +1`.  This `-1` is exactly the invariant distinguishing `Pin(3,1)` from
  `Pin(1,3)`.
* **The Gell-Mann outer-automorphism signs.** The complex conjugation of the eight
  `SU(3)` Gell-Mann matrices realizes the `ℤ₂` outer automorphism with the sign pattern
  the chapter uses for the parity transformation of the gluon fields: the real
  generators (`λ¹, λ³, λ⁴, λ⁶, λ⁸`) are fixed and the imaginary ones (`λ², λ⁵, λ⁷`) are
  negated.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterParity

/-! ## 1. Hermitian decomposition of an arbitrary field -/

variable {n : Type*}

/-- The Hermitian part `A = ½ (X + Xᴴ)` of a field `X`. -/
noncomputable def hermPart (X : Matrix n n ℂ) : Matrix n n ℂ := (2 : ℂ)⁻¹ • (X + Xᴴ)

/-- The "imaginary" Hermitian part `B = (2i)⁻¹ (X − Xᴴ)`, so that `X = A + i B`. -/
noncomputable def antihermPart (X : Matrix n n ℂ) : Matrix n n ℂ :=
  (2 * Complex.I)⁻¹ • (X - Xᴴ)

/-- The Hermitian part is Hermitian. -/
theorem hermPart_isHermitian (X : Matrix n n ℂ) : (hermPart X).IsHermitian := by
  unfold Matrix.IsHermitian hermPart
  rw [conjTranspose_smul, conjTranspose_add, conjTranspose_conjTranspose]
  simp [add_comm]

/-- The imaginary Hermitian part is Hermitian. -/
theorem antihermPart_isHermitian (X : Matrix n n ℂ) : (antihermPart X).IsHermitian := by
  unfold Matrix.IsHermitian antihermPart
  rw [conjTranspose_smul, conjTranspose_sub, conjTranspose_conjTranspose,
      show (Xᴴ - X) = (-1 : ℂ) • (X - Xᴴ) by module, smul_smul]
  congr 1
  rw [star_inv₀]
  simp only [star_mul', Complex.star_def, map_ofNat, Complex.conj_I]
  have : (2 * Complex.I) ≠ 0 := by simp [Complex.I_ne_zero]
  field_simp

/-- **"Any non-Hermitian field can always be decomposed into a sum of two Hermitian
fields."**  Every square complex matrix is `A + i B` with `A`, `B` Hermitian. -/
theorem field_hermitian_decomp (X : Matrix n n ℂ) :
    X = hermPart X + Complex.I • antihermPart X := by
  unfold hermPart antihermPart
  rw [smul_smul]
  have hI : Complex.I * (2 * Complex.I)⁻¹ = (2 : ℂ)⁻¹ := by
    have : (2 * Complex.I) ≠ 0 := by simp [Complex.I_ne_zero]
    field_simp
  rw [hI, ← smul_add, show (X + Xᴴ) + (X - Xᴴ) = (2 : ℂ) • X by module, smul_smul]
  norm_num

/-! ## 2. The Higgs (generalized) parity `i σ₂` is order four -/

/-- The Pauli matrix `σ₂`. -/
noncomputable def pauli2 : Matrix (Fin 2) (Fin 2) ℂ := !![0, -Complex.I; Complex.I, 0]

/-- The internal part `i σ₂` of the Higgs (generalized) parity transformation
`φ ↦ i σ₂ φ`. -/
noncomputable def higgsParity : Matrix (Fin 2) (Fin 2) ℂ := Complex.I • pauli2

/-- `σ₂² = 1`. -/
theorem pauli2_sq : pauli2 * pauli2 = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [pauli2, Matrix.mul_apply, Fin.sum_univ_two, Complex.I_mul_I]

/-- `(i σ₂)² = -1`: squaring the Higgs parity gives `-1`. -/
theorem higgsParity_sq : higgsParity * higgsParity = -1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [higgsParity, pauli2, Matrix.mul_apply, Fin.sum_univ_two, Complex.I_mul_I]

/-- `(i σ₂)⁴ = 1`: the Higgs parity is order (at most) four. -/
theorem higgsParity_pow_four :
    higgsParity * higgsParity * (higgsParity * higgsParity) = 1 := by
  rw [higgsParity_sq]; simp

/-- The Higgs parity has order exactly four: `(i σ₂)² = -1 ≠ 1`, so it is not an
involution, while `(i σ₂)⁴ = 1`. -/
theorem higgsParity_order_four :
    higgsParity * higgsParity ≠ 1 ∧
      higgsParity * higgsParity * (higgsParity * higgsParity) = 1 := by
  refine ⟨?_, higgsParity_pow_four⟩
  rw [higgsParity_sq]
  intro h
  have := congrArg (fun M => M 0 0) h
  norm_num [Matrix.one_apply] at this

/-! ## 3. The fermion parity `i γ⁰` is order four ⇒ the double cover is `Pin(3,1)` -/

open BookProof.ChapterA3

/-- On Majorana spinors the (generalized) parity acts through `i γ⁰`, which is the
matrix `mgamma 0` of the concrete `A3` model.  Its square is `-1`. -/
theorem mgamma0_sq : mgamma 0 * mgamma 0 = -1 := by
  have h : mgammaZ 0 * mgammaZ 0 = -1 := by decide
  have := congrArg (Int.castRingHom ℂ).mapMatrix h
  rwa [map_mul, map_neg, map_one, ← mgamma] at this

/-- The fermion parity `i γ⁰` has order exactly four: `(i γ⁰)² = -1 ≠ 1` while
`(i γ⁰)⁴ = 1`.  The value `-1` (rather than `+1`) is the invariant selecting the double
cover `Pin(3,1)` over `Pin(1,3)`. -/
theorem fermionParity_order_four :
    mgamma 0 * mgamma 0 ≠ 1 ∧
      mgamma 0 * mgamma 0 * (mgamma 0 * mgamma 0) = 1 := by
  refine ⟨?_, ?_⟩
  · rw [mgamma0_sq]
    intro h
    have := congrArg (fun M => M 0 0) h
    norm_num [Matrix.one_apply] at this
  · rw [mgamma0_sq]; simp

/-- For contrast, the naive Dirac matrix `γ⁰` squares to `+1` (it is an involution, the
`Pin(1,3)` case), whereas the Majorana parity `i γ⁰` above squares to `-1`. -/
theorem dgamma0_sq : dgamma 0 * dgamma 0 = 1 := by
  simp only [dgamma, Matrix.smul_mul, Matrix.mul_smul, smul_smul, neg_mul_neg, Complex.I_mul_I]
  rw [mgamma0_sq]
  simp

/-! ## 4. The Gell-Mann matrices and the outer-automorphism (parity) signs -/

/-- The eight Gell-Mann generators `λ¹, …, λ⁸` of `SU(3)` (indexed `0, …, 7`). -/
noncomputable def gellMann : Fin 8 → Matrix (Fin 3) (Fin 3) ℂ
  | 0 => !![0,1,0; 1,0,0; 0,0,0]
  | 1 => !![0,-Complex.I,0; Complex.I,0,0; 0,0,0]
  | 2 => !![1,0,0; 0,-1,0; 0,0,0]
  | 3 => !![0,0,1; 0,0,0; 1,0,0]
  | 4 => !![0,0,-Complex.I; 0,0,0; Complex.I,0,0]
  | 5 => !![0,0,0; 0,0,1; 0,1,0]
  | 6 => !![0,0,0; 0,0,-Complex.I; 0,Complex.I,0]
  | 7 => ((1 : ℝ) / Real.sqrt 3) • !![1,0,0; 0,1,0; 0,0,-2]

/-- The complex-conjugation eigenvalue of `λ^a`: `+1` for the real generators
(`λ¹, λ³, λ⁴, λ⁶, λ⁸`) and `-1` for the imaginary ones (`λ², λ⁵, λ⁷`). -/
def gellMannConjSign : Fin 8 → ℂ
  | 1 => -1
  | 4 => -1
  | 6 => -1
  | _ => 1

/-- **Complex conjugation of the Gell-Mann matrices.**  Entrywise conjugation fixes the
real generators and negates the imaginary ones: `conj(λ^a) = ε^a λ^a` with the sign
pattern `ε = (+,-,+,+,-,+,-,+)`.  This is the `ℤ₂` outer automorphism of `SU(3)`. -/
theorem gellMann_conj (a : Fin 8) :
    (gellMann a).map (starRingEnd ℂ) = (gellMannConjSign a) • gellMann a := by
  fin_cases a <;>
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [gellMann, gellMannConjSign, Matrix.map_apply, Matrix.smul_apply,
        Complex.conj_ofReal, map_ofNat]

/-- The parity sign `s^a` used in the chapter for the gluon fields
`G_μ^a ↦ s^a G_μ^a(t,-x)` is the negative of the conjugation sign: `s = -ε`, i.e.
`s^{1,3,4,6,8} = -1` and `s^{2,5,7} = +1`.  Equivalently, `-conj(λ^a) = s^a λ^a`. -/
theorem gellMann_parity_sign (a : Fin 8) :
    -((gellMann a).map (starRingEnd ℂ)) = (-(gellMannConjSign a)) • gellMann a := by
  rw [gellMann_conj, neg_smul]

end BookProof.ChapterParity

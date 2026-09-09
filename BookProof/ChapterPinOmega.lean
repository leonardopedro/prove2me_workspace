import Mathlib
import BookProof.ChapterA3

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups", Definition 49 — the discrete Pin
subgroup `Ω` is the quaternion group `Q₈`

`book.tex` (Definition 49, line ~5510) introduces the discrete `Pin(3,1)` subgroup

```
Ω = { ±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵ }
```

and asserts (via the two-to-one cover `Λ`) that it is a group of order `8` — the
double cover of the Klein-four discrete Lorentz subgroup `Δ`.  This file pins
down the algebraic heart of that assertion using the concrete `4×4` real
Majorana / Dirac matrix model of `BookProof.ChapterA3`:

* the three "imaginary units" are
  `qi = iγ⁰ = ` (Majorana matrix `iγ⁰`), `qj = γ⁰γ⁵`, `qk = iγ⁵`;
* they satisfy the **quaternion relations** `qi² = qj² = qk² = -1`,
  `qi·qj = qk`, `qj·qk = qi`, `qk·qi = qj` (and the anti-commuted forms), and
  `qi·qj·qk = -1` — i.e. `Ω ≅ Q₈`, the quaternion group of order 8;
* the eight-element set `Ω` is **closed under multiplication**, contains `1` and
  the inverses of all its elements, and is **nonabelian** — so it is a group of
  order `8`.

Everything is carried out first over `ℤ` (where the identities are decidable) and
then transported to the complex model `mgamma`/`mgamma5`.  The identification of
`qj` with `γ⁰γ⁵` in the book's normalization (`γ^μ = -i·(iγ^μ)`) is recorded in
`qjC_eq_dirac`.

The surrounding claim that `Λ` maps `Ω` onto `Δ` (so `Ω` is the double cover of
`Δ`) is the continuous-cover statement of the note and is left as prose; here we
discharge the finite group-theoretic core.

As requested this stays **off the gravity line** and **off the Hankel-transform
line** (it uses only the concrete Majorana/Dirac matrices, no spherical-Bessel /
Hankel numerics).

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterPinOmega

open BookProof.ChapterA3

/-! ## Integer model of the three quaternion generators -/

/-- `qi = iγ⁰` (the first Majorana matrix), integer model. -/
def qi : Matrix (Fin 4) (Fin 4) ℤ := mgammaZ 0

/-- `qj = γ⁰γ⁵ = -(iγ⁰)(iγ⁵)`, integer model.  (In the book's normalization
`γ^μ = -i(iγ^μ)`, so `γ⁰γ⁵ = (-i)(-i)(iγ⁰)(iγ⁵) = -(iγ⁰)(iγ⁵)`.) -/
def qj : Matrix (Fin 4) (Fin 4) ℤ := -(mgammaZ 0 * mgamma5Z)

/-- `qk = iγ⁵` (the fifth Majorana matrix), integer model. -/
def qk : Matrix (Fin 4) (Fin 4) ℤ := mgamma5Z

/-! ### The quaternion relations (over `ℤ`) -/

theorem qi_sq : qi * qi = -1 := by decide
theorem qj_sq : qj * qj = -1 := by decide
theorem qk_sq : qk * qk = -1 := by decide

theorem qi_qj : qi * qj = qk := by decide
theorem qj_qk : qj * qk = qi := by decide
theorem qk_qi : qk * qi = qj := by decide

theorem qj_qi : qj * qi = -qk := by decide
theorem qk_qj : qk * qj = -qi := by decide
theorem qi_qk : qi * qk = -qj := by decide

/-- `qi·qj·qk = -1` (Hamilton's fundamental quaternion identity). -/
theorem qi_qj_qk : qi * qj * qk = -1 := by decide

/-- `Ω` is nonabelian: `qi·qj ≠ qj·qi`. -/
theorem noncomm : qi * qj ≠ qj * qi := by decide

/-! ## The eight-element group `Ω` (over `ℤ`) -/

/-- The discrete Pin subgroup `Ω = {±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵}` (integer model). -/
def Omega : Finset (Matrix (Fin 4) (Fin 4) ℤ) := {1, -1, qi, -qi, qj, -qj, qk, -qk}

/-- `Ω` has exactly eight (distinct) elements. -/
theorem Omega_card : Omega.card = 8 := by decide

/-- `1 ∈ Ω`. -/
theorem one_mem_Omega : (1 : Matrix (Fin 4) (Fin 4) ℤ) ∈ Omega := by decide

/-- `-1 ∈ Ω`. -/
theorem neg_one_mem_Omega : (-1 : Matrix (Fin 4) (Fin 4) ℤ) ∈ Omega := by decide

/-- **Closure under multiplication**: `Ω` is a submonoid of the matrix monoid. -/
theorem Omega_mul_closed : ∀ x ∈ Omega, ∀ y ∈ Omega, x * y ∈ Omega := by decide

/-- **Inverses**: every element of `Ω` has a (two-sided) inverse inside `Ω`;
together with closure and `1 ∈ Ω` this makes `Ω` a group of order `8`. -/
theorem Omega_inv : ∀ x ∈ Omega, ∃ y ∈ Omega, x * y = 1 ∧ y * x = 1 := by decide

/-! ## Complex model: identification with the book's `iγ⁰, γ⁰γ⁵, iγ⁵` -/

/-- `qi = iγ⁰` in the complex model. -/
noncomputable def qiC : Matrix (Fin 4) (Fin 4) ℂ := mgamma 0

/-- `qj = γ⁰γ⁵ = -(iγ⁰)(iγ⁵)` in the complex model. -/
noncomputable def qjC : Matrix (Fin 4) (Fin 4) ℂ := -(mgamma 0 * mgamma5)

/-- `qk = iγ⁵` in the complex model. -/
noncomputable def qkC : Matrix (Fin 4) (Fin 4) ℂ := mgamma5

theorem qiC_eq_cast : qiC = (Int.castRingHom ℂ).mapMatrix qi := rfl

theorem qjC_eq_cast : qjC = (Int.castRingHom ℂ).mapMatrix qj := by
  rw [qjC, qj, map_neg, map_mul]; rfl

theorem qkC_eq_cast : qkC = (Int.castRingHom ℂ).mapMatrix qk := rfl

/-- `qj` is `γ⁰γ⁵` in the book's Dirac normalization `γ^μ = -i(iγ^μ)`:
`(-i·iγ⁰)(-i·iγ⁵) = -(iγ⁰)(iγ⁵) = qj`. -/
theorem qjC_eq_dirac : dgamma 0 * ((-Complex.I) • mgamma5) = qjC := by
  rw [dgamma, qjC, Matrix.smul_mul, Matrix.mul_smul, smul_smul, neg_mul_neg,
    Complex.I_mul_I, neg_one_smul]

/-! ### The quaternion relations transported to the complex model -/

theorem qiC_sq : qiC * qiC = -1 := by
  rw [qiC_eq_cast, ← map_mul, qi_sq, map_neg, map_one]

theorem qjC_sq : qjC * qjC = -1 := by
  rw [qjC_eq_cast, ← map_mul, qj_sq, map_neg, map_one]

theorem qkC_sq : qkC * qkC = -1 := by
  rw [qkC_eq_cast, ← map_mul, qk_sq, map_neg, map_one]

theorem qiC_qjC : qiC * qjC = qkC := by
  rw [qiC_eq_cast, qjC_eq_cast, qkC_eq_cast, ← map_mul, qi_qj]

theorem qjC_qkC : qjC * qkC = qiC := by
  rw [qiC_eq_cast, qjC_eq_cast, qkC_eq_cast, ← map_mul, qj_qk]

theorem qkC_qiC : qkC * qiC = qjC := by
  rw [qiC_eq_cast, qjC_eq_cast, qkC_eq_cast, ← map_mul, qk_qi]

/-- Hamilton's identity in the complex model. -/
theorem qiC_qjC_qkC : qiC * qjC * qkC = -1 := by
  rw [qiC_eq_cast, qjC_eq_cast, qkC_eq_cast, ← map_mul, ← map_mul, qi_qj_qk,
    map_neg, map_one]

/-- `qj·qi = -qk` in the complex model. -/
theorem qjC_qiC : qjC * qiC = -qkC := by
  rw [qiC_eq_cast, qjC_eq_cast, qkC_eq_cast, ← map_mul, qj_qi, map_neg]

/-- `Ω` is nonabelian in the complex model. -/
theorem noncommC : qiC * qjC ≠ qjC * qiC := by
  rw [qiC_qjC, qjC_qiC]
  intro h
  have h01 := congrFun (congrFun h 0) 1
  rw [qkC_eq_cast, qk] at h01
  simp [Matrix.neg_apply, RingHom.mapMatrix_apply, Matrix.map_apply, mgamma5Z] at h01
  norm_num at h01

end BookProof.ChapterPinOmega

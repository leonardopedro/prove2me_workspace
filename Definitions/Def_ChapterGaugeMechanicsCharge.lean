import Definitions.Def_ChapterG
import Mathlib

/-
Copyright (c) 2026. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Aristotle
-/

/-!
# The gauge-mechanics model: charge operator, BRST charge and the gauge-invariant algebra

Source: `book.tex`, §*"Quantization of a classical Gauge Mechanics system"*
(lines 2402–2455) of the chapter *"Gauge symmetry and dissipative dynamics in
probability spaces"*, repeated for the field-theoretic model at line 7080.
The manuscript's model has Hilbert space `L²(ℝ² × ℤ₂)` — one complex field
`φ` and one ghost degree of freedom `k ∈ {0,1}` — with

```
[φ, π] = i,      [φ, π*] = 0,      {ψ, ψ†} = 1,
Q = π φ + π* φ*        (the gauge generator / charge operator),
Ω = (π φ + π* φ*) ψ†   (the BRST charge).
```

The book then argues that the gauge-invariant algebra must commute with `Q`
while `Q` itself, and the conjugate fields `π, π*`, must be *excluded* from it —
"this is guaranteed by unconstrained gauge-fixing" — because they do not commute
with the fields `φ, φ*` generating the commutative von Neumann algebra.

This file realizes the model on the polynomial core `ℂ[φ, φ*]` of `L²(ℝ²)`
(coordinate `0` is `φ`, coordinate `1` is `φ*`), with `π_j = -i ∂_j`, and proves
the algebraic statements the manuscript makes about it.

## Main results

* `ccr_phi_pi`, `ccr_phi_piStar` — the canonical commutation relations
  `[φ, π] = i` and `[φ, π*] = 0` exactly as displayed in the book.
* `chargeQ_eq_euler` — the charge operator is `Q = -i (E + 2)` with `E` the
  Euler (degree) operator: `Q` is diagonal in the field degree.
* `chargeQ_homogeneous` — on a field configuration homogeneous of degree `n`,
  `Q p = -i (n + 2) p`.
* `chargeQ_not_commute_field` — `[Q, φ] = -i φ`: the gauge generator does
  **not** commute with the fields, i.e. it is excluded from the commutative
  von Neumann algebra they generate — the book's *unconstrained* gauge fixing.
* `mul_commutes_chargeQ_iff_euler_zero` — multiplication by a polynomial `g`
  commutes with `Q` **iff** `E g = 0`: no charged function of the fields is
  gauge invariant.
* `bilinear_commutes_chargeQ` — the degree-preserving bilinears `φ_j ∂_k` *do*
  commute with `Q`: these are gauge-invariant observables of the model.
* `brst_nilpotent`, `brst_ne_zero`, `ghost_car` — the BRST charge `Ω = Q ψ†` of
  the model is nilpotent and non-zero, with the ghost canonical anticommutation
  relation `{ψ, ψ†} = 1` (reusing the ghost algebra of `BookProof.ChapterG`).
-/

namespace BookProof.ChapterGaugeMechanicsCharge

open MvPolynomial

/-- The polynomial core `ℂ[φ, φ*]` of `L²(ℝ²)`: coordinate `0` is the field
`φ`, coordinate `1` is its conjugate `φ*`. -/
abbrev P : Type := MvPolynomial (Fin 2) ℂ

/-- The derivative operator `∂_j` as an endomorphism of the core. -/
noncomputable def derOp (j : Fin 2) : Module.End ℂ P := (pderiv j).toLinearMap

/-- Multiplication by the field coordinate: the operator `φ` (for `j = 0`) and
`φ*` (for `j = 1`). -/
noncomputable def fieldOp (j : Fin 2) : Module.End ℂ P := LinearMap.mulLeft ℂ (X j)

/-- The conjugate momentum `π_j = -i ∂_j` (`π` for `j = 0`, `π*` for `j = 1`). -/
noncomputable def momOp (j : Fin 2) : Module.End ℂ P := (-Complex.I) • derOp j

@[simp] theorem fieldOp_apply (j : Fin 2) (p : P) : fieldOp j p = X j * p := rfl

@[simp] theorem momOp_apply (j : Fin 2) (p : P) :
    momOp j p = (-Complex.I) • pderiv j p := rfl



/-! ## The canonical commutation relations -/





/-! ## The charge operator `Q = π φ + π* φ*` -/

/-- The Euler (degree) operator `E = φ ∂_φ + φ* ∂_{φ*}`. -/
noncomputable def eulerOp : Module.End ℂ P :=
  (fieldOp 0).comp (derOp 0) + (fieldOp 1).comp (derOp 1)

@[simp] theorem eulerOp_apply (p : P) :
    eulerOp p = X 0 * pderiv 0 p + X 1 * pderiv 1 p := rfl

/-- **The gauge generator of the model**, the charge operator
`Q = π φ + π* φ*` (book 2432). -/
noncomputable def chargeQ : Module.End ℂ P :=
  (momOp 0).comp (fieldOp 0) + (momOp 1).comp (fieldOp 1)





/-! ## The gauge generator is excluded from the algebra of the fields -/











/-! ## The gauge-invariant bilinears -/





/-! ## The ghost sector and the BRST charge -/

/-- The BRST charge `Ω = Q ψ†` of the gauge-mechanics model, in the `ℤ₂` ghost
representation of `BookProof.ChapterG`. -/
noncomputable def brstOmega : Matrix (Fin 2) (Fin 2) (Module.End ℂ P) :=
  ChapterG.BRST chargeQ

ge and the gauge-invariant algebra

Source: `book.tex`, §*"Quantization of a classical Gauge Mechanics system"*
(lines 2402–2455) of the chapter *"Gauge symmetry and dissipative dynamics in
probability spaces"*, repeated for the field-theoretic model at line 7080.
The manuscript's model has Hilbert space `L²(ℝ² × ℤ₂)` — one complex field
`φ` and one ghost degree of freedom `k ∈ {0,1}` — with

```
[φ, π] = i,      [φ, π*] = 0,      {ψ, ψ†} = 1,
Q = π φ + π* φ*        (the gauge generator / charge operator),
Ω = (π φ + π* φ*) ψ†   (the BRST charge).
```

The book then argues that the gauge-invariant algebra must commute with `Q`
while `Q` itself, and the conjugate fields `π, π*`, must be *excluded* from it —
"this is guaranteed by unconstrained gauge-fixing" — because they do not commute
with the fields `φ, φ*` generating the commutative von Neumann algebra.

This file realizes the model on the polynomial core `ℂ[φ, φ*]` of `L²(ℝ²)`
(coordinate `0` is `φ`, coordinate `1` is `φ*`), with `π_j = -i ∂_j`, and proves
the algebraic statements the manuscript makes about it.

## Main results

* `ccr_phi_pi`, `ccr_phi_piStar` — the canonical commutation relations
  `[φ, π] = i` and `[φ, π*] = 0` exactly as displayed in the book.
* `chargeQ_eq_euler` — the charge operator is `Q = -i (E + 2)` with `E` the
  Euler (degree) operator: `Q` is diagonal in the field degree.
* `chargeQ_homogeneous` — on a field configuration homogeneous of degree `n`,
  `Q p = -i (n + 2) p`.
* `chargeQ_not_commute_field` — `[Q, φ] = -i φ`: the gauge generator does
  **not** commute with the fields, i.e. it is excluded from the commutative
  von Neumann algebra they generate — the book's *unconstrained* gauge fixing.
* `mul_commutes_chargeQ_iff_euler_zero` — multiplication by a polynomial `g`
  commutes with `Q` **iff** `E g = 0`: no charged function of the fields is
  gauge invariant.
* `bilinear_commutes_chargeQ` — the degree-preserving bilinears `φ_j ∂_k` *do*
  commute with `Q`: these are gauge-invariant observables of the model.
* `brst_nilpotent`, `brst_ne_zero`, `ghost_car` — the BRST charge `Ω = Q ψ†` of
  the model is nilpotent and non-zero, with the ghost canonical anticommutation
  relation `{ψ, ψ†} = 1` (reusing the ghost algebra of `BookProof.ChapterG`).
-/

namespace BookProof.ChapterGaugeMechanicsCharge

open MvPolynomial

/-- The polynomial core `ℂ[φ, φ*]` of `L²(ℝ²)`: coordinate `0` is the field
`φ`, coordinate `1` is its conjugate `φ*`. -/
abbrev P : Type := MvPolynomial (Fin 2) ℂ

/-- The derivative operator `∂_j` as an endomorphism of the core. -/
noncomputable def derOp (j : Fin 2) : Module.End ℂ P := (pderiv j).toLinearMap

/-- Multiplication by the field coordinate: the operator `φ` (for `j = 0`) and
`φ*` (for `j = 1`). -/
noncomputable def fieldOp (j : Fin 2) : Module.End ℂ P := LinearMap.mulLeft ℂ (X j)

/-- The conjugate momentum `π_j = -i ∂_j` (`π` for `j = 0`, `π*` for `j = 1`). -/
noncomputable def momOp (j : Fin 2) : Module.End ℂ P := (-Complex.I) • derOp j

@[simp] theorem fieldOp_apply (j : Fin 2) (p : P) : fieldOp j p = X j * p := rfl

@[simp] theorem momOp_apply (j : Fin 2) (p : P) :
    momOp j p = (-Complex.I) • pderiv j p := rfl

/-- Second partial derivatives of the core commute. -/
theorem pderiv_comm_core (j k : Fin 2) (p : P) :
    pderiv j (pderiv k p) = pderiv k (pderiv j p) := by
  classical
  induction p using MvPolynomial.induction_on with
  | C a => simp
  | add p q hp hq => simp [hp, hq]
  | mul_X p i hp =>
      simp only [pderiv_mul, MvPolynomial.pderiv_X, Pi.single_apply, map_add, hp]
      split_ifs with h1 h2 h2 <;> (simp; try ring)

/-! ## The canonical commutation relations -/

/-- **`[φ, π] = i`** (book 2413). -/
theorem ccr_phi_pi (p : P) :
    (fieldOp 0) (momOp 0 p) - (momOp 0) (fieldOp 0 p) = Complex.I • p := by
  change X 0 * ((-Complex.I) • pderiv 0 p)
      - (-Complex.I) • pderiv 0 (X 0 * p) = Complex.I • p
  rw [pderiv_mul]
  simp

/-- **`[φ, π*] = 0`** (book 2413): the field and the conjugate momentum of the
*other* (conjugate) coordinate commute. -/
theorem ccr_phi_piStar (p : P) :
    (fieldOp 0) (momOp 1 p) - (momOp 1) (fieldOp 0 p) = 0 := by
  change X 0 * ((-Complex.I) • pderiv 1 p)
      - (-Complex.I) • pderiv 1 (X 0 * p) = 0
  rw [pderiv_mul]
  simp [pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1)]

/-! ## The charge operator `Q = π φ + π* φ*` -/

/-- The Euler (degree) operator `E = φ ∂_φ + φ* ∂_{φ*}`. -/
noncomputable def eulerOp : Module.End ℂ P :=
  (fieldOp 0).comp (derOp 0) + (fieldOp 1).comp (derOp 1)

@[simp] theorem eulerOp_apply (p : P) :
    eulerOp p = X 0 * pderiv 0 p + X 1 * pderiv 1 p := rfl

/-- **The gauge generator of the model**, the charge operator
`Q = π φ + π* φ*` (book 2432). -/
noncomputable def chargeQ : Module.End ℂ P :=
  (momOp 0).comp (fieldOp 0) + (momOp 1).comp (fieldOp 1)

/-- The charge operator is `-i` times the shifted degree operator: it is
diagonal in the field degree. -/
theorem chargeQ_eq_euler (p : P) :
    chargeQ p = (-Complex.I) • (eulerOp p + (2 : ℂ) • p) := by
  change (-Complex.I) • pderiv 0 (X 0 * p) + (-Complex.I) • pderiv 1 (X 1 * p)
      = (-Complex.I) • (X 0 * pderiv 0 p + X 1 * pderiv 1 p + (2 : ℂ) • p)
  rw [pderiv_mul, pderiv_mul]
  simp
  module

/-- **The charge of a homogeneous field configuration.**  On a polynomial that
is homogeneous of degree `n` in the fields, `Q p = -i (n + 2) p`. -/
theorem chargeQ_homogeneous {n : ℕ} {p : P} (hp : p.IsHomogeneous n) :
    chargeQ p = (-Complex.I * (n + 2)) • p := by
  have hE : eulerOp p = (n : ℂ) • p := by
    have h := hp.sum_X_mul_pderiv
    rw [Fin.sum_univ_two] at h
    rw [eulerOp_apply, h, MvPolynomial.smul_eq_C_mul]
    simp [nsmul_eq_mul]
  rw [chargeQ_eq_euler, hE]
  module

/-! ## The gauge generator is excluded from the algebra of the fields -/

/-- The commutator of the Euler operator with multiplication by a polynomial
`g` is multiplication by `E g`. -/
theorem euler_comm_mul (g p : P) :
    eulerOp (g * p) - g * eulerOp p = (eulerOp g) * p := by
  simp only [eulerOp_apply, pderiv_mul]
  ring

/-- The Euler operator of a coordinate is the coordinate itself. -/
theorem eulerOp_X (j : Fin 2) : eulerOp (X j) = X j := by
  fin_cases j <;>
    simp [eulerOp_apply,
      pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1),
      pderiv_X_of_ne (by decide : (1 : Fin 2) ≠ 0)]

/-- **`[Q, φ] = -i φ`** — the gauge generator does not commute with the field:
it is *excluded* from the commutative von Neumann algebra generated by
`φ, φ*` (the book's unconstrained gauge fixing, line 2445). -/
theorem chargeQ_not_commute_field (j : Fin 2) (p : P) :
    chargeQ (X j * p) - X j * chargeQ p = (-Complex.I) • (X j * p) := by
  have h : eulerOp (X j * p) = X j * p + X j * eulerOp p := by
    have hc := euler_comm_mul (X j) p
    rw [eulerOp_X j] at hc
    linear_combination hc
  rw [chargeQ_eq_euler, chargeQ_eq_euler, h]
  simp only [smul_add, mul_add, smul_smul, mul_smul_comm]
  module

/-- The commutator of the charge with multiplication by `g` is multiplication
by `-i E g`. -/
theorem chargeQ_comm_mul (g p : P) :
    chargeQ (g * p) - g * chargeQ p = (-Complex.I) • (eulerOp g * p) := by
  have hc := euler_comm_mul g p
  rw [chargeQ_eq_euler, chargeQ_eq_euler]
  rw [show eulerOp (g * p) = g * eulerOp p + eulerOp g * p by linear_combination hc]
  simp only [smul_add, mul_add, mul_smul_comm]
  module

/-- Multiplication by a polynomial `g` commutes with the gauge generator `Q`
**iff** `g` has vanishing Euler derivative, i.e. iff `g` is a constant: no
charged function of the fields is gauge invariant. -/
theorem mul_commutes_chargeQ_iff_euler_zero (g : P) :
    (∀ p : P, chargeQ (g * p) = g * chargeQ p) ↔ eulerOp g = 0 := by
  constructor
  · intro h
    have h1 := chargeQ_comm_mul g 1
    rw [h 1, sub_self, mul_one] at h1
    rcases smul_eq_zero.mp h1.symm with hz | hz
    · exact absurd hz (by simp [Complex.I_ne_zero])
    · exact hz
  · intro hg p
    have h1 := chargeQ_comm_mul g p
    rw [hg, zero_mul, smul_zero] at h1
    exact sub_eq_zero.mp h1

/-! ## The gauge-invariant bilinears -/

/-- The degree-preserving bilinears `φ_j ∂_k` commute with the Euler operator. -/
theorem euler_comm_bilinear (j k : Fin 2) (p : P) :
    eulerOp (X j * pderiv k p) = X j * pderiv k (eulerOp p) := by
  have hc : ∀ a b : Fin 2, pderiv a (pderiv b p) = pderiv b (pderiv a p) :=
    fun a b => pderiv_comm_core a b p
  fin_cases j <;> fin_cases k <;>
    simp [eulerOp_apply,
      pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1),
      pderiv_X_of_ne (by decide : (1 : Fin 2) ≠ 0), hc 0 1] <;> ring

/-- **The gauge-invariant observables of the model.**  The bilinears
`φ_j ∂_k` — the operators that preserve the field degree — commute with the
gauge generator `Q`, hence they belong to the gauge-invariant algebra. -/
theorem bilinear_commutes_chargeQ (j k : Fin 2) (p : P) :
    chargeQ (X j * pderiv k p) = X j * pderiv k (chargeQ p) := by
  rw [chargeQ_eq_euler, chargeQ_eq_euler, euler_comm_bilinear j k p]
  simp only [map_add, Derivation.map_smul_of_tower, smul_add, mul_add,
    mul_smul_comm]

/-! ## The ghost sector and the BRST charge -/

/-- The BRST charge `Ω = Q ψ†` of the gauge-mechanics model, in the `ℤ₂` ghost
representation of `BookProof.ChapterG`. -/
noncomputable def brstOmega : Matrix (Fin 2) (Fin 2) (Module.End ℂ P) :=
  ChapterG.BRST chargeQ

/-- The ghost canonical anticommutation relation `{ψ, ψ†} = 1` in this model. -/
theorem ghost_car :
    ChapterG.ghostAnnih (A := Module.End ℂ P) * ChapterG.ghostCreat
      + ChapterG.ghostCreat * ChapterG.ghostAnnih = 1 :=
  ChapterG.ghost_car

/-- **The BRST charge of the gauge-mechanics model is nilpotent**, `Ω² = 0`. -/
theorem brst_nilpotent : brstOmega * brstOmega = 0 :=
  ChapterG.BRST_nilpotent chargeQ

riant algebra

Source: `book.tex`, §*"Quantization of a classical Gauge Mechanics system"*
(lines 2402–2455) of the chapter *"Gauge symmetry and dissipative dynamics in
probability spaces"*, repeated for the field-theoretic model at line 7080.
The manuscript's model has Hilbert space `L²(ℝ² × ℤ₂)` — one complex field
`φ` and one ghost degree of freedom `k ∈ {0,1}` — with

```
[φ, π] = i,      [φ, π*] = 0,      {ψ, ψ†} = 1,
Q = π φ + π* φ*        (the gauge generator / charge operator),
Ω = (π φ + π* φ*) ψ†   (the BRST charge).
```

The book then argues that the gauge-invariant algebra must commute with `Q`
while `Q` itself, and the conjugate fields `π, π*`, must be *excluded* from it —
"this is guaranteed by unconstrained gauge-fixing" — because they do not commute
with the fields `φ, φ*` generating the commutative von Neumann algebra.

This file realizes the model on the polynomial core `ℂ[φ, φ*]` of `L²(ℝ²)`
(coordinate `0` is `φ`, coordinate `1` is `φ*`), with `π_j = -i ∂_j`, and proves
the algebraic statements the manuscript makes about it.

## Main results

* `ccr_phi_pi`, `ccr_phi_piStar` — the canonical commutation relations
  `[φ, π] = i` and `[φ, π*] = 0` exactly as displayed in the book.
* `chargeQ_eq_euler` — the charge operator is `Q = -i (E + 2)` with `E` the
  Euler (degree) operator: `Q` is diagonal in the field degree.
* `chargeQ_homogeneous` — on a field configuration homogeneous of degree `n`,
  `Q p = -i (n + 2) p`.
* `chargeQ_not_commute_field` — `[Q, φ] = -i φ`: the gauge generator does
  **not** commute with the fields, i.e. it is excluded from the commutative
  von Neumann algebra they generate — the book's *unconstrained* gauge fixing.
* `mul_commutes_chargeQ_iff_euler_zero` — multiplication by a polynomial `g`
  commutes with `Q` **iff** `E g = 0`: no charged function of the fields is
  gauge invariant.
* `bilinear_commutes_chargeQ` — the degree-preserving bilinears `φ_j ∂_k` *do*
  commute with `Q`: these are gauge-invariant observables of the model.
* `brst_nilpotent`, `brst_ne_zero`, `ghost_car` — the BRST charge `Ω = Q ψ†` of
  the model is nilpotent and non-zero, with the ghost canonical anticommutation
  relation `{ψ, ψ†} = 1` (reusing the ghost algebra of `BookProof.ChapterG`).
-/

namespace BookProof.ChapterGaugeMechanicsCharge

open MvPolynomial

/-- The polynomial core `ℂ[φ, φ*]` of `L²(ℝ²)`: coordinate `0` is the field
`φ`, coordinate `1` is its conjugate `φ*`. -/
abbrev P : Type := MvPolynomial (Fin 2) ℂ

/-- The derivative operator `∂_j` as an endomorphism of the core. -/
noncomputable def derOp (j : Fin 2) : Module.End ℂ P := (pderiv j).toLinearMap

/-- Multiplication by the field coordinate: the operator `φ` (for `j = 0`) and
`φ*` (for `j = 1`). -/
noncomputable def fieldOp (j : Fin 2) : Module.End ℂ P := LinearMap.mulLeft ℂ (X j)

/-- The conjugate momentum `π_j = -i ∂_j` (`π` for `j = 0`, `π*` for `j = 1`). -/
noncomputable def momOp (j : Fin 2) : Module.End ℂ P := (-Complex.I) • derOp j

@[simp] theorem fieldOp_apply (j : Fin 2) (p : P) : fieldOp j p = X j * p := rfl

@[simp] theorem momOp_apply (j : Fin 2) (p : P) :
    momOp j p = (-Complex.I) • pderiv j p := rfl

/-- Second partial derivatives of the core commute. -/
theorem pderiv_comm_core (j k : Fin 2) (p : P) :
    pderiv j (pderiv k p) = pderiv k (pderiv j p) := by
  classical
  induction p using MvPolynomial.induction_on with
  | C a => simp
  | add p q hp hq => simp [hp, hq]
  | mul_X p i hp =>
      simp only [pderiv_mul, MvPolynomial.pderiv_X, Pi.single_apply, map_add, hp]
      split_ifs with h1 h2 h2 <;> (simp; try ring)

/-! ## The canonical commutation relations -/

/-- **`[φ, π] = i`** (book 2413). -/
theorem ccr_phi_pi (p : P) :
    (fieldOp 0) (momOp 0 p) - (momOp 0) (fieldOp 0 p) = Complex.I • p := by
  change X 0 * ((-Complex.I) • pderiv 0 p)
      - (-Complex.I) • pderiv 0 (X 0 * p) = Complex.I • p
  rw [pderiv_mul]
  simp

/-- **`[φ, π*] = 0`** (book 2413): the field and the conjugate momentum of the
*other* (conjugate) coordinate commute. -/
theorem ccr_phi_piStar (p : P) :
    (fieldOp 0) (momOp 1 p) - (momOp 1) (fieldOp 0 p) = 0 := by
  change X 0 * ((-Complex.I) • pderiv 1 p)
      - (-Complex.I) • pderiv 1 (X 0 * p) = 0
  rw [pderiv_mul]
  simp [pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1)]

/-! ## The charge operator `Q = π φ + π* φ*` -/

/-- The Euler (degree) operator `E = φ ∂_φ + φ* ∂_{φ*}`. -/
noncomputable def eulerOp : Module.End ℂ P :=
  (fieldOp 0).comp (derOp 0) + (fieldOp 1).comp (derOp 1)

@[simp] theorem eulerOp_apply (p : P) :
    eulerOp p = X 0 * pderiv 0 p + X 1 * pderiv 1 p := rfl

/-- **The gauge generator of the model**, the charge operator
`Q = π φ + π* φ*` (book 2432). -/
noncomputable def chargeQ : Module.End ℂ P :=
  (momOp 0).comp (fieldOp 0) + (momOp 1).comp (fieldOp 1)

/-- The charge operator is `-i` times the shifted degree operator: it is
diagonal in the field degree. -/
theorem chargeQ_eq_euler (p : P) :
    chargeQ p = (-Complex.I) • (eulerOp p + (2 : ℂ) • p) := by
  change (-Complex.I) • pderiv 0 (X 0 * p) + (-Complex.I) • pderiv 1 (X 1 * p)
      = (-Complex.I) • (X 0 * pderiv 0 p + X 1 * pderiv 1 p + (2 : ℂ) • p)
  rw [pderiv_mul, pderiv_mul]
  simp
  module

/-- **The charge of a homogeneous field configuration.**  On a polynomial that
is homogeneous of degree `n` in the fields, `Q p = -i (n + 2) p`. -/
theorem chargeQ_homogeneous {n : ℕ} {p : P} (hp : p.IsHomogeneous n) :
    chargeQ p = (-Complex.I * (n + 2)) • p := by
  have hE : eulerOp p = (n : ℂ) • p := by
    have h := hp.sum_X_mul_pderiv
    rw [Fin.sum_univ_two] at h
    rw [eulerOp_apply, h, MvPolynomial.smul_eq_C_mul]
    simp [nsmul_eq_mul]
  rw [chargeQ_eq_euler, hE]
  module

/-! ## The gauge generator is excluded from the algebra of the fields -/

/-- The commutator of the Euler operator with multiplication by a polynomial
`g` is multiplication by `E g`. -/
theorem euler_comm_mul (g p : P) :
    eulerOp (g * p) - g * eulerOp p = (eulerOp g) * p := by
  simp only [eulerOp_apply, pderiv_mul]
  ring

/-- The Euler operator of a coordinate is the coordinate itself. -/
theorem eulerOp_X (j : Fin 2) : eulerOp (X j) = X j := by
  fin_cases j <;>
    simp [eulerOp_apply,
      pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1),
      pderiv_X_of_ne (by decide : (1 : Fin 2) ≠ 0)]

/-- **`[Q, φ] = -i φ`** — the gauge generator does not commute with the field:
it is *excluded* from the commutative von Neumann algebra generated by
`φ, φ*` (the book's unconstrained gauge fixing, line 2445). -/
theorem chargeQ_not_commute_field (j : Fin 2) (p : P) :
    chargeQ (X j * p) - X j * chargeQ p = (-Complex.I) • (X j * p) := by
  have h : eulerOp (X j * p) = X j * p + X j * eulerOp p := by
    have hc := euler_comm_mul (X j) p
    rw [eulerOp_X j] at hc
    linear_combination hc
  rw [chargeQ_eq_euler, chargeQ_eq_euler, h]
  simp only [smul_add, mul_add, smul_smul, mul_smul_comm]
  module

/-- The commutator of the charge with multiplication by `g` is multiplication
by `-i E g`. -/
theorem chargeQ_comm_mul (g p : P) :
    chargeQ (g * p) - g * chargeQ p = (-Complex.I) • (eulerOp g * p) := by
  have hc := euler_comm_mul g p
  rw [chargeQ_eq_euler, chargeQ_eq_euler]
  rw [show eulerOp (g * p) = g * eulerOp p + eulerOp g * p by linear_combination hc]
  simp only [smul_add, mul_add, mul_smul_comm]
  module

/-- Multiplication by a polynomial `g` commutes with the gauge generator `Q`
**iff** `g` has vanishing Euler derivative, i.e. iff `g` is a constant: no
charged function of the fields is gauge invariant. -/
theorem mul_commutes_chargeQ_iff_euler_zero (g : P) :
    (∀ p : P, chargeQ (g * p) = g * chargeQ p) ↔ eulerOp g = 0 := by
  constructor
  · intro h
    have h1 := chargeQ_comm_mul g 1
    rw [h 1, sub_self, mul_one] at h1
    rcases smul_eq_zero.mp h1.symm with hz | hz
    · exact absurd hz (by simp [Complex.I_ne_zero])
    · exact hz
  · intro hg p
    have h1 := chargeQ_comm_mul g p
    rw [hg, zero_mul, smul_zero] at h1
    exact sub_eq_zero.mp h1

/-! ## The gauge-invariant bilinears -/

/-- The degree-preserving bilinears `φ_j ∂_k` commute with the Euler operator. -/
theorem euler_comm_bilinear (j k : Fin 2) (p : P) :
    eulerOp (X j * pderiv k p) = X j * pderiv k (eulerOp p) := by
  have hc : ∀ a b : Fin 2, pderiv a (pderiv b p) = pderiv b (pderiv a p) :=
    fun a b => pderiv_comm_core a b p
  fin_cases j <;> fin_cases k <;>
    simp [eulerOp_apply,
      pderiv_X_of_ne (by decide : (0 : Fin 2) ≠ 1),
      pderiv_X_of_ne (by decide : (1 : Fin 2) ≠ 0), hc 0 1] <;> ring

/-- **The gauge-invariant observables of the model.**  The bilinears
`φ_j ∂_k` — the operators that preserve the field degree — commute with the
gauge generator `Q`, hence they belong to the gauge-invariant algebra. -/
theorem bilinear_commutes_chargeQ (j k : Fin 2) (p : P) :
    chargeQ (X j * pderiv k p) = X j * pderiv k (chargeQ p) := by
  rw [chargeQ_eq_euler, chargeQ_eq_euler, euler_comm_bilinear j k p]
  simp only [map_add, Derivation.map_smul_of_tower, smul_add, mul_add,
    mul_smul_comm]

/-! ## The ghost sector and the BRST charge -/

/-- The BRST charge `Ω = Q ψ†` of the gauge-mechanics model, in the `ℤ₂` ghost
representation of `BookProof.ChapterG`. -/
noncomputable def brstOmega : Matrix (Fin 2) (Fin 2) (Module.End ℂ P) :=
  ChapterG.BRST chargeQ

/-- The ghost canonical anticommutation relation `{ψ, ψ†} = 1` in this model. -/
theorem ghost_car :
    ChapterG.ghostAnnih (A := Module.End ℂ P) * ChapterG.ghostCreat
      + ChapterG.ghostCreat * ChapterG.ghostAnnih = 1 :=
  ChapterG.ghost_car

/-- **The BRST charge of the gauge-mechanics model is nilpotent**, `Ω² = 0`. -/
theorem brst_nilpotent : brstOmega * brstOmega = 0 :=
  ChapterG.BRST_nilpotent chargeQ

/-- The charge operator is non-zero (it multiplies the constants by `-2i`). -/
theorem chargeQ_ne_zero : chargeQ ≠ 0 := by
  intro h
  have h1 : chargeQ (1 : P) = 0 := by rw [h]; rfl
  have h2 : chargeQ (1 : P) = (-Complex.I * (((0 : ℕ) : ℂ) + 2)) • (1 : P) :=
    chargeQ_homogeneous (isHomogeneous_one _ _)
  rw [h1] at h2
  have hne : (-Complex.I * (((0 : ℕ) : ℂ) + 2)) ≠ 0 := by
    norm_num [Complex.I_ne_zero]
  rcases smul_eq_zero.mp h2.symm with hz | hz
  · exact hne hz
  · exact one_ne_zero hz

/-- The BRST charge of the model is non-zero: the ghost sector is genuinely
present. -/
theorem brst_ne_zero : brstOmega ≠ 0 := by
  intro h
  apply chargeQ_ne_zero
  have := congrFun (congrFun h 1) 0
  simpa [brstOmega, ChapterG.BRST] using this

end BookProof.ChapterGaugeMechanicsCharge

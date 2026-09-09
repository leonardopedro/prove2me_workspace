import Mathlib

/-!
# Chapter A.4(b) — Prop 61 unitarity (work-package N4)

Source: `book.tex` §A.4 (line 5636), **Proposition 61** — the first of the four
"unitarity by direct computation" statements of §A.4 (the roadmap's tractable
core, together with Props 73/74/76 in `ChapterA4.lean`).

## The book statement

If `U : Pinor_j(ℝ³) → Pinor_j(𝕏)` is unitary intertwining the squared
Hamiltonians `U ∘ H² = E² ∘ U` (with `iH = γ⁰∂̸ + iγ⁰m`, `E(X) ≥ m ≥ 0`), then
```
U' := (E + U H γ⁰ U†) / (√(E+m)·√(2E))
```
is unitary.  The book proves it by `(U')†U' = 1 = U'(U')†`, using that `E = √(E²)`
commutes with `U H γ⁰ U†`, the Dirac anticommutator `γ⁰H + Hγ⁰ = 2m`, and
`H² = U† E² U`.

## What is formalized here

The mathematical heart is a **C\*-algebra identity**.  Writing `c := U H γ⁰ U†`
(so `c† = U γ⁰ H U†`), the Dirac anticommutator `{γ⁰, H} = 2m` together with
`(γ⁰)² = 1` gives the two structural relations
```
c + c† = 2m · 1                    (real part of c is the mass m)
E² = c† c   (= c c†)               (E is the modulus |c|, E = √(c†c))
```
and then a pure ring computation shows
```
(E + c†)(E + c) = 2E(E+m) = (E + c)(E + c†),
```
so dividing by the positive normaliser `p := √(2E)·√(E+m)` (with `p² = 2E(E+m)`)
makes `U' := p⁻¹(E + c)` a unitary: `U'†U' = 1 = U'U'†`.

* `BookProof.prop61_unitary_core` — the abstract engine: in any `ℂ`-*-algebra,
  given `c` with `c + c† = 2m·1`, a self-adjoint `E` with `E² = c†c` commuting
  with `c`, and a self-adjoint normaliser `p` with `p² = 2E² + 2m·E` invertible
  with inverse `q` (a self-adjoint element commuting with `E` and `c`), the
  element `U' := q(E + c)` satisfies `U'†U' = 1 = U'U'†`, i.e. is unitary.  This
  *is* Prop 61's `(U')†U' = 1 = U'(U')†` argument.

* `BookProof.prop61_energyMap_unitary` — the C\*-algebra existence wrapper: for
  `c` with `c + c† = 2m·1` (`m ≥ 0` real) and `c` a unit, the positive square
  roots `E := √(c†c)` and `p := √(2E² + 2m·E)` exist (continuous functional
  calculus), are invertible, and satisfy the hypotheses of the core, so
  `U' := p⁻¹(E + c)` is genuinely a unitary.
-/

namespace BookProof

section Core

variable {A : Type*} [Ring A] [StarRing A] [Algebra ℂ A]

/-
**Prop 61 (book), abstract C\*-algebra core.**

In a `ℂ`-*-algebra, suppose `c` has "real part `m`" in the sense
`c + c† = (2m)·1`, that `E` is a self-adjoint element with `E² = c†c` commuting
with `c` (the modulus `E = |c| = √(c†c)`), and that `p` is a self-adjoint
normaliser with `p² = 2E² + (2m)·E = 2E(E+m)` which is invertible with inverse
`q` (self-adjoint, commuting with `E` and `c`).  Then `U' := q·(E + c)` is a
**unitary**: `U'†·U' = 1` and `U'·U'† = 1`.

This is the book's `(U')†U' = 1 = U'(U')†` computation for
`U' = (E + U H γ⁰ U†)/(√(E+m)·√(2E))`.
-/
theorem prop61_unitary_core
    (c E p q : A) (m : ℂ)
    (hcsa : c + star c = (2 * m) • (1 : A))
    (hE2 : E * E = star c * c)
    (hEsa : IsSelfAdjoint E)
    (hqsa : IsSelfAdjoint q)
    (hEc : Commute E c)
    (hqc : Commute q c)
    (hqE : Commute q E)
    (hp2 : p * p = (2 : ℂ) • (E * E) + (2 * m) • E)
    (hqp1 : q * p = 1)
    (hqp2 : p * q = 1) :
    star (q * (E + c)) * (q * (E + c)) = 1 ∧
      (q * (E + c)) * star (q * (E + c)) = 1 := by
  -- First, let's establish some useful equalities related to the elements involved.
  have h_star_c : star c = (2*m) • 1 - c := by
    rw [ ← hcsa, add_sub_cancel_left ]
  have h_star_q : star q = q := by
    exact hqsa
  have h_star_E : star E = E := by
    exact hEsa;
  -- Now let's prove the two structural product identities.
  have h1 : (E + star c) * (E + c) = (2:ℂ) • (E * E) + (2 * m) • E := by
    simp [ two_mul, add_mul, mul_add, h_star_c, hE2, hEc.eq ]
    simp [ two_smul, sub_mul ] ; abel_nf
  have h2 : (E + c) * (E + star c) = (2:ℂ) • (E * E) + (2 * m) • E := by
    simp_all only [add_sub_cancel, two_smul, mul_add, add_mul]
    simp_all only [sub_mul, Algebra.smul_mul_assoc, one_mul, hEc.eq, mul_sub, Algebra.mul_smul_comm,
        mul_one]
    abel1
  -- Now let's prove the two product identities.
  have h3 : (E + star c) * q * (q * (E + c)) = 1 := by
    have h4 : (E + star c) * (q * q) * (E + c) = (p * p) * (q * q) := by
      have h4 : (E + star c) * (q * q) * (E + c) = ((E + star c) * (E + c)) * (q * q) := by
        simp only [h_star_c, add_mul, mul_assoc];
        simp only [mul_add, hqE.eq, hqc.eq, ← mul_assoc, hEc.eq];
      rw [h4, h1, hp2];
    grind
  have h4 : q * (E + c) * (E + star c) * q = 1 := by
    simp_all [ mul_assoc, two_smul ];
    simp [ ← mul_assoc, ← hp2, hqp1, hqp2 ];
  simp_all [ ← mul_assoc ]

end Core

section InverseHelpers

variable {A : Type*} [Monoid A]

/-
A two-sided inverse of a self-adjoint element is self-adjoint.
-/
theorem isSelfAdjoint_of_mul_eq_one [StarMul A] {p q : A}
    (hp : IsSelfAdjoint p) (h2 : p * q = 1) : IsSelfAdjoint q := by
  have hsp : star q * p = 1 := by rw [← hp.star_eq, ← star_mul, h2, star_one]
  have hqq : star q = q := by rw [← mul_one (star q), ← h2, ← mul_assoc, hsp, one_mul]
  exact hqq

/-
If `p` commutes with `x` and `q` is a two-sided inverse of `p`, then `q`
commutes with `x`.
-/
theorem Commute.of_mul_eq_one {p q x : A}
    (h : Commute p x) (h1 : q * p = 1) (h2 : p * q = 1) : Commute q x := by
  have h_comm : q * x = x * q := by
    have h_comm : p * q * x = p * x * q := by
      simp [ mul_assoc, h.eq ];
      grind
    apply_fun (fun y => q * y) at h_comm; simp_all [ mul_assoc ] ;
    simp [ ← mul_assoc, h1 ];
  exact h_comm

end InverseHelpers

section Wrapper

variable {A : Type*} [CStarAlgebra A] [PartialOrder A] [StarOrderedRing A]

/-
**Prop 61 (book), C\*-algebra existence form.**

For an element `c` of a C\*-algebra with `c + c† = (2m)·1` for a real `m ≥ 0` and
`c` invertible, the positive square roots `E := √(c†c)` and
`p := √(2E² + (2m)·E)` exist and are invertible, and `U' := p⁻¹·(E + c)` is a
unitary: `U'†·U' = 1` and `U'·U'† = 1`.  (Here `iH`, `γ⁰`, `U`, `E` are packaged
into the single element `c := U H γ⁰ U†`, whose modulus is the energy operator.)
-/
theorem prop61_energyMap_unitary
    (c : A) (m : ℝ) (hm : 0 ≤ m)
    (hcsa : c + star c = (2 * (m : ℂ)) • (1 : A))
    (hc : IsUnit c) :
    ∃ E p : A, IsSelfAdjoint E ∧ IsSelfAdjoint p ∧ IsUnit p ∧
      E * E = star c * c ∧
      p * p = (2 : ℂ) • (E * E) + (2 * (m : ℂ)) • E ∧
      (∀ q : A, q * p = 1 → p * q = 1 →
        star (q * (E + c)) * (q * (E + c)) = 1 ∧
          (q * (E + c)) * star (q * (E + c)) = 1) := by
  -- `c` is normal: `star c = (2m)·1 - c` commutes with `c`.
  have hcc : Commute (star c) c := by
    have hsc : star c = (2 * (m : ℂ)) • (1 : A) - c := by rw [← hcsa]; abel
    rw [hsc]; exact ((Commute.one_left c).smul_left _).sub_left (Commute.refl c)
  have hscc : Commute (star c * c) c := hcc.mul_left (Commute.refl c)
  -- The modulus `E := √(c†c)`.
  set E : A := CFC.sqrt (star c * c) with hEdef
  have hEnn : 0 ≤ E := CFC.sqrt_nonneg _
  have hEsa : IsSelfAdjoint E := hEnn.isSelfAdjoint
  have hE2 : E * E = star c * c := by
    have h := CFC.sq_sqrt (star c * c) (star_mul_self_nonneg c); rwa [sq] at h
  have hEEnn : 0 ≤ E * E := by
    have h := star_mul_self_nonneg E; rwa [hEsa.star_eq] at h
  have hEc : Commute E c := hscc.cfcₙ_nnreal NNReal.sqrt
  -- Positivity of the mass term `(2m)·E`.
  have hsm : 0 ≤ (2 * (m : ℂ)) • E := by
    rw [show (2 * (m : ℂ)) = ((2 * m : ℝ) : ℂ) by push_cast; ring,
      show (((2 * m : ℝ) : ℂ)) = algebraMap ℝ ℂ (2 * m) from rfl,
      IsScalarTower.algebraMap_smul]
    exact smul_nonneg (by positivity) hEnn
  -- The normaliser `p := √(2E² + 2m·E)`.
  set arg : A := (2 : ℂ) • (E * E) + (2 * (m : ℂ)) • E with hargdef
  have h2ee : 0 ≤ (2 : ℂ) • (E * E) := by rw [two_smul]; exact add_nonneg hEEnn hEEnn
  have hargnn : 0 ≤ arg := add_nonneg h2ee hsm
  set p : A := CFC.sqrt arg with hpdef
  have hpsa : IsSelfAdjoint p := (CFC.sqrt_nonneg _).isSelfAdjoint
  have hp2 : p * p = arg := by
    have h := CFC.sq_sqrt arg hargnn; rwa [sq] at h
  -- `arg` is a unit, hence so is `p`.
  have hEEunit : IsUnit (E * E) := by rw [hE2]; exact hc.star.mul hc
  have hargunit : IsUnit arg := by
    refine CStarAlgebra.isUnit_of_le (E * E) ?_ ⟨hEEnn, hEEunit⟩
    have hrw : arg = E * E + (E * E + (2 * (m : ℂ)) • E) := by rw [hargdef, two_smul]; abel
    rw [hrw]; exact le_add_of_nonneg_right (add_nonneg hEEnn hsm)
  have hpunit : IsUnit p := isUnit_mul_self_iff.mp (hp2 ▸ hargunit)
  -- `p` commutes with `c` and with `E`.
  have hargc : Commute arg c :=
    ((hEc.mul_left hEc).smul_left _).add_left (hEc.smul_left _)
  have hargE : Commute arg E :=
    (((Commute.refl E).mul_left (Commute.refl E)).smul_left _).add_left
      ((Commute.refl E).smul_left _)
  have hpc : Commute p c := hargc.cfcₙ_nnreal NNReal.sqrt
  have hpE : Commute p E := hargE.cfcₙ_nnreal NNReal.sqrt
  refine ⟨E, p, hEsa, hpsa, hpunit, hE2, hp2, ?_⟩
  intro q h1 h2
  exact prop61_unitary_core c E p q (m : ℂ) hcsa hE2 hEsa
    (isSelfAdjoint_of_mul_eq_one hpsa h2) hEc
    (Commute.of_mul_eq_one hpc h1 h2) (Commute.of_mul_eq_one hpE h1 h2) hp2 h1 h2

end Wrapper

end BookProof

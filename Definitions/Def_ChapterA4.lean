import Mathlib


/-!
# Chapter A.4 — Majorana–Fourier / Energy unitarity (work-package N4)

Source: `book.tex` line 5636 (§A.4, "Unitary representations of the Poincaré
group"). This module implements the **tractable unitarity core** of §A.4, namely
**Props 73, 74, 76** (the roadmap's "unitarity by direct computation" props).

The book builds the Bargmann–Wigner scaffolding (Defs 53–60) and then defines the
Majorana–Fourier transform `𝓕_M := (𝓕_P)^Θ` (Note 62 / Prop 73), where `𝓕_P` is
the (complex) Pauli Fourier transform — Mathlib's
`MeasureTheory.Lp.fourierTransformₗᵢ` — and `·^Θ` is conjugation by the
real-linear isometric isomorphism `Θ` coming from the identification
`Pauli^r ≅ Pinor`. The book's proof is:

> *a `Θ`-conjugate of a unitary is unitary* (`Θ` is a real-linear isometric iso).

and Prop 74 records `𝓕_M⁻¹ = (𝓕_P⁻¹)^Θ`, Prop 76 defines the Energy transform
`𝓔` by the same conjugation and hence unitary for the same reason.

We formalize this faithfully:

* `BookProof.conjugateₗᵢ` — the **abstract engine**: for a linear isometry
  equivalence `A : E ≃ₗᵢ[R] E` ("a unitary") and a linear isometry equivalence
  `Θ : E ≃ₗᵢ[R] E'`, the conjugate `Θ ∘ A ∘ Θ⁻¹ : E' ≃ₗᵢ[R] E'` is again a
  linear isometry equivalence. This *is* Prop 73/76's argument.
* `BookProof.conjugateₗᵢ_symm` — Prop 74: the inverse of the conjugate is the
  conjugate of the inverse, `(A^Θ)⁻¹ = (A⁻¹)^Θ`.
* `BookProof.LinearIsometryEquiv.restrictScalarsₗᵢ` — the small missing Mathlib
  helper: a `𝕜`-linear isometry equivalence is in particular an `R`-linear
  isometry equivalence for a compatible subring `R` (norms do not depend on the
  scalar field). This lets us view the **complex** Pauli Fourier transform as a
  real isometry, so that a real-linear `Θ` may conjugate it.
* `BookProof.pauliFourier` — the complex Fourier transform
  `Lp.fourierTransformₗᵢ` viewed as a **real** unitary (`𝓕_P`).
* `BookProof.majoranaFourier` (**Prop 73**) — `𝓕_M := 𝓕_P^Θ`, a real unitary
  (`≃ₗᵢ[ℝ]`), and `majoranaFourier_symm` (**Prop 74**),
  `majoranaFourier_apply`.
* `BookProof.energyTransform` (**Prop 76**) — `𝓔`, the same conjugation of a
  (time-coordinate) Fourier transform, again a real unitary.

All statements are `sorry`-free and use no `EXTERNAL` hypothesis (Plancherel is
already in Mathlib as `Lp.fourierTransformₗᵢ`, per §A.4 of the roadmap).  The
real-linear iso `Θ` (the Pauli↔Pinor identification tensored with `L²`) is kept
as a parameter, matching the book's Def 53/54 scaffolding.
-/

namespace BookProof

open MeasureTheory

/-- **Restriction of scalars for a linear isometry equivalence.**  A
`𝕜`-linear isometry equivalence is, in particular, an `R`-linear isometry
equivalence for any compatible sub-scalar-ring `R`: the underlying linear
equivalence restricts (`LinearEquiv.restrictScalars`) and the norm-preservation
property is unchanged (norms do not depend on the scalar ring).  This is the
small helper that Mathlib lacks; it lets a real-linear map conjugate a complex
unitary. -/
noncomputable def LinearIsometryEquiv.restrictScalarsₗᵢ
    (R : Type*) {S E E' : Type*} [Semiring R] [Semiring S]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E']
    [Module R E] [Module S E] [Module R E'] [Module S E']
    [LinearMap.CompatibleSMul E E' R S] [LinearMap.CompatibleSMul E' E R S]
    (f : E ≃ₗᵢ[S] E') : E ≃ₗᵢ[R] E' where
  toLinearEquiv := f.toLinearEquiv.restrictScalars R
  norm_map' := f.norm_map'

@[simp]
theorem LinearIsometryEquiv.restrictScalarsₗᵢ_apply
    (R : Type*) {S E E' : Type*} [Semiring R] [Semiring S]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E']
    [Module R E] [Module S E] [Module R E'] [Module S E']
    [LinearMap.CompatibleSMul E E' R S] [LinearMap.CompatibleSMul E' E R S]
    (f : E ≃ₗᵢ[S] E') (x : E) :
    LinearIsometryEquiv.restrictScalarsₗᵢ R f x = f x := rfl

section Conjugation

variable {R E E' : Type*} [Semiring R]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E'] [Module R E] [Module R E']

/-- **The conjugation engine (Prop 73 / Prop 76 argument).**  Given a linear
isometry equivalence `A : E ≃ₗᵢ[R] E` (a "unitary") and a linear isometry
equivalence `Θ : E ≃ₗᵢ[R] E'`, the conjugate `A^Θ := Θ ∘ A ∘ Θ⁻¹` is again a
linear isometry equivalence `E' ≃ₗᵢ[R] E'`.  A `Θ`-conjugate of a unitary is a
unitary. -/
noncomputable def conjugateₗᵢ (Θ : E ≃ₗᵢ[R] E') (A : E ≃ₗᵢ[R] E) : E' ≃ₗᵢ[R] E' :=
  Θ.symm.trans (A.trans Θ)

@[simp]
theorem conjugateₗᵢ_apply (Θ : E ≃ₗᵢ[R] E') (A : E ≃ₗᵢ[R] E) (x : E') :
    conjugateₗᵢ Θ A x = Θ (A (Θ.symm x)) := rfl





/-- Conjugation of the identity is the identity. -/
@[simp]
theorem conjugateₗᵢ_refl (Θ : E ≃ₗᵢ[R] E') :
    conjugateₗᵢ Θ (LinearIsometryEquiv.refl R E) = LinearIsometryEquiv.refl R E' := by
  ext x
  simp [conjugateₗᵢ]

end Conjugation

section MajoranaFourier

variable (E F : Type*) [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
    [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-- The **Pauli Fourier transform `𝓕_P`** viewed as a *real* unitary: Mathlib's
complex `L²` Fourier transform `MeasureTheory.Lp.fourierTransformₗᵢ` (a
`≃ₗᵢ[ℂ]`, unitary by Plancherel) restricted to `ℝ`-linearity so that a
real-linear `Θ` may conjugate it. -/
noncomputable def pauliFourier :
    (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] (Lp F 2 (volume : Measure E)) :=
  LinearIsometryEquiv.restrictScalarsₗᵢ ℝ (Lp.fourierTransformₗᵢ E F)

variable {P : Type*} [NormedAddCommGroup P] [InnerProductSpace ℝ P]

/-- **Prop 73 (book): the Majorana–Fourier transform `𝓕_M := (𝓕_P)^Θ` is
unitary.**  Given the real-linear isometric identification
`Θ : Pauli(𝕏) ≃ₗᵢ[ℝ] Pinor(𝕏)` (Def 53/54, `Θ`-conjugation), the
Majorana–Fourier transform is the `Θ`-conjugate of the (real view of the) complex
Pauli Fourier transform; being a `Θ`-conjugate of a unitary it is itself a
unitary, i.e. an `ℝ`-linear isometry equivalence. -/
noncomputable def majoranaFourier
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P) : P ≃ₗᵢ[ℝ] P :=
  conjugateₗᵢ Θ (pauliFourier E F)



@[simp]
theorem majoranaFourier_apply
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P) (x : P) :
    majoranaFourier E F Θ x = Θ (pauliFourier E F (Θ.symm x)) := rflé
group"). This module implements the **tractable unitarity core** of §A.4, namely
**Props 73, 74, 76** (the roadmap's "unitarity by direct computation" props).

The book builds the Bargmann–Wigner scaffolding (Defs 53–60) and then defines the
Majorana–Fourier transform `𝓕_M := (𝓕_P)^Θ` (Note 62 / Prop 73), where `𝓕_P` is
the (complex) Pauli Fourier transform — Mathlib's
`MeasureTheory.Lp.fourierTransformₗᵢ` — and `·^Θ` is conjugation by the
real-linear isometric isomorphism `Θ` coming from the identification
`Pauli^r ≅ Pinor`. The book's proof is:

> *a `Θ`-conjugate of a unitary is unitary* (`Θ` is a real-linear isometric iso).

and Prop 74 records `𝓕_M⁻¹ = (𝓕_P⁻¹)^Θ`, Prop 76 defines the Energy transform
`𝓔` by the same conjugation and hence unitary for the same reason.

We formalize this faithfully:

* `BookProof.conjugateₗᵢ` — the **abstract engine**: for a linear isometry
  equivalence `A : E ≃ₗᵢ[R] E` ("a unitary") and a linear isometry equivalence
  `Θ : E ≃ₗᵢ[R] E'`, the conjugate `Θ ∘ A ∘ Θ⁻¹ : E' ≃ₗᵢ[R] E'` is again a
  linear isometry equivalence. This *is* Prop 73/76's argument.
* `BookProof.conjugateₗᵢ_symm` — Prop 74: the inverse of the conjugate is the
  conjugate of the inverse, `(A^Θ)⁻¹ = (A⁻¹)^Θ`.
* `BookProof.LinearIsometryEquiv.restrictScalarsₗᵢ` — the small missing Mathlib
  helper: a `𝕜`-linear isometry equivalence is in particular an `R`-linear
  isometry equivalence for a compatible subring `R` (norms do not depend on the
  scalar field). This lets us view the **complex** Pauli Fourier transform as a
  real isometry, so that a real-linear `Θ` may conjugate it.
* `BookProof.pauliFourier` — the complex Fourier transform
  `Lp.fourierTransformₗᵢ` viewed as a **real** unitary (`𝓕_P`).
* `BookProof.majoranaFourier` (**Prop 73**) — `𝓕_M := 𝓕_P^Θ`, a real unitary
  (`≃ₗᵢ[ℝ]`), and `majoranaFourier_symm` (**Prop 74**),
  `majoranaFourier_apply`.
* `BookProof.energyTransform` (**Prop 76**) — `𝓔`, the same conjugation of a
  (time-coordinate) Fourier transform, again a real unitary.

All statements are `sorry`-free and use no `EXTERNAL` hypothesis (Plancherel is
already in Mathlib as `Lp.fourierTransformₗᵢ`, per §A.4 of the roadmap).  The
real-linear iso `Θ` (the Pauli↔Pinor identification tensored with `L²`) is kept
as a parameter, matching the book's Def 53/54 scaffolding.
-/

namespace BookProof

open MeasureTheory

/-- **Restriction of scalars for a linear isometry equivalence.**  A
`𝕜`-linear isometry equivalence is, in particular, an `R`-linear isometry
equivalence for any compatible sub-scalar-ring `R`: the underlying linear
equivalence restricts (`LinearEquiv.restrictScalars`) and the norm-preservation
property is unchanged (norms do not depend on the scalar ring).  This is the
small helper that Mathlib lacks; it lets a real-linear map conjugate a complex
unitary. -/
noncomputable def LinearIsometryEquiv.restrictScalarsₗᵢ
    (R : Type*) {S E E' : Type*} [Semiring R] [Semiring S]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E']
    [Module R E] [Module S E] [Module R E'] [Module S E']
    [LinearMap.CompatibleSMul E E' R S] [LinearMap.CompatibleSMul E' E R S]
    (f : E ≃ₗᵢ[S] E') : E ≃ₗᵢ[R] E' where
  toLinearEquiv := f.toLinearEquiv.restrictScalars R
  norm_map' := f.norm_map'

@[simp]
theorem LinearIsometryEquiv.restrictScalarsₗᵢ_apply
    (R : Type*) {S E E' : Type*} [Semiring R] [Semiring S]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E']
    [Module R E] [Module S E] [Module R E'] [Module S E']
    [LinearMap.CompatibleSMul E E' R S] [LinearMap.CompatibleSMul E' E R S]
    (f : E ≃ₗᵢ[S] E') (x : E) :
    LinearIsometryEquiv.restrictScalarsₗᵢ R f x = f x := rfl

section Conjugation

variable {R E E' : Type*} [Semiring R]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E'] [Module R E] [Module R E']

/-- **The conjugation engine (Prop 73 / Prop 76 argument).**  Given a linear
isometry equivalence `A : E ≃ₗᵢ[R] E` (a "unitary") and a linear isometry
equivalence `Θ : E ≃ₗᵢ[R] E'`, the conjugate `A^Θ := Θ ∘ A ∘ Θ⁻¹` is again a
linear isometry equivalence `E' ≃ₗᵢ[R] E'`.  A `Θ`-conjugate of a unitary is a
unitary. -/
noncomputable def conjugateₗᵢ (Θ : E ≃ₗᵢ[R] E') (A : E ≃ₗᵢ[R] E) : E' ≃ₗᵢ[R] E' :=
  Θ.symm.trans (A.trans Θ)

@[simp]
theorem conjugateₗᵢ_apply (Θ : E ≃ₗᵢ[R] E') (A : E ≃ₗᵢ[R] E) (x : E') :
    conjugateₗᵢ Θ A x = Θ (A (Θ.symm x)) := rfl

/-- **Prop 74 (book).**  The inverse of the `Θ`-conjugate is the `Θ`-conjugate of
the inverse: `(A^Θ)⁻¹ = (A⁻¹)^Θ`.  Applied to the Pauli Fourier transform this is
`𝓕_M⁻¹ = (𝓕_P⁻¹)^Θ`. -/
@[simp]
theorem conjugateₗᵢ_symm (Θ : E ≃ₗᵢ[R] E') (A : E ≃ₗᵢ[R] E) :
    (conjugateₗᵢ Θ A).symm = conjugateₗᵢ Θ A.symm := by
  ext x
  simp [conjugateₗᵢ]

/-- Conjugation is multiplicative: `(A ∘ B)^Θ = A^Θ ∘ B^Θ`. -/
theorem conjugateₗᵢ_trans (Θ : E ≃ₗᵢ[R] E') (A B : E ≃ₗᵢ[R] E) :
    conjugateₗᵢ Θ (A.trans B) = (conjugateₗᵢ Θ A).trans (conjugateₗᵢ Θ B) := by
  ext x
  simp [conjugateₗᵢ]

/-- Conjugation of the identity is the identity. -/
@[simp]
theorem conjugateₗᵢ_refl (Θ : E ≃ₗᵢ[R] E') :
    conjugateₗᵢ Θ (LinearIsometryEquiv.refl R E) = LinearIsometryEquiv.refl R E' := by
  ext x
  simp [conjugateₗᵢ]

end Conjugation

section MajoranaFourier

variable (E F : Type*) [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
    [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

/-- The **Pauli Fourier transform `𝓕_P`** viewed as a *real* unitary: Mathlib's
complex `L²` Fourier transform `MeasureTheory.Lp.fourierTransformₗᵢ` (a
`≃ₗᵢ[ℂ]`, unitary by Plancherel) restricted to `ℝ`-linearity so that a
real-linear `Θ` may conjugate it. -/
noncomputable def pauliFourier :
    (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] (Lp F 2 (volume : Measure E)) :=
  LinearIsometryEquiv.restrictScalarsₗᵢ ℝ (Lp.fourierTransformₗᵢ E F)

variable {P : Type*} [NormedAddCommGroup P] [InnerProductSpace ℝ P]

/-- **Prop 73 (book): the Majorana–Fourier transform `𝓕_M := (𝓕_P)^Θ` is
unitary.**  Given the real-linear isometric identification
`Θ : Pauli(𝕏) ≃ₗᵢ[ℝ] Pinor(𝕏)` (Def 53/54, `Θ`-conjugation), the
Majorana–Fourier transform is the `Θ`-conjugate of the (real view of the) complex
Pauli Fourier transform; being a `Θ`-conjugate of a unitary it is itself a
unitary, i.e. an `ℝ`-linear isometry equivalence. -/
noncomputable def majoranaFourier
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P) : P ≃ₗᵢ[ℝ] P :=
  conjugateₗᵢ Θ (pauliFourier E F)

/-- **Prop 74 (book).**  `𝓕_M⁻¹ = (𝓕_P⁻¹)^Θ`: the inverse Majorana–Fourier
transform is the `Θ`-conjugate of the inverse Pauli Fourier transform. -/
theorem majoranaFourier_symm
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P) :
    (majoranaFourier E F Θ).symm = conjugateₗᵢ Θ (pauliFourier E F).symm := by
  simp [majoranaFourier]

@[simp]
theorem majoranaFourier_apply
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P) (x : P) :
    majoranaFourier E F Θ x = Θ (pauliFourier E F (Θ.symm x)) := rfl

/-- **Prop 76 (book): the Energy transform `𝓔` is unitary.**  Modelled by the
same conjugation principle: `𝓔 := Θ ∘ 𝓕_P(time) ∘ Θ⁻¹`, the `Θ`-conjugate of a
(time-coordinate) Pauli Fourier transform `𝓕_time`, hence a unitary. -/
noncomputable def energyTransform
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P)
    (fourierTime : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] (Lp F 2 (volume : Measure E))) :
    P ≃ₗᵢ[ℝ] P :=
  conjugateₗᵢ Θ fourierTime

omit [CompleteSpace F] in
theorem energyTransform_symm
    (Θ : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] P)
    (fourierTime : (Lp F 2 (volume : Measure E)) ≃ₗᵢ[ℝ] (Lp F 2 (volume : Measure E))) :
    (energyTransform E F Θ fourierTime).symm = conjugateₗᵢ Θ fourierTime.symm := by
  simp [energyTransform]

end MajoranaFourier

end BookProof

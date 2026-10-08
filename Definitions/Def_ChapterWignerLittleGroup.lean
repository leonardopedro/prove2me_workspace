import Mathlib


/-!
# Wigner's little-group classification (book.tex, Definition 78 / Proposition 79 and
§"Real unitary representations of the Poincaré group")

`BookProof.ChapterLittleGroup` formalizes the *abstract* content of Proposition 79 (the
coset description `H_k = G_l` of the little group) in an arbitrary group.  What the book
leaves as prose — and what `BookProof.ChapterA4h` still carries as the named hypothesis
`WignerClassification` — is the **concrete classification**: which momenta occur, which
subgroup of `SL(2,ℂ)` fixes each of them, and the fact that the little group only depends
on the orbit.  This file proves that classification.

## The model

We use the standard `SL(2,ℂ)` model of Minkowski space: a 4-momentum `p` is encoded by the
Hermitian matrix

  `hermOfMom p = !![p⁰+p³, p¹ - i p²; p¹ + i p², p⁰-p³]`,

so that `det (hermOfMom p) = p·p = (p⁰)² - |p⃗|²` (`hermOfMom_det`) and
`tr (hermOfMom p) = 2p⁰` (`hermOfMom_trace`).  `SL(2,ℂ)` acts by `A ⬝ X = A X A†`
(`act`), which preserves Hermiticity (`act_conjTranspose`) and the determinant, i.e. the
Minkowski square (`act_det`); this is the two-to-one covering `SL(2,ℂ) → SO⁺(1,3)`.
The **little group** of `p` (Definition 78 in this model) is the stabilizer

  `littleGroup p = {A | det A = 1 ∧ A (hermOfMom p) A† = hermOfMom p}`.

## Results

* `littleGroup_rest` — the little group of a massive rest momentum `(m,0,0,0)`, `m ≠ 0`,
  is exactly `SU(2) = {A | det A = 1 ∧ A A† = 1}`.
* `littleGroup_null` — the little group of the lightlike momentum `(1,0,0,1)` is exactly
  `{ !![a, b; 0, ā] : a ā = 1, b ∈ ℂ }`, the double cover `ℂ ⋊ U(1)` of the Euclidean
  group `SE(2)` of the plane; `nullElt_mul` is its semidirect-product multiplication law,
  `nullTranslations_*` exhibits the abelian translation subgroup `≅ (ℂ,+) ≅ ℝ²`, on which
  the rotation `a` acts by the *square* `a²` (`nullElt_conj_translation`) — the origin of
  half-integer helicity.
* `exists_boost_massive` / `exists_boost_null` — transitivity of the action on the
  massive future shell `p·p = m² > 0, p⁰ > 0` and on the future light cone
  `p·p = 0, p⁰ > 0, p ≠ 0`: every such `p` is `A·p₀A†` for an explicit `A ∈ SL(2,ℂ)`.
* `littleGroup_conj` — the little group of a transported momentum is the conjugate
  subgroup, so together with the two previous items: **every massive future momentum has
  little group conjugate to `SU(2)`, and every lightlike future momentum has little group
  conjugate to the `SE(2)` double cover** (`littleGroup_massive_conj_SU2`,
  `littleGroup_null_conj_SE2`).
* `mass_invariant` — the orbit invariant: the Minkowski square `p·p` is preserved by the
  action, so the massive shells, the light cone and the spacelike shells are unions of
  orbits (the second invariant, the sign of the energy, is not formalized here).

Everything is `sorry`-free and uses only the standard axioms.
-/

open Matrix Complex

namespace BookProof.ChapterWignerLittleGroup

/-! ## The Hermitian matrix of a 4-momentum -/

/-- The Hermitian `2×2` matrix `p⁰ + p⃗·σ⃗` attached to a 4-momentum `p`. -/
noncomputable def hermOfMom (p : Fin 4 → ℝ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(p 0 : ℂ) + (p 3 : ℂ), (p 1 : ℂ) - I * (p 2 : ℂ);
     (p 1 : ℂ) + I * (p 2 : ℂ), (p 0 : ℂ) - (p 3 : ℂ)]

@[simp] theorem hermOfMom_conjTranspose (p : Fin 4 → ℝ) :
    (hermOfMom p)ᴴ = hermOfMom p := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [hermOfMom, Matrix.conjTranspose_apply, Complex.ext_iff]





/-! ## The action of `SL(2,ℂ)` -/

/-- The action `A · X = A X A†` of `SL(2,ℂ)` on Hermitian matrices; under `hermOfMom`
this is the covering action of `SL(2,ℂ)` on Minkowski space. -/
noncomputable def act (A X : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 2) (Fin 2) ℂ := A * X * Aᴴ















/-! ## The little group -/

/-- **Definition 78 in the `SL(2,ℂ)` model.** The little group of the momentum `p` is its
stabilizer in `SL(2,ℂ)`. -/
def littleGroup (p : Fin 4 → ℝ) : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | A.det = 1 ∧ act A (hermOfMom p) = hermOfMom p}

/-- `SU(2)`, the little group of a massive particle at rest. -/
def SU2 : Set (Matrix (Fin 2) (Fin 2) ℂ) := {A | A.det = 1 ∧ A * Aᴴ = 1}

/-- The double cover `ℂ ⋊ U(1)` of the Euclidean group `SE(2)`: the little group of a
lightlike momentum. -/
def SE2 : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | ∃ a b : ℂ, a * (starRingEnd ℂ) a = 1 ∧ A = !![a, b; 0, (starRingEnd ℂ) a]}ré group")

`BookProof.ChapterLittleGroup` formalizes the *abstract* content of Proposition 79 (the
coset description `H_k = G_l` of the little group) in an arbitrary group.  What the book
leaves as prose — and what `BookProof.ChapterA4h` still carries as the named hypothesis
`WignerClassification` — is the **concrete classification**: which momenta occur, which
subgroup of `SL(2,ℂ)` fixes each of them, and the fact that the little group only depends
on the orbit.  This file proves that classification.

## The model

We use the standard `SL(2,ℂ)` model of Minkowski space: a 4-momentum `p` is encoded by the
Hermitian matrix

  `hermOfMom p = !![p⁰+p³, p¹ - i p²; p¹ + i p², p⁰-p³]`,

so that `det (hermOfMom p) = p·p = (p⁰)² - |p⃗|²` (`hermOfMom_det`) and
`tr (hermOfMom p) = 2p⁰` (`hermOfMom_trace`).  `SL(2,ℂ)` acts by `A ⬝ X = A X A†`
(`act`), which preserves Hermiticity (`act_conjTranspose`) and the determinant, i.e. the
Minkowski square (`act_det`); this is the two-to-one covering `SL(2,ℂ) → SO⁺(1,3)`.
The **little group** of `p` (Definition 78 in this model) is the stabilizer

  `littleGroup p = {A | det A = 1 ∧ A (hermOfMom p) A† = hermOfMom p}`.

## Results

* `littleGroup_rest` — the little group of a massive rest momentum `(m,0,0,0)`, `m ≠ 0`,
  is exactly `SU(2) = {A | det A = 1 ∧ A A† = 1}`.
* `littleGroup_null` — the little group of the lightlike momentum `(1,0,0,1)` is exactly
  `{ !![a, b; 0, ā] : a ā = 1, b ∈ ℂ }`, the double cover `ℂ ⋊ U(1)` of the Euclidean
  group `SE(2)` of the plane; `nullElt_mul` is its semidirect-product multiplication law,
  `nullTranslations_*` exhibits the abelian translation subgroup `≅ (ℂ,+) ≅ ℝ²`, on which
  the rotation `a` acts by the *square* `a²` (`nullElt_conj_translation`) — the origin of
  half-integer helicity.
* `exists_boost_massive` / `exists_boost_null` — transitivity of the action on the
  massive future shell `p·p = m² > 0, p⁰ > 0` and on the future light cone
  `p·p = 0, p⁰ > 0, p ≠ 0`: every such `p` is `A·p₀A†` for an explicit `A ∈ SL(2,ℂ)`.
* `littleGroup_conj` — the little group of a transported momentum is the conjugate
  subgroup, so together with the two previous items: **every massive future momentum has
  little group conjugate to `SU(2)`, and every lightlike future momentum has little group
  conjugate to the `SE(2)` double cover** (`littleGroup_massive_conj_SU2`,
  `littleGroup_null_conj_SE2`).
* `mass_invariant` — the orbit invariant: the Minkowski square `p·p` is preserved by the
  action, so the massive shells, the light cone and the spacelike shells are unions of
  orbits (the second invariant, the sign of the energy, is not formalized here).

Everything is `sorry`-free and uses only the standard axioms.
-/

open Matrix Complex

namespace BookProof.ChapterWignerLittleGroup

/-! ## The Hermitian matrix of a 4-momentum -/

/-- The Hermitian `2×2` matrix `p⁰ + p⃗·σ⃗` attached to a 4-momentum `p`. -/
noncomputable def hermOfMom (p : Fin 4 → ℝ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(p 0 : ℂ) + (p 3 : ℂ), (p 1 : ℂ) - I * (p 2 : ℂ);
     (p 1 : ℂ) + I * (p 2 : ℂ), (p 0 : ℂ) - (p 3 : ℂ)]

@[simp] theorem hermOfMom_conjTranspose (p : Fin 4 → ℝ) :
    (hermOfMom p)ᴴ = hermOfMom p := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [hermOfMom, Matrix.conjTranspose_apply, Complex.ext_iff]

/-- The determinant of `hermOfMom p` is the Minkowski square `p·p`. -/
theorem hermOfMom_det (p : Fin 4 → ℝ) :
    (hermOfMom p).det = ((p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 : ℝ) : ℂ) := by
  simp only [hermOfMom, Matrix.det_fin_two_of]
  push_cast
  ring_nf
  simp [Complex.I_sq]
  ring

/-- The trace of `hermOfMom p` is twice the energy. -/
theorem hermOfMom_trace (p : Fin 4 → ℝ) :
    (hermOfMom p).trace = ((2 * p 0 : ℝ) : ℂ) := by
  simp [hermOfMom, Matrix.trace_fin_two_of]
  ring

/-! ## The action of `SL(2,ℂ)` -/

/-- The action `A · X = A X A†` of `SL(2,ℂ)` on Hermitian matrices; under `hermOfMom`
this is the covering action of `SL(2,ℂ)` on Minkowski space. -/
noncomputable def act (A X : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 2) (Fin 2) ℂ := A * X * Aᴴ

theorem act_conjTranspose (A X : Matrix (Fin 2) (Fin 2) ℂ) (hX : Xᴴ = X) :
    (act A X)ᴴ = act A X := by
  simp [act, Matrix.conjTranspose_mul, hX, Matrix.mul_assoc]

theorem act_det (A X : Matrix (Fin 2) (Fin 2) ℂ) :
    (act A X).det = A.det * X.det * (starRingEnd ℂ) A.det := by
  simp [act, Matrix.det_mul, Matrix.det_conjTranspose]

theorem act_det_of_sl (A X : Matrix (Fin 2) (Fin 2) ℂ) (hA : A.det = 1) :
    (act A X).det = X.det := by
  rw [act_det, hA]; simp

theorem act_one (X : Matrix (Fin 2) (Fin 2) ℂ) : act 1 X = X := by
  simp [act]

/-- Cayley–Hamilton in dimension two. -/
theorem sq_two (M : Matrix (Fin 2) (Fin 2) ℂ) :
    M * M = M.trace • M - M.det • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two, Matrix.trace_fin_two, Matrix.det_fin_two] <;> ring

theorem act_mul (A B X : Matrix (Fin 2) (Fin 2) ℂ) :
    act (A * B) X = act A (act B X) := by
  simp [act, Matrix.conjTranspose_mul, Matrix.mul_assoc]

/-- The Minkowski square is an invariant of the `SL(2,ℂ)` action (mass invariance). -/
theorem mass_invariant {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) {p q : Fin 4 → ℝ}
    (h : act A (hermOfMom p) = hermOfMom q) :
    q 0 ^ 2 - q 1 ^ 2 - q 2 ^ 2 - q 3 ^ 2 = p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 := by
  have := congrArg Matrix.det h
  rw [act_det_of_sl _ _ hA, hermOfMom_det, hermOfMom_det] at this
  exact_mod_cast this.symm

/-! ## The little group -/

/-- **Definition 78 in the `SL(2,ℂ)` model.** The little group of the momentum `p` is its
stabilizer in `SL(2,ℂ)`. -/
def littleGroup (p : Fin 4 → ℝ) : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | A.det = 1 ∧ act A (hermOfMom p) = hermOfMom p}

/-- `SU(2)`, the little group of a massive particle at rest. -/
def SU2 : Set (Matrix (Fin 2) (Fin 2) ℂ) := {A | A.det = 1 ∧ A * Aᴴ = 1}

/-- The double cover `ℂ ⋊ U(1)` of the Euclidean group `SE(2)`: the little group of a
lightlike momentum. -/
def SE2 : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | ∃ a b : ℂ, a * (starRingEnd ℂ) a = 1 ∧ A = !![a, b; 0, (starRingEnd ℂ) a]}

/-- The rest momentum `(m,0,0,0)`. -/
def restMom (m : ℝ) : Fin 4 → ℝ := ![m, 0, 0, 0]

/-- The reference lightlike momentum `(1,0,0,1)`. -/
def nullMom : Fin 4 → ℝ := ![1, 0, 0, 1]

theorem hermOfMom_restMom (m : ℝ) :
    hermOfMom (restMom m) = (m : ℂ) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom, restMom]







/-! ### The semidirect structure of the null little group -/

/-- The generic element of the null little group: rotation `a` (with `a ā = 1`) and
translation `b`. -/
def nullElt (a b : ℂ) : Matrix (Fin 2) (Fin 2) ℂ := !![a, b; 0, (starRingEnd ℂ) a]









/-! ## Transitivity on the mass shells -/





/-! ## Conjugacy of little groups along an orbit -/



terA4h` still carries as the named hypothesis
`WignerClassification` — is the **concrete classification**: which momenta occur, which
subgroup of `SL(2,ℂ)` fixes each of them, and the fact that the little group only depends
on the orbit.  This file proves that classification.

## The model

We use the standard `SL(2,ℂ)` model of Minkowski space: a 4-momentum `p` is encoded by the
Hermitian matrix

  `hermOfMom p = !![p⁰+p³, p¹ - i p²; p¹ + i p², p⁰-p³]`,

so that `det (hermOfMom p) = p·p = (p⁰)² - |p⃗|²` (`hermOfMom_det`) and
`tr (hermOfMom p) = 2p⁰` (`hermOfMom_trace`).  `SL(2,ℂ)` acts by `A ⬝ X = A X A†`
(`act`), which preserves Hermiticity (`act_conjTranspose`) and the determinant, i.e. the
Minkowski square (`act_det`); this is the two-to-one covering `SL(2,ℂ) → SO⁺(1,3)`.
The **little group** of `p` (Definition 78 in this model) is the stabilizer

  `littleGroup p = {A | det A = 1 ∧ A (hermOfMom p) A† = hermOfMom p}`.

## Results

* `littleGroup_rest` — the little group of a massive rest momentum `(m,0,0,0)`, `m ≠ 0`,
  is exactly `SU(2) = {A | det A = 1 ∧ A A† = 1}`.
* `littleGroup_null` — the little group of the lightlike momentum `(1,0,0,1)` is exactly
  `{ !![a, b; 0, ā] : a ā = 1, b ∈ ℂ }`, the double cover `ℂ ⋊ U(1)` of the Euclidean
  group `SE(2)` of the plane; `nullElt_mul` is its semidirect-product multiplication law,
  `nullTranslations_*` exhibits the abelian translation subgroup `≅ (ℂ,+) ≅ ℝ²`, on which
  the rotation `a` acts by the *square* `a²` (`nullElt_conj_translation`) — the origin of
  half-integer helicity.
* `exists_boost_massive` / `exists_boost_null` — transitivity of the action on the
  massive future shell `p·p = m² > 0, p⁰ > 0` and on the future light cone
  `p·p = 0, p⁰ > 0, p ≠ 0`: every such `p` is `A·p₀A†` for an explicit `A ∈ SL(2,ℂ)`.
* `littleGroup_conj` — the little group of a transported momentum is the conjugate
  subgroup, so together with the two previous items: **every massive future momentum has
  little group conjugate to `SU(2)`, and every lightlike future momentum has little group
  conjugate to the `SE(2)` double cover** (`littleGroup_massive_conj_SU2`,
  `littleGroup_null_conj_SE2`).
* `mass_invariant` — the orbit invariant: the Minkowski square `p·p` is preserved by the
  action, so the massive shells, the light cone and the spacelike shells are unions of
  orbits (the second invariant, the sign of the energy, is not formalized here).

Everything is `sorry`-free and uses only the standard axioms.
-/

open Matrix Complex

namespace BookProof.ChapterWignerLittleGroup

/-! ## The Hermitian matrix of a 4-momentum -/

/-- The Hermitian `2×2` matrix `p⁰ + p⃗·σ⃗` attached to a 4-momentum `p`. -/
noncomputable def hermOfMom (p : Fin 4 → ℝ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![(p 0 : ℂ) + (p 3 : ℂ), (p 1 : ℂ) - I * (p 2 : ℂ);
     (p 1 : ℂ) + I * (p 2 : ℂ), (p 0 : ℂ) - (p 3 : ℂ)]

@[simp] theorem hermOfMom_conjTranspose (p : Fin 4 → ℝ) :
    (hermOfMom p)ᴴ = hermOfMom p := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [hermOfMom, Matrix.conjTranspose_apply, Complex.ext_iff]

/-- The determinant of `hermOfMom p` is the Minkowski square `p·p`. -/
theorem hermOfMom_det (p : Fin 4 → ℝ) :
    (hermOfMom p).det = ((p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 : ℝ) : ℂ) := by
  simp only [hermOfMom, Matrix.det_fin_two_of]
  push_cast
  ring_nf
  simp [Complex.I_sq]
  ring

/-- The trace of `hermOfMom p` is twice the energy. -/
theorem hermOfMom_trace (p : Fin 4 → ℝ) :
    (hermOfMom p).trace = ((2 * p 0 : ℝ) : ℂ) := by
  simp [hermOfMom, Matrix.trace_fin_two_of]
  ring

/-! ## The action of `SL(2,ℂ)` -/

/-- The action `A · X = A X A†` of `SL(2,ℂ)` on Hermitian matrices; under `hermOfMom`
this is the covering action of `SL(2,ℂ)` on Minkowski space. -/
noncomputable def act (A X : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 2) (Fin 2) ℂ := A * X * Aᴴ

theorem act_conjTranspose (A X : Matrix (Fin 2) (Fin 2) ℂ) (hX : Xᴴ = X) :
    (act A X)ᴴ = act A X := by
  simp [act, Matrix.conjTranspose_mul, hX, Matrix.mul_assoc]

theorem act_det (A X : Matrix (Fin 2) (Fin 2) ℂ) :
    (act A X).det = A.det * X.det * (starRingEnd ℂ) A.det := by
  simp [act, Matrix.det_mul, Matrix.det_conjTranspose]

theorem act_det_of_sl (A X : Matrix (Fin 2) (Fin 2) ℂ) (hA : A.det = 1) :
    (act A X).det = X.det := by
  rw [act_det, hA]; simp

theorem act_one (X : Matrix (Fin 2) (Fin 2) ℂ) : act 1 X = X := by
  simp [act]

/-- Cayley–Hamilton in dimension two. -/
theorem sq_two (M : Matrix (Fin 2) (Fin 2) ℂ) :
    M * M = M.trace • M - M.det • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Matrix.mul_apply, Fin.sum_univ_two, Matrix.trace_fin_two, Matrix.det_fin_two] <;> ring

theorem act_mul (A B X : Matrix (Fin 2) (Fin 2) ℂ) :
    act (A * B) X = act A (act B X) := by
  simp [act, Matrix.conjTranspose_mul, Matrix.mul_assoc]

/-- The Minkowski square is an invariant of the `SL(2,ℂ)` action (mass invariance). -/
theorem mass_invariant {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) {p q : Fin 4 → ℝ}
    (h : act A (hermOfMom p) = hermOfMom q) :
    q 0 ^ 2 - q 1 ^ 2 - q 2 ^ 2 - q 3 ^ 2 = p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 := by
  have := congrArg Matrix.det h
  rw [act_det_of_sl _ _ hA, hermOfMom_det, hermOfMom_det] at this
  exact_mod_cast this.symm

/-! ## The little group -/

/-- **Definition 78 in the `SL(2,ℂ)` model.** The little group of the momentum `p` is its
stabilizer in `SL(2,ℂ)`. -/
def littleGroup (p : Fin 4 → ℝ) : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | A.det = 1 ∧ act A (hermOfMom p) = hermOfMom p}

/-- `SU(2)`, the little group of a massive particle at rest. -/
def SU2 : Set (Matrix (Fin 2) (Fin 2) ℂ) := {A | A.det = 1 ∧ A * Aᴴ = 1}

/-- The double cover `ℂ ⋊ U(1)` of the Euclidean group `SE(2)`: the little group of a
lightlike momentum. -/
def SE2 : Set (Matrix (Fin 2) (Fin 2) ℂ) :=
  {A | ∃ a b : ℂ, a * (starRingEnd ℂ) a = 1 ∧ A = !![a, b; 0, (starRingEnd ℂ) a]}

/-- The rest momentum `(m,0,0,0)`. -/
def restMom (m : ℝ) : Fin 4 → ℝ := ![m, 0, 0, 0]

/-- The reference lightlike momentum `(1,0,0,1)`. -/
def nullMom : Fin 4 → ℝ := ![1, 0, 0, 1]

theorem hermOfMom_restMom (m : ℝ) :
    hermOfMom (restMom m) = (m : ℂ) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [hermOfMom, restMom]

theorem hermOfMom_nullMom : hermOfMom nullMom = !![(2 : ℂ), 0; 0, 0] := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [hermOfMom, nullMom, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.tail_cons]

/-- **The massive little group is `SU(2)`.** -/
theorem littleGroup_rest {m : ℝ} (hm : m ≠ 0) : littleGroup (restMom m) = SU2 := by
  have hm' : (m : ℂ) ≠ 0 := by exact_mod_cast hm
  ext A
  simp only [littleGroup, SU2, Set.mem_setOf_eq, hermOfMom_restMom, act]
  constructor
  · rintro ⟨hdet, h⟩
    refine ⟨hdet, ?_⟩
    have h2 : (m : ℂ) • (A * Aᴴ) = (m : ℂ) • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
      rw [← h, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_one]
    exact smul_right_injective _ hm' h2
  · rintro ⟨hdet, h⟩
    exact ⟨hdet, by rw [Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_one, h]⟩

/-- **The lightlike little group is the `SE(2)` double cover.** -/
theorem littleGroup_null : littleGroup nullMom = SE2 := by
  ext A
  simp only [littleGroup, SE2, Set.mem_setOf_eq, hermOfMom_nullMom, act]
  constructor
  · rintro ⟨hdet, h⟩
    have hdet' : A 0 0 * A 1 1 - A 0 1 * A 1 0 = 1 := by
      rw [Matrix.det_fin_two] at hdet; exact hdet
    have h11 : A 1 0 = 0 := by
      simpa [Matrix.mul_apply, Fin.sum_univ_two, Matrix.conjTranspose_apply] using
        congrFun (congrFun h 1) 1
    have h00 : A 0 0 * 2 * (starRingEnd ℂ) (A 0 0) = 2 := by
      simpa [Matrix.mul_apply, Fin.sum_univ_two, Matrix.conjTranspose_apply] using
        congrFun (congrFun h 0) 0
    have ha : A 0 0 * (starRingEnd ℂ) (A 0 0) = 1 := by linear_combination h00 / 2
    have h0 : A 0 0 ≠ 0 := by
      intro h0
      rw [h0] at ha; simp at ha
    have h1 : A 1 1 = (starRingEnd ℂ) (A 0 0) := by
      have hmul : A 0 0 * A 1 1 = 1 := by rw [h11] at hdet'; linear_combination hdet'
      refine mul_left_cancel₀ h0 ?_
      rw [hmul, ha]
    refine ⟨A 0 0, A 0 1, ha, ?_⟩
    ext i j
    fin_cases i <;> fin_cases j <;> simp [h11, h1]
  · rintro ⟨a, b, ha, rfl⟩
    refine ⟨by simp [Matrix.det_fin_two_of]; linear_combination ha, ?_⟩
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply, Fin.sum_univ_two, Matrix.conjTranspose_apply]
    linear_combination 2 * ha

/-! ### The semidirect structure of the null little group -/

/-- The generic element of the null little group: rotation `a` (with `a ā = 1`) and
translation `b`. -/
def nullElt (a b : ℂ) : Matrix (Fin 2) (Fin 2) ℂ := !![a, b; 0, (starRingEnd ℂ) a]

/-- Multiplication law of the null little group: the semidirect product `ℂ ⋊ U(1)`. -/
theorem nullElt_mul (a b a' b' : ℂ) :
    nullElt a b * nullElt a' b' = nullElt (a * a') (a * b' + b * (starRingEnd ℂ) a') := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [nullElt, Matrix.mul_apply, Fin.sum_univ_two]

/-- The translations `b ↦ nullElt 1 b` form an abelian subgroup isomorphic to `(ℂ,+) ≅ ℝ²`:
the translation subgroup of `SE(2)`. -/
theorem nullTranslations_mul (b b' : ℂ) :
    nullElt 1 b * nullElt 1 b' = nullElt 1 (b + b') := by
  rw [nullElt_mul]; simp [add_comm]

theorem nullTranslations_comm (b b' : ℂ) :
    nullElt 1 b * nullElt 1 b' = nullElt 1 b' * nullElt 1 b := by
  rw [nullTranslations_mul, nullTranslations_mul, add_comm b' b]

/-- A rotation acts on the translation subgroup by the **square** of its phase: this is the
double cover `ℂ ⋊ U(1) → SE(2)` and the source of half-integer helicity. -/
theorem nullElt_conj_translation (a b : ℂ) (ha : a * (starRingEnd ℂ) a = 1) :
    nullElt a 0 * nullElt 1 b * nullElt ((starRingEnd ℂ) a) 0 = nullElt 1 (a * a * b) := by
  have h : (starRingEnd ℂ) ((starRingEnd ℂ) a) = a := by simp
  rw [nullElt_mul, nullElt_mul, h]
  simp only [nullElt]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [ha, mul_comm, mul_left_comm]

/-! ## Transitivity on the mass shells -/

/-- **The massive shell is one orbit.** Every future-pointing `p` with `p·p = m² > 0` is
obtained from the rest momentum `(m,0,0,0)` by an explicit element of `SL(2,ℂ)`, namely
`A = (X + m)/√(2m(p⁰+m))` with `X = hermOfMom p` (the "square root of the boost"). -/
theorem exists_boost_massive {m : ℝ} (hm : 0 < m) (p : Fin 4 → ℝ) (hp0 : 0 < p 0)
    (hshell : p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 = m ^ 2) :
    ∃ A : Matrix (Fin 2) (Fin 2) ℂ, A.det = 1 ∧
      act A (hermOfMom (restMom m)) = hermOfMom p := by
  have hs : ((p 0 : ℂ)) ^ 2 - (p 1 : ℂ) ^ 2 - (p 2 : ℂ) ^ 2 - (p 3 : ℂ) ^ 2 = (m : ℂ) ^ 2 := by
    exact_mod_cast congrArg (fun x : ℝ => (x : ℂ)) hshell
  have hm0 : (m : ℂ) ≠ 0 := by exact_mod_cast ne_of_gt hm
  have hpm : ((p 0 : ℂ) + (m : ℂ)) ≠ 0 := by
    have h : ((p 0 + m : ℝ) : ℂ) ≠ 0 := by
      exact_mod_cast ne_of_gt (by linarith : (0:ℝ) < p 0 + m)
    push_cast at h; exact h
  rw [hermOfMom_restMom]
  set M : Matrix (Fin 2) (Fin 2) ℂ := hermOfMom p + (m : ℂ) • 1 with hM
  have hMdet : M.det = ((2 * m * (p 0 + m) : ℝ) : ℂ) := by
    simp [hM, hermOfMom, Matrix.det_fin_two]
    linear_combination hs + (p 2 : ℂ) ^ 2 * Complex.I_sq
  have hMtr : M.trace = ((2 * (p 0 + m) : ℝ) : ℂ) := by
    simp [hM, hermOfMom, Matrix.trace_fin_two]
    ring
  have hMherm : Mᴴ = M := by
    simp [hM, Matrix.conjTranspose_add, hermOfMom_conjTranspose, Matrix.conjTranspose_smul]
  set c : ℝ := Real.sqrt (1 / (2 * (p 0 + m) * m)) with hc
  have hc2 : c ^ 2 = 1 / (2 * (p 0 + m) * m) := Real.sq_sqrt (by positivity)
  have hcC : ((c : ℂ)) * (c : ℂ) = ((1 / (2 * (p 0 + m) * m) : ℝ) : ℂ) := by
    rw [← hc2]; push_cast; ring
  have hMM : M * M = ((2 * (p 0 + m) : ℝ) : ℂ) • hermOfMom p := by
    rw [sq_two, hMtr, hMdet, hM, smul_add, smul_smul]
    push_cast
    module
  have hscal : ((c : ℂ) * (c : ℂ) * (m : ℂ)) * ((2 * (p 0 + m) : ℝ) : ℂ) = 1 := by
    rw [hcC]; push_cast; field_simp
  refine ⟨(c : ℂ) • M, ?_, ?_⟩
  · rw [Matrix.det_smul, hMdet]
    simp only [Fintype.card_fin, pow_two]
    rw [hcC]
    push_cast
    field_simp
  · simp only [act, Matrix.conjTranspose_smul, hMherm, Complex.star_def, Complex.conj_ofReal,
      Matrix.smul_mul, Matrix.mul_smul, Matrix.mul_one, smul_smul, hMM]
    refine Eq.trans ?_ (one_smul ℂ (hermOfMom p))
    congr 1
    linear_combination hscal

/-- **The future light cone is one orbit.** Every `p` with `p·p = 0` and `p⁰ > 0` is
obtained from `(1,0,0,1)` by an explicit element of `SL(2,ℂ)`. -/
theorem exists_boost_null (p : Fin 4 → ℝ) (hp0 : 0 < p 0)
    (hshell : p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 = 0) :
    ∃ A : Matrix (Fin 2) (Fin 2) ℂ, A.det = 1 ∧ act A (hermOfMom nullMom) = hermOfMom p := by
  have hs : ((p 0 : ℂ)) ^ 2 - (p 1 : ℂ) ^ 2 - (p 2 : ℂ) ^ 2 - (p 3 : ℂ) ^ 2 = 0 := by
    exact_mod_cast congrArg (fun x : ℝ => (x : ℂ)) hshell
  have hconj2 : (starRingEnd ℂ) 2 = 2 := by
    rw [show ((2 : ℂ)) = ((2 : ℝ) : ℂ) by norm_num, Complex.conj_ofReal]
  rw [hermOfMom_nullMom]
  by_cases hpp : 0 < p 0 + p 3
  · -- generic case: the first column of `A` is the square root of the null direction
    set t : ℝ := Real.sqrt ((p 0 + p 3) / 2) with ht
    have ht2 : t ^ 2 = (p 0 + p 3) / 2 := Real.sq_sqrt (by positivity)
    have ht2C : (t : ℂ) ^ 2 = ((p 0 : ℂ) + (p 3 : ℂ)) / 2 := by
      have h := congrArg (fun x : ℝ => (x : ℂ)) ht2
      push_cast at h; exact h
    have htpos : 0 < t := Real.sqrt_pos.mpr (by positivity)
    have ht0 : (t : ℂ) ≠ 0 := by exact_mod_cast ne_of_gt htpos
    refine ⟨!![(t : ℂ), 0; ((p 1 : ℂ) + I * (p 2 : ℂ)) / (2 * t), (1 / t : ℂ)], ?_, ?_⟩
    · rw [Matrix.det_fin_two_of]
      field_simp
      ring
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [act, hermOfMom, Matrix.mul_apply, Fin.sum_univ_two, Matrix.conjTranspose_apply] <;>
        field_simp
      · linear_combination 2 * ht2C
      · rw [hconj2]; ring
      · rw [hconj2]
        linear_combination -hs - (p 2 : ℂ) ^ 2 * Complex.I_sq
          - 2 * ((p 0 : ℂ) - (p 3 : ℂ)) * ht2C
  · -- degenerate case `p⁰ + p³ = 0`: then `p⃗` points along `-z` and `p¹ = p² = 0`
    push_neg at hpp
    have h1 : p 1 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2)]
    have h2 : p 2 = 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2)]
    have h3 : p 3 = -p 0 := by nlinarith [sq_nonneg (p 1), sq_nonneg (p 2)]
    set w : ℝ := Real.sqrt (p 0) with hw
    have hw2 : w ^ 2 = p 0 := Real.sq_sqrt (le_of_lt hp0)
    have hw2C : (w : ℂ) ^ 2 = (p 0 : ℂ) := by
      have h := congrArg (fun x : ℝ => (x : ℂ)) hw2
      push_cast at h; exact h
    have hwpos : 0 < w := Real.sqrt_pos.mpr hp0
    have hw0 : (w : ℂ) ≠ 0 := by exact_mod_cast ne_of_gt hwpos
    refine ⟨!![0, -(1 / w : ℂ); (w : ℂ), 0], ?_, ?_⟩
    · rw [Matrix.det_fin_two_of]
      field_simp
      norm_num
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [act, hermOfMom, Matrix.mul_apply, Fin.sum_univ_two, Matrix.conjTranspose_apply,
          h1, h2, h3]
      all_goals linear_combination 2 * hw2C

/-! ## Conjugacy of little groups along an orbit -/

/-- Transporting a momentum conjugates its little group: the little group only depends on
the orbit, up to conjugacy. -/
theorem littleGroup_conj {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) {p q : Fin 4 → ℝ}
    (h : act A (hermOfMom p) = hermOfMom q) :
    littleGroup q = (fun B => A * B * A⁻¹) '' littleGroup p := by
  have hunit : IsUnit A.det := by rw [hA]; exact isUnit_one
  have hAinv : A * A⁻¹ = 1 := Matrix.mul_nonsing_inv A hunit
  have hinvA : A⁻¹ * A = 1 := Matrix.nonsing_inv_mul A hunit
  have hdetinv : (A⁻¹).det = 1 := by
    rw [Matrix.det_nonsing_inv, hA]; simp
  have hcancelL : ∀ M : Matrix (Fin 2) (Fin 2) ℂ, A * (A⁻¹ * M) = M := fun M => by
    rw [← Matrix.mul_assoc, hAinv, Matrix.one_mul]
  have hactL : ∀ X : Matrix (Fin 2) (Fin 2) ℂ, act A⁻¹ (act A X) = X := fun X => by
    rw [← act_mul, hinvA, act_one]
  ext C
  constructor
  · rintro ⟨hCdet, hC⟩
    refine ⟨A⁻¹ * C * A, ⟨?_, ?_⟩, ?_⟩
    · rw [Matrix.det_mul, Matrix.det_mul, hCdet, hdetinv, hA]; ring
    · rw [act_mul, act_mul, h, hC, ← h, hactL]
    · change A * (A⁻¹ * C * A) * A⁻¹ = C
      calc A * (A⁻¹ * C * A) * A⁻¹ = A * (A⁻¹ * (C * (A * A⁻¹))) := by noncomm_ring
        _ = C := by rw [hAinv, Matrix.mul_one, hcancelL]
  · rintro ⟨B, ⟨hBdet, hB⟩, rfl⟩
    refine ⟨?_, ?_⟩
    · rw [Matrix.det_mul, Matrix.det_mul, hBdet, hdetinv, hA]; ring
    · rw [act_mul, act_mul, ← h, hactL, hB, h]

/-- **Little-group classification, massive case.** For every future-pointing momentum on
the shell `p·p = m² > 0`, the little group is conjugate in `SL(2,ℂ)` to `SU(2)`. -/
theorem littleGroup_massive_conj_SU2 {m : ℝ} (hm : 0 < m) (p : Fin 4 → ℝ) (hp0 : 0 < p 0)
    (hshell : p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 = m ^ 2) :
    ∃ A : Matrix (Fin 2) (Fin 2) ℂ, A.det = 1 ∧
      littleGroup p = (fun B => A * B * A⁻¹) '' SU2 := by
  obtain ⟨A, hA, hAp⟩ := exists_boost_massive hm p hp0 hshell
  exact ⟨A, hA, by rw [littleGroup_conj hA hAp, littleGroup_rest (ne_of_gt hm)]⟩

/-- **Little-group classification, massless case.** For every future-pointing lightlike
momentum, the little group is conjugate in `SL(2,ℂ)` to the `SE(2)` double cover. -/
theorem littleGroup_null_conj_SE2 (p : Fin 4 → ℝ) (hp0 : 0 < p 0)
    (hshell : p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 = 0) :
    ∃ A : Matrix (Fin 2) (Fin 2) ℂ, A.det = 1 ∧
      littleGroup p = (fun B => A * B * A⁻¹) '' SE2 := by
  obtain ⟨A, hA, hAp⟩ := exists_boost_null p hp0 hshell
  exact ⟨A, hA, by rw [littleGroup_conj hA hAp, littleGroup_null]⟩

end BookProof.ChapterWignerLittleGroup

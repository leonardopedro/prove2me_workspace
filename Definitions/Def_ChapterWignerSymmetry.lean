import Mathlib


/-!
# Wigner's symmetry theorem (book.tex, §"Unitary representations of the Poincaré group")

`book.tex` uses Wigner's theorem repeatedly, always as an external citation:

> "According to Wigner's theorem, the most general transformations, leaving invariant the
> modulus of the internal product of a Hilbert space, are: unitary or anti-unitary
> operators, defined up to a complex phase, for a complex Hilbert space."

This file **proves** that statement for a complex inner-product space with a finite
orthonormal basis — in particular for every finite-dimensional complex Hilbert space
(`wigner_symmetry`).

## Statement

A **Wigner symmetry** is a map `T : E → E` with `‖⟪T x, T y⟫‖ = ‖⟪x, y⟫‖` for all `x, y`:
no linearity, continuity or surjectivity is assumed, only that all transition
probabilities are preserved.  The theorem produces one linear **or** one conjugate-linear
isometry `U` such that every `T x` equals `U x` up to a phase depending on `x`.

## The proof

*Part I* is the algebraic core, stated for a map `S : (ι → ℂ) → (ι → ℂ)` of coordinate
vectors that preserves the modulus of the standard inner product (`inner_norm`) and of
each coordinate (`coord_norm`), and is normalized so that the two nonzero coordinates of
`S (δ₀ + δᵢ)` agree (`normalized`; this is achieved by rephasing the image basis):

* `modulus_add` — `‖S v o + S v i‖ = ‖v o + v i‖`;
* `exists_zeta` — the vector `δ₀ + i δᵢ` produces a sign `ζᵢ = ±i`;
* `key_index` — hence for each `i`, either `conj (S v o) * S v i = conj (v o) * v i` for
  **all** `v`, or `conj (S v o) * S v i = conj (conj (v o) * v i)` for all `v`;
* `key_consistent` — the alternative is the same for all indices (otherwise the transition
  probability between `δ₀ + δᵢ + δⱼ` and `δ₀ + i δᵢ + i δⱼ` would change from `√5` to `1`);
* `coord_of_key`, `wigner_coord` — therefore `S v = lam • v` for all `v`, or
  `S v = lam • conj v` for all `v`, with `‖lam‖ = 1` depending on `v`.  The case
  `v o = 0` is settled by the equality case of the triangle inequality.

*Part II* transports this to a Hilbert space with an orthonormal basis: the images of the
basis vectors are orthonormal, hence an orthonormal basis; their phases are fixed with the
vectors `b₀ + bᵢ`; and the coordinate map of `T` in these two bases satisfies the
hypotheses of Part I.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace ComplexConjugate
open Finset

namespace BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- A **Wigner symmetry**: a map of the Hilbert space preserving all transition
probabilities `|⟪x, y⟫|`. -/
def IsWignerSymmetry (T : E → E) : Prop := ∀ x y : E, ‖⟪T x, T y⟫_ℂ‖ = ‖⟪x, y⟫_ℂ‖

variable {T : E → E}

/-- A Wigner symmetry preserves norms. -/
theorem norm_map (hT : IsWignerSymmetry T) (x : E) : ‖T x‖ = ‖x‖ := by
  have h := hT x x
  rw [inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K] at h
  simpa using h



/-! ### Two complex-number identities behind the key relation -/







/-! ## Part I — the algebraic core in coordinates -/

section Coord

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The coordinate vector `δ_o + δ_i`. -/
def pairCoord (o i : ι) : ι → ℂ := fun k => if k = o then 1 else if k = i then 1 else 0

/-- The coordinate vector `δ_o + i·δ_i`. -/
def pairCoordI (o i : ι) : ι → ℂ := fun k => if k = o then 1 else if k = i then Complex.I else 0

/-- The coordinate vector `δ_o + z·δ_i + z·δ_j`. -/
def tripleCoord (o i j : ι) (z : ℂ) : ι → ℂ :=
  fun k => if k = o then 1 else if k = i then z else if k = j then z else 0







/-- The hypotheses of Wigner's theorem in coordinates. -/
structure WignerCoord (S : (ι → ℂ) → (ι → ℂ)) (o : ι) : Prop where
  /-- The modulus of the standard inner product is preserved. -/
  inner_norm : ∀ v w, ‖∑ k, conj (S v k) * S w k‖ = ‖∑ k, conj (v k) * w k‖
  /-- The modulus of each coordinate is preserved. -/
  coord_norm : ∀ v k, ‖S v k‖ = ‖v k‖
  /-- The image basis has been rephased so that `S (δ_o + δ_i)` has equal coordinates. -/
  normalized : ∀ i, i ≠ o → S (pairCoord o i) o = S (pairCoord o i) i

variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}





















end Coord


/-! ## Part II — transport to a Hilbert space

Part I is stated for coordinate vectors.  We now feed it with the coordinates of `T` in the
orthonormal basis `b` (source) and in the *rephased* image family `imgVec` (target). -/

section Hilbert

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- An **antiunitary operator**: additive, conjugate-homogeneous, surjective, and conjugating
the inner product.  (Norms are automatically preserved, by `inner_conj` with `y = x`.) -/
structure IsAntiunitary (U : E → E) : Prop where
  /-- Antiunitary operators are additive. -/
  map_add : ∀ x y, U (x + y) = U x + U y
  /-- Antiunitary operators are conjugate-homogeneous. -/
  map_smul : ∀ (a : ℂ) (x : E), U (a • x) = conj a • U x
  /-- Antiunitary operators conjugate the inner product. -/
  inner_conj : ∀ x y, ⟪U x, U y⟫_ℂ = conj ⟪x, y⟫_ℂ
  /-- Antiunitary operators are onto. -/
  surjective : Function.Surjective U

/-! ### Elementary computations in an orthonormal basis -/







/-! ### Rephasing the image basis -/

/-- The phase by which the image `T (b i)` has to be rotated so that the two nonzero
coordinates of `T (b o + b i)` become equal. -/
noncomputable def alignPhase (b : OrthonormalBasis ι ℂ E) (T : E → E) (o i : ι) : ℂ :=
  if i = o then 1 else ⟪T (b i), T (b o + b i)⟫_ℂ / ⟪T (b o), T (b o + b i)⟫_ℂ

/-- The rephased images of the basis vectors. -/
noncomputable def imgVec (b : OrthonormalBasis ι ℂ E) (T : E → E) (o i : ι) : E :=
  alignPhase b T o i • T (b i)

variable {b : OrthonormalBasis ι ℂ E} {o : ι}

omit [DecidableEq ι] in
theorem inner_pair_left_norm (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    ‖⟪T (b o), T (b o + b i)⟫_ℂ‖ = 1 := by
  classical
  rw [hT (b o) (b o + b i), inner_add_right,
    orthonormal_iff_ite.mp b.orthonormal o o, orthonormal_iff_ite.mp b.orthonormal o i]
  simp [Ne.symm hi]

omit [DecidableEq ι] in
theorem inner_pair_right_norm (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    ‖⟪T (b i), T (b o + b i)⟫_ℂ‖ = 1 := by
  classical
  rw [hT (b i) (b o + b i), inner_add_right,
    orthonormal_iff_ite.mp b.orthonormal i o, orthonormal_iff_ite.mp b.orthonormal i i]
  simp [hi]

theorem alignPhase_norm (hT : IsWignerSymmetry T) (i : ι) : ‖alignPhase b T o i‖ = 1 := by
  rw [alignPhase]
  split_ifs with h
  · simp
  · rw [norm_div, inner_pair_right_norm hT h, inner_pair_left_norm hT h, div_one]



/-- The rephased images of an orthonormal basis are again orthonormal. -/
theorem orthonormal_imgVec (hT : IsWignerSymmetry T) : Orthonormal ℂ (imgVec b T o) := by
  rw [orthonormal_iff_ite]
  intro i j
  rw [imgVec, imgVec, inner_smul_left, inner_smul_right]
  by_cases h : i = j
  · subst h
    have hn : ‖T (b i)‖ = 1 := by rw [norm_map hT, b.orthonormal.1 i]
    have h1 : ⟪T (b i), T (b i)⟫_ℂ = 1 := by
      rw [inner_self_eq_norm_sq_to_K, hn]; norm_num
    have h2 : conj (alignPhase b T o i) * alignPhase b T o i = 1 := by
      rw [mul_comm, Complex.mul_conj]
      have hsq : Complex.normSq (alignPhase b T o i) = ‖alignPhase b T o i‖ ^ 2 := by
        rw [Complex.sq_norm]
      rw [hsq, alignPhase_norm hT]
      norm_num
    rw [h1, mul_one, h2]
    simp
  · have h0 : ⟪T (b i), T (b j)⟫_ℂ = 0 := by
      have := hT (b i) (b j)
      rw [orthonormal_iff_ite.mp b.orthonormal i j, if_neg h] at this
      simpa using this
    rw [h0, if_neg h]
    ring

/-- The rephased images of `b`, as an orthonormal basis. -/
noncomputable def imgBasis (b : OrthonormalBasis ι ℂ E) (T : E → E) (o : ι)
    (hT : IsWignerSymmetry T) : OrthonormalBasis ι ℂ E :=
  haveI : Nonempty ι := ⟨o⟩
  haveI : FiniteDimensional ℂ E := Module.Basis.finiteDimensional_of_finite b.toBasis
  (basisOfLinearIndependentOfCardEqFinrank
      (orthonormal_imgVec (b := b) (o := o) hT).linearIndependent
      (Module.finrank_eq_card_basis b.toBasis).symm).toOrthonormalBasis (by
    rw [coe_basisOfLinearIndependentOfCardEqFinrank]
    exact orthonormal_imgVec hT)



/-! ### The coordinate map of `T` and Wigner's theorem -/

/-- The matrix of `T` between the basis `b` and the rephased image basis. -/
noncomputable def coordMap (b : OrthonormalBasis ι ℂ E) (T : E → E)
    (G : OrthonormalBasis ι ℂ E) : (ι → ℂ) → (ι → ℂ) :=
  fun v k => ⟪G k, T (∑ j, v j • b j)⟫_ℂ



ty is assumed, only that all transition
probabilities are preserved.  The theorem produces one linear **or** one conjugate-linear
isometry `U` such that every `T x` equals `U x` up to a phase depending on `x`.

## The proof

*Part I* is the algebraic core, stated for a map `S : (ι → ℂ) → (ι → ℂ)` of coordinate
vectors that preserves the modulus of the standard inner product (`inner_norm`) and of
each coordinate (`coord_norm`), and is normalized so that the two nonzero coordinates of
`S (δ₀ + δᵢ)` agree (`normalized`; this is achieved by rephasing the image basis):

* `modulus_add` — `‖S v o + S v i‖ = ‖v o + v i‖`;
* `exists_zeta` — the vector `δ₀ + i δᵢ` produces a sign `ζᵢ = ±i`;
* `key_index` — hence for each `i`, either `conj (S v o) * S v i = conj (v o) * v i` for
  **all** `v`, or `conj (S v o) * S v i = conj (conj (v o) * v i)` for all `v`;
* `key_consistent` — the alternative is the same for all indices (otherwise the transition
  probability between `δ₀ + δᵢ + δⱼ` and `δ₀ + i δᵢ + i δⱼ` would change from `√5` to `1`);
* `coord_of_key`, `wigner_coord` — therefore `S v = lam • v` for all `v`, or
  `S v = lam • conj v` for all `v`, with `‖lam‖ = 1` depending on `v`.  The case
  `v o = 0` is settled by the equality case of the triangle inequality.

*Part II* transports this to a Hilbert space with an orthonormal basis: the images of the
basis vectors are orthonormal, hence an orthonormal basis; their phases are fixed with the
vectors `b₀ + bᵢ`; and the coordinate map of `T` in these two bases satisfies the
hypotheses of Part I.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace ComplexConjugate
open Finset

namespace BookProof.ChapterWignerSymmetry

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- A **Wigner symmetry**: a map of the Hilbert space preserving all transition
probabilities `|⟪x, y⟫|`. -/
def IsWignerSymmetry (T : E → E) : Prop := ∀ x y : E, ‖⟪T x, T y⟫_ℂ‖ = ‖⟪x, y⟫_ℂ‖

variable {T : E → E}

/-- A Wigner symmetry preserves norms. -/
theorem norm_map (hT : IsWignerSymmetry T) (x : E) : ‖T x‖ = ‖x‖ := by
  have h := hT x x
  rw [inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K] at h
  simpa using h

theorem map_zero (hT : IsWignerSymmetry T) : T 0 = 0 := by
  have := norm_map hT 0
  simpa using this

/-! ### Two complex-number identities behind the key relation -/

/-- If a real number is the real part and the modulus of `z`, then `z` is that real. -/
theorem eq_norm_of_re_eq_norm {z : ℂ} (h : z.re = ‖z‖) : z = (‖z‖ : ℂ) := by
  have hre : ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := by rw [Complex.sq_norm, Complex.normSq_apply]; ring
  rw [← h] at hre
  have h2 : z.im = 0 := by nlinarith [sq_nonneg z.im]
  apply Complex.ext <;> simp [h, h2]

/-- The linear alternative: the four modulus equations force `conj a * b = conj c * d`. -/
theorem key_complex (a b c d : ℂ) (h1 : ‖a‖ = ‖c‖) (h2 : ‖b‖ = ‖d‖) (h3 : ‖a + b‖ = ‖c + d‖)
    (h4 : ‖conj a + Complex.I * conj b‖ = ‖conj c + Complex.I * conj d‖) :
    conj a * b = conj c * d := by
  have e1 : ‖a‖ ^ 2 = ‖c‖ ^ 2 := by rw [h1]
  have e2 : ‖b‖ ^ 2 = ‖d‖ ^ 2 := by rw [h2]
  have e3 : ‖a + b‖ ^ 2 = ‖c + d‖ ^ 2 := by rw [h3]
  have e4 : ‖conj a + Complex.I * conj b‖ ^ 2 = ‖conj c + Complex.I * conj d‖ ^ 2 := by rw [h4]
  simp only [Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
    Complex.mul_re, Complex.mul_im, Complex.conj_re, Complex.conj_im, Complex.I_re,
    Complex.I_im] at e1 e2 e3 e4
  apply Complex.ext <;>
    simp only [Complex.mul_re, Complex.mul_im, Complex.conj_re, Complex.conj_im] <;>
    nlinarith [e1, e2, e3, e4]

/-- The conjugate-linear alternative. -/
theorem key_complex' (a b c d : ℂ) (h1 : ‖a‖ = ‖c‖) (h2 : ‖b‖ = ‖d‖) (h3 : ‖a + b‖ = ‖c + d‖)
    (h4 : ‖conj a + (-Complex.I) * conj b‖ = ‖conj c + Complex.I * conj d‖) :
    conj a * b = conj (conj c * d) := by
  have e1 : ‖a‖ ^ 2 = ‖c‖ ^ 2 := by rw [h1]
  have e2 : ‖b‖ ^ 2 = ‖d‖ ^ 2 := by rw [h2]
  have e3 : ‖a + b‖ ^ 2 = ‖c + d‖ ^ 2 := by rw [h3]
  have e4 : ‖conj a + (-Complex.I) * conj b‖ ^ 2 = ‖conj c + Complex.I * conj d‖ ^ 2 := by rw [h4]
  simp only [Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
    Complex.mul_re, Complex.mul_im, Complex.conj_re, Complex.conj_im, Complex.I_re,
    Complex.I_im, Complex.neg_re, Complex.neg_im] at e1 e2 e3 e4
  apply Complex.ext <;>
    simp only [Complex.mul_re, Complex.mul_im, Complex.conj_re, Complex.conj_im] <;>
    nlinarith [e1, e2, e3, e4]

/-! ## Part I — the algebraic core in coordinates -/

section Coord

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The coordinate vector `δ_o + δ_i`. -/
def pairCoord (o i : ι) : ι → ℂ := fun k => if k = o then 1 else if k = i then 1 else 0

/-- The coordinate vector `δ_o + i·δ_i`. -/
def pairCoordI (o i : ι) : ι → ℂ := fun k => if k = o then 1 else if k = i then Complex.I else 0

/-- The coordinate vector `δ_o + z·δ_i + z·δ_j`. -/
def tripleCoord (o i j : ι) (z : ℂ) : ι → ℂ :=
  fun k => if k = o then 1 else if k = i then z else if k = j then z else 0

omit [DecidableEq ι] in
theorem sum_supported {s : Finset ι} {f : ι → ℂ} (hf : ∀ k, k ∉ s → f k = 0) (g : ι → ℂ) :
    ∑ k, g k * f k = ∑ k ∈ s, g k * f k :=
  (Finset.sum_subset (Finset.subset_univ s) (fun k _ hk => by rw [hf k hk, mul_zero])).symm

omit [DecidableEq ι] in
theorem sum_pair' {o i : ι} (hi : i ≠ o) {f : ι → ℂ} (hf : ∀ k, k ≠ o → k ≠ i → f k = 0)
    (g : ι → ℂ) : ∑ k, g k * f k = g o * f o + g i * f i := by
  classical
  rw [sum_supported (s := ({o, i} : Finset ι)) (fun k hk => by
      simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hk
      exact hf k hk.1 hk.2) g]
  rw [Finset.sum_pair (Ne.symm hi)]

omit [DecidableEq ι] in
theorem sum_triple {o i j : ι} (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j) {f : ι → ℂ}
    (hf : ∀ k, k ≠ o → k ≠ i → k ≠ j → f k = 0) (g : ι → ℂ) :
    ∑ k, g k * f k = g o * f o + g i * f i + g j * f j := by
  classical
  rw [sum_supported (s := ({o, i, j} : Finset ι)) (fun k hk => by
      simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hk
      exact hf k hk.1 hk.2.1 hk.2.2) g]
  rw [Finset.sum_insert (by simp [Ne.symm hio, Ne.symm hjo]),
    Finset.sum_insert (by simp [hij]), Finset.sum_singleton, add_assoc]

/-- The hypotheses of Wigner's theorem in coordinates. -/
structure WignerCoord (S : (ι → ℂ) → (ι → ℂ)) (o : ι) : Prop where
  /-- The modulus of the standard inner product is preserved. -/
  inner_norm : ∀ v w, ‖∑ k, conj (S v k) * S w k‖ = ‖∑ k, conj (v k) * w k‖
  /-- The modulus of each coordinate is preserved. -/
  coord_norm : ∀ v k, ‖S v k‖ = ‖v k‖
  /-- The image basis has been rephased so that `S (δ_o + δ_i)` has equal coordinates. -/
  normalized : ∀ i, i ≠ o → S (pairCoord o i) o = S (pairCoord o i) i

variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}

theorem S_zero (hS : WignerCoord S o) {v : ι → ℂ} {k : ι} (h : v k = 0) : S v k = 0 := by
  have hn := hS.coord_norm v k
  rw [h] at hn
  simpa using hn

theorem modulus_add (hS : WignerCoord S o) {i : ι} (hi : i ≠ o) (v : ι → ℂ) :
    ‖S v o + S v i‖ = ‖v o + v i‖ := by
  set u := pairCoord o i with hu
  have huo : u o = 1 := by simp [hu, pairCoord]
  have hui : u i = 1 := by simp [hu, pairCoord, hi]
  have huk : ∀ k, k ≠ o → k ≠ i → u k = 0 := by
    intro k h1 h2; simp [hu, pairCoord, h1, h2]
  have hSu : ∀ k, k ≠ o → k ≠ i → S u k = 0 := fun k h1 h2 => S_zero hS (huk k h1 h2)
  have h := hS.inner_norm v u
  rw [sum_pair' hi hSu, sum_pair' hi huk] at h
  rw [hS.normalized i hi] at h
  have hnorm : ‖S u i‖ = 1 := by rw [hS.coord_norm u i, hui]; simp
  rw [huo, hui] at h
  rw [show conj (S v o) * S u i + conj (S v i) * S u i
        = (conj (S v o) + conj (S v i)) * S u i by ring] at h
  rw [norm_mul, hnorm, mul_one, mul_one, mul_one, ← map_add, ← map_add,
    Complex.norm_conj, Complex.norm_conj] at h
  exact h

/-- The vector `δ_o + i δ_i` fixes a sign `ζ = ±i` controlling the imaginary parts. -/
theorem exists_zeta (hS : WignerCoord S o) {i : ι} (hi : i ≠ o) :
    ∃ ζ : ℂ, (ζ = Complex.I ∨ ζ = -Complex.I) ∧
      ∀ v, ‖conj (S v o) + ζ * conj (S v i)‖ = ‖conj (v o) + Complex.I * conj (v i)‖ := by
  set w := pairCoordI o i with hw
  have hwo : w o = 1 := by simp [hw, pairCoordI]
  have hwi : w i = Complex.I := by simp [hw, pairCoordI, hi]
  have hwk : ∀ k, k ≠ o → k ≠ i → w k = 0 := by
    intro k h1 h2; simp [hw, pairCoordI, h1, h2]
  have hSw : ∀ k, k ≠ o → k ≠ i → S w k = 0 := fun k h1 h2 => S_zero hS (hwk k h1 h2)
  have hP : ‖S w o‖ = 1 := by rw [hS.coord_norm w o, hwo]; simp
  have hQ : ‖S w i‖ = 1 := by rw [hS.coord_norm w i, hwi]; simp
  -- the relative phase
  set P := S w o with hPdef
  set Q := S w i with hQdef
  have hsum : ‖P + Q‖ = ‖(1 : ℂ) + Complex.I‖ := by
    have := modulus_add hS hi w
    rwa [hwo, hwi] at this
  have hζnorm : ‖conj P * Q‖ = 1 := by rw [norm_mul, Complex.norm_conj, hP, hQ, mul_one]
  have hζre : (conj P * Q).re = 0 := by
    have h1 : ‖P + Q‖ ^ 2 = ‖(1 : ℂ) + Complex.I‖ ^ 2 := by rw [hsum]
    have hP2 : ‖P‖ ^ 2 = 1 := by rw [hP]; norm_num
    have hQ2 : ‖Q‖ ^ 2 = 1 := by rw [hQ]; norm_num
    simp only [Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
      Complex.one_re, Complex.one_im, Complex.I_re, Complex.I_im] at h1 hP2 hQ2
    simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im]
    nlinarith [h1, hP2, hQ2]
  have hζ : conj P * Q = Complex.I ∨ conj P * Q = -Complex.I := by
    set z := conj P * Q with hz
    have him : z.im = 1 ∨ z.im = -1 := by
      have h2 : ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := by
        rw [Complex.sq_norm, Complex.normSq_apply]; ring
      rw [hζnorm, hζre] at h2
      have hfac : (z.im - 1) * (z.im + 1) = 0 := by nlinarith
      rcases mul_eq_zero.1 hfac with h | h
      · exact Or.inl (by linarith)
      · exact Or.inr (by linarith)
    rcases him with h | h
    · left; apply Complex.ext <;> simp [hζre, h]
    · right; apply Complex.ext <;> simp [hζre, h]
  refine ⟨conj P * Q, hζ, fun v => ?_⟩
  have h := hS.inner_norm v w
  rw [sum_pair' hi hSw, sum_pair' hi hwk, hwo, hwi] at h
  have hPP : P * conj P = 1 := by
    rw [Complex.mul_conj]
    have hsq : Complex.normSq P = ‖P‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hP]
    norm_num
  have hPQ : conj (S v o) * P + conj (S v i) * Q
      = P * (conj (S v o) + (conj P * Q) * conj (S v i)) := by
    calc conj (S v o) * P + conj (S v i) * Q
        = P * conj (S v o) + (P * conj P) * (Q * conj (S v i)) := by rw [hPP]; ring
      _ = P * (conj (S v o) + (conj P * Q) * conj (S v i)) := by ring
  rw [hPQ, norm_mul, hP, one_mul] at h
  rw [h]
  congr 1
  ring

/-- **The key relation.**  For each index `i` one of the two alternatives (linear or
conjugate-linear) holds for *all* coordinate vectors. -/
theorem key_index (hS : WignerCoord S o) {i : ι} (hi : i ≠ o) :
    (∀ v, conj (S v o) * S v i = conj (v o) * v i) ∨
    (∀ v, conj (S v o) * S v i = conj (conj (v o) * v i)) := by
  obtain ⟨ζ, hζ, hrel⟩ := exists_zeta hS hi
  rcases hζ with hζ | hζ
  · left
    intro v
    have h1 : ‖S v o‖ = ‖v o‖ := hS.coord_norm v o
    have h2 : ‖S v i‖ = ‖v i‖ := hS.coord_norm v i
    have h3 : ‖S v o + S v i‖ = ‖v o + v i‖ := modulus_add hS hi v
    have h4 := hrel v
    rw [hζ] at h4
    exact key_complex (S v o) (S v i) (v o) (v i) h1 h2 h3 h4
  · right
    intro v
    have h1 : ‖S v o‖ = ‖v o‖ := hS.coord_norm v o
    have h2 : ‖S v i‖ = ‖v i‖ := hS.coord_norm v i
    have h3 : ‖S v o + S v i‖ = ‖v o + v i‖ := modulus_add hS hi v
    have h4 := hrel v
    rw [hζ] at h4
    exact key_complex' (S v o) (S v i) (v o) (v i) h1 h2 h3 h4


/-- **Consistency of the alternative.**  Two different indices cannot use different
alternatives: the transition probability between `δ_o + δ_i + δ_j` and
`δ_o + i δ_i + i δ_j` would change from `√5` to `1`. -/
theorem key_consistent (hS : WignerCoord S o) {i j : ι} (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j)
    (hi : ∀ v, conj (S v o) * S v i = conj (v o) * v i)
    (hj : ∀ v, conj (S v o) * S v j = conj (conj (v o) * v j)) : False := by
  set v := tripleCoord o i j 1 with hv
  set w := tripleCoord o i j Complex.I with hw
  have hvo : v o = 1 := by simp [hv, tripleCoord]
  have hvi : v i = 1 := by simp [hv, tripleCoord, hio]
  have hvj : v j = 1 := by simp [hv, tripleCoord, hjo, Ne.symm hij]
  have hvk : ∀ k, k ≠ o → k ≠ i → k ≠ j → v k = 0 := by
    intro k h1 h2 h3; simp [hv, tripleCoord, h1, h2, h3]
  have hwo : w o = 1 := by simp [hw, tripleCoord]
  have hwi : w i = Complex.I := by simp [hw, tripleCoord, hio]
  have hwj : w j = Complex.I := by simp [hw, tripleCoord, hjo, Ne.symm hij]
  have hwk : ∀ k, k ≠ o → k ≠ i → k ≠ j → w k = 0 := by
    intro k h1 h2 h3; simp [hw, tripleCoord, h1, h2, h3]
  have hSw : ∀ k, k ≠ o → k ≠ i → k ≠ j → S w k = 0 :=
    fun k h1 h2 h3 => S_zero hS (hwk k h1 h2 h3)
  -- the images of `v` and `w`
  have hp : ‖S v o‖ = 1 := by rw [hS.coord_norm v o, hvo]; simp
  have hq : ‖S w o‖ = 1 := by rw [hS.coord_norm w o, hwo]; simp
  have hpp : S v o * conj (S v o) = 1 := by
    rw [Complex.mul_conj]
    have hsq : Complex.normSq (S v o) = ‖S v o‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hp]; norm_num
  have hqq : S w o * conj (S w o) = 1 := by
    rw [Complex.mul_conj]
    have hsq : Complex.normSq (S w o) = ‖S w o‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hq]; norm_num
  have hvi' : S v i = S v o := by
    have h := hi v
    rw [hvo, hvi] at h
    calc S v i = (S v o * conj (S v o)) * S v i := by rw [hpp]; ring
      _ = S v o * (conj (S v o) * S v i) := by ring
      _ = S v o := by rw [h]; simp
  have hvj' : S v j = S v o := by
    have h := hj v
    rw [hvo, hvj] at h
    calc S v j = (S v o * conj (S v o)) * S v j := by rw [hpp]; ring
      _ = S v o * (conj (S v o) * S v j) := by ring
      _ = S v o := by rw [h]; simp
  have hwi' : S w i = Complex.I * S w o := by
    have h := hi w
    rw [hwo, hwi] at h
    calc S w i = (S w o * conj (S w o)) * S w i := by rw [hqq]; ring
      _ = S w o * (conj (S w o) * S w i) := by ring
      _ = Complex.I * S w o := by rw [h]; simp; ring
  have hwj' : S w j = -Complex.I * S w o := by
    have h := hj w
    rw [hwo, hwj] at h
    calc S w j = (S w o * conj (S w o)) * S w j := by rw [hqq]; ring
      _ = S w o * (conj (S w o) * S w j) := by ring
      _ = -Complex.I * S w o := by rw [h]; simp; ring
  -- compare the two transition probabilities
  have h := hS.inner_norm v w
  rw [sum_triple hio hjo hij hSw, sum_triple hio hjo hij hwk] at h
  rw [hvi', hvj', hwi', hwj', hvo, hvi, hvj, hwo, hwi, hwj] at h
  rw [show conj (S v o) * S w o + conj (S v o) * (Complex.I * S w o)
        + conj (S v o) * (-Complex.I * S w o) = conj (S v o) * S w o by ring] at h
  have h5 : ‖conj (S v o) * S w o‖ ^ 2
      = ‖conj (1 : ℂ) * 1 + conj (1 : ℂ) * Complex.I + conj (1 : ℂ) * Complex.I‖ ^ 2 := by
    rw [h]
  rw [norm_mul, Complex.norm_conj, hp, hq] at h5
  simp only [Complex.sq_norm, Complex.normSq_apply] at h5
  norm_num at h5

/-- The alternative is global: the same one works for every index. -/
theorem key_global (hS : WignerCoord S o) :
    (∀ i, i ≠ o → ∀ v, conj (S v o) * S v i = conj (v o) * v i) ∨
    (∀ i, i ≠ o → ∀ v, conj (S v o) * S v i = conj (conj (v o) * v i)) := by
  by_cases hex : ∃ i, i ≠ o ∧ ∀ v, conj (S v o) * S v i = conj (v o) * v i
  · obtain ⟨i₀, hi₀, hkey₀⟩ := hex
    left
    intro j hj v
    rcases key_index hS hj with h | h
    · exact h v
    · by_cases hji : j = i₀
      · subst hji; exact hkey₀ v
      · exact (key_consistent hS hi₀ hj (fun e => hji e.symm) hkey₀ h).elim
  · push_neg at hex
    right
    intro i hi v
    rcases key_index hS hi with h | h
    · obtain ⟨v₀, hv₀⟩ := hex i hi
      exact absurd (h v₀) hv₀
    · exact h v

/-- The conclusion in coordinates when the pivot coordinate does not vanish. -/
theorem coord_of_key_of_ne_zero (hS : WignerCoord S o) (κ : ℂ →+* ℂ) (hκn : ∀ z, ‖κ z‖ = ‖z‖)
    (hκc : ∀ z, κ (conj z) = conj (κ z))
    (hkey : ∀ i, i ≠ o → ∀ v, conj (S v o) * S v i = κ (conj (v o) * v i))
    {v : ι → ℂ} (hv : v o ≠ 0) : ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * κ (v k) := by
  have hκvo : κ (v o) ≠ 0 := by
    intro h
    apply hv
    have := hκn (v o)
    rw [h] at this
    simpa [eq_comm] using this.symm
  refine ⟨S v o / κ (v o), ?_, ?_⟩
  · rw [norm_div, hS.coord_norm v o, hκn]
    exact div_self (by simpa using hv)
  · intro k
    have hlam : S v o = (S v o / κ (v o)) * κ (v o) := by field_simp
    have hlamnorm : (S v o / κ (v o)) * conj (S v o / κ (v o)) = 1 := by
      rw [Complex.mul_conj]
      have hsq : Complex.normSq (S v o / κ (v o)) = ‖S v o / κ (v o)‖ ^ 2 := by rw [Complex.sq_norm]
      rw [hsq, norm_div, hS.coord_norm v o, hκn, div_self (by simpa using hv)]
      norm_num
    by_cases hk : k = o
    · subst hk; exact hlam
    · have h := hkey k hk v
      rw [map_mul, hκc] at h
      -- `conj (S v o) * S v k = conj (κ (v o)) * κ (v k)`
      have hconj : conj (S v o) = conj (S v o / κ (v o)) * conj (κ (v o)) := by
        rw [← map_mul, ← hlam]
      rw [hconj] at h
      have hne : conj (κ (v o)) ≠ 0 := by simpa using hκvo
      have hcancel : conj (S v o / κ (v o)) * S v k = κ (v k) := by
        refine mul_left_cancel₀ hne ?_
        calc conj (κ (v o)) * (conj (S v o / κ (v o)) * S v k)
            = conj (S v o / κ (v o)) * conj (κ (v o)) * S v k := by ring
          _ = conj (κ (v o)) * κ (v k) := h
      calc S v k = ((S v o / κ (v o)) * conj (S v o / κ (v o))) * S v k := by rw [hlamnorm]; ring
        _ = (S v o / κ (v o)) * (conj (S v o / κ (v o)) * S v k) := by ring
        _ = (S v o / κ (v o)) * κ (v k) := by rw [hcancel]


/-- **The conclusion in coordinates.**  Every `v` is mapped to `lam • κ v` for some unit
`lam` (depending on `v`), where `κ` is the fixed alternative from `key_global`. -/
theorem coord_of_key (hS : WignerCoord S o) (κ : ℂ →+* ℂ) (hκn : ∀ z, ‖κ z‖ = ‖z‖)
    (hκc : ∀ z, κ (conj z) = conj (κ z))
    (hkey : ∀ i, i ≠ o → ∀ v, conj (S v o) * S v i = κ (conj (v o) * v i)) (v : ι → ℂ) :
    ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * κ (v k) := by
  by_cases hvo : v o = 0
  · have hSvo : S v o = 0 := S_zero hS hvo
    by_cases hzero : ∀ k, v k = 0
    · refine ⟨1, by norm_num, fun k => ?_⟩
      rw [hzero k, κ.map_zero, mul_zero]
      exact S_zero hS (hzero k)
    · push_neg at hzero
      obtain ⟨k₀, hk₀⟩ := hzero
      set y : ι → ℂ := fun k => if k = o then 1 else v k with hy
      have hyo : y o = 1 := by simp [hy]
      have hyk : ∀ k, k ≠ o → y k = v k := by intro k hk; simp [hy, hk]
      obtain ⟨μ, hμ, hμeq⟩ :=
        coord_of_key_of_ne_zero hS κ hκn hκc hkey (v := y) (by rw [hyo]; norm_num)
      set M : ℝ := ∑ k, ‖v k‖ ^ 2 with hMdef
      set Z : ℂ := ∑ k, conj (κ (v k)) * S v k with hZdef
      have hMpos : 0 < M := by
        rw [hMdef]
        refine Finset.sum_pos' (fun k _ => by positivity) ⟨k₀, Finset.mem_univ _, ?_⟩
        have : ‖v k₀‖ ≠ 0 := by simpa using hk₀
        positivity
      -- the two sides of the invariance relation
      have hsum1 : ∑ k, conj (S y k) * S v k = conj μ * Z := by
        rw [hZdef, Finset.mul_sum]
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [hμeq k, map_mul]
        by_cases hk : k = o
        · subst hk
          simp [hSvo]
        · rw [hyk k hk]
          ring
      have hsum2 : ∑ k, conj (y k) * v k = ((M : ℝ) : ℂ) := by
        rw [hMdef]
        push_cast
        refine Finset.sum_congr rfl fun k _ => ?_
        by_cases hk : k = o
        · subst hk
          simp [hyo, hvo]
        · rw [hyk k hk, mul_comm, Complex.mul_conj]
          norm_cast
          rw [Complex.sq_norm]
      have hZnorm : ‖Z‖ = M := by
        have h := hS.inner_norm y v
        rw [hsum1, hsum2, norm_mul, Complex.norm_conj, hμ, one_mul,
          Complex.norm_real, Real.norm_of_nonneg hMpos.le] at h
        exact h
      -- equality in the triangle inequality
      have hZne : Z ≠ 0 := by
        intro h
        rw [h, norm_zero] at hZnorm
        exact absurd hZnorm.symm (ne_of_gt hMpos)
      refine ⟨Z / ((M : ℝ) : ℂ), ?_, ?_⟩
      · rw [norm_div, hZnorm, Complex.norm_real, Real.norm_of_nonneg hMpos.le,
          div_self (ne_of_gt hMpos)]
      · set lam : ℂ := Z / ((M : ℝ) : ℂ) with hlamdef
        have hMC : ((M : ℝ) : ℂ) ≠ 0 := by exact_mod_cast ne_of_gt hMpos
        have hlamnorm : ‖lam‖ = 1 := by
          rw [hlamdef, norm_div, hZnorm, Complex.norm_real, Real.norm_of_nonneg hMpos.le,
            div_self (ne_of_gt hMpos)]
        have hlamconj : lam * conj lam = 1 := by
          rw [Complex.mul_conj]
          have hsq : Complex.normSq lam = ‖lam‖ ^ 2 := by rw [Complex.sq_norm]
          rw [hsq, hlamnorm]; norm_num
        have hsumt : ∑ k, conj lam * (conj (κ (v k)) * S v k) = ((M : ℝ) : ℂ) := by
          rw [← Finset.mul_sum, ← hZdef, hlamdef, map_div₀]
          rw [Complex.conj_ofReal]
          field_simp
          rw [mul_comm, Complex.mul_conj]
          have hsq : Complex.normSq Z = ‖Z‖ ^ 2 := by rw [Complex.sq_norm]
          rw [hsq, hZnorm]
          push_cast
          ring
        have hle : ∀ k ∈ Finset.univ,
            (conj lam * (conj (κ (v k)) * S v k)).re ≤ ‖v k‖ ^ 2 := by
          intro k _
          have h1 : ‖conj lam * (conj (κ (v k)) * S v k)‖ = ‖v k‖ ^ 2 := by
            rw [norm_mul, norm_mul, Complex.norm_conj, Complex.norm_conj, hlamnorm, hκn,
              hS.coord_norm v k, one_mul]
            ring
          calc (conj lam * (conj (κ (v k)) * S v k)).re
              ≤ ‖conj lam * (conj (κ (v k)) * S v k)‖ := Complex.re_le_norm _
            _ = ‖v k‖ ^ 2 := h1
        have hsumre : ∑ k, (conj lam * (conj (κ (v k)) * S v k)).re = ∑ k, ‖v k‖ ^ 2 := by
          rw [← Complex.re_sum, hsumt, Complex.ofReal_re, hMdef]
        have hterm := (Finset.sum_eq_sum_iff_of_le hle).1 hsumre
        intro k
        have hk := hterm k (Finset.mem_univ k)
        by_cases hvk : v k = 0
        · rw [hvk, κ.map_zero, mul_zero]
          exact S_zero hS hvk
        · have hnorm : ‖conj lam * (conj (κ (v k)) * S v k)‖ = ‖v k‖ ^ 2 := by
            rw [norm_mul, norm_mul, Complex.norm_conj, Complex.norm_conj, hlamnorm, hκn,
              hS.coord_norm v k, one_mul]
            ring
          have hreal : conj lam * (conj (κ (v k)) * S v k) = ((‖v k‖ ^ 2 : ℝ) : ℂ) := by
            have := eq_norm_of_re_eq_norm (z := conj lam * (conj (κ (v k)) * S v k))
              (by rw [hk, hnorm])
            rw [this, hnorm]
          have hκvk : κ (v k) ≠ 0 := by
            intro h
            apply hvk
            have := hκn (v k)
            rw [h] at this
            simpa [eq_comm] using this.symm
          have hne : conj (κ (v k)) ≠ 0 := by simpa using hκvk
          have hprod : conj (κ (v k)) * κ (v k) = ((‖v k‖ ^ 2 : ℝ) : ℂ) := by
            rw [mul_comm, Complex.mul_conj]
            have hsq : Complex.normSq (κ (v k)) = ‖κ (v k)‖ ^ 2 := by rw [Complex.sq_norm]
            rw [hsq, hκn]
          have hcancel : conj lam * S v k = κ (v k) := by
            refine mul_left_cancel₀ hne ?_
            calc conj (κ (v k)) * (conj lam * S v k)
                = conj lam * (conj (κ (v k)) * S v k) := by ring
              _ = ((‖v k‖ ^ 2 : ℝ) : ℂ) := hreal
              _ = conj (κ (v k)) * κ (v k) := hprod.symm
          calc S v k = (lam * conj lam) * S v k := by rw [hlamconj]; ring
            _ = lam * (conj lam * S v k) := by ring
            _ = lam * κ (v k) := by rw [hcancel]
  · exact coord_of_key_of_ne_zero hS κ hκn hκc hkey hvo

/-- **Wigner's theorem in coordinates.** -/
theorem wigner_coord (hS : WignerCoord S o) :
    (∀ v, ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * v k) ∨
    (∀ v, ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, S v k = lam * conj (v k)) := by
  rcases key_global hS with h | h
  · left
    intro v
    simpa using coord_of_key hS (RingHom.id ℂ) (by simp) (by simp) (by simpa using h) v
  · right
    intro v
    simpa using
      coord_of_key hS (starRingEnd ℂ) (fun z => Complex.norm_conj z) (fun z => by simp) h v

end Coord


/-! ## Part II — transport to a Hilbert space

Part I is stated for coordinate vectors.  We now feed it with the coordinates of `T` in the
orthonormal basis `b` (source) and in the *rephased* image family `imgVec` (target). -/

section Hilbert

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- An **antiunitary operator**: additive, conjugate-homogeneous, surjective, and conjugating
the inner product.  (Norms are automatically preserved, by `inner_conj` with `y = x`.) -/
structure IsAntiunitary (U : E → E) : Prop where
  /-- Antiunitary operators are additive. -/
  map_add : ∀ x y, U (x + y) = U x + U y
  /-- Antiunitary operators are conjugate-homogeneous. -/
  map_smul : ∀ (a : ℂ) (x : E), U (a • x) = conj a • U x
  /-- Antiunitary operators conjugate the inner product. -/
  inner_conj : ∀ x y, ⟪U x, U y⟫_ℂ = conj ⟪x, y⟫_ℂ
  /-- Antiunitary operators are onto. -/
  surjective : Function.Surjective U

/-! ### Elementary computations in an orthonormal basis -/

omit [DecidableEq ι] in
theorem inner_basis_sum (b : OrthonormalBasis ι ℂ E) (v : ι → ℂ) (k : ι) :
    ⟪b k, ∑ j, v j • b j⟫_ℂ = v k := by
  classical
  rw [inner_sum, Finset.sum_eq_single k]
  · rw [inner_smul_right, orthonormal_iff_ite.mp b.orthonormal k k]; simp
  · intro j _ hj
    rw [inner_smul_right, orthonormal_iff_ite.mp b.orthonormal k j, if_neg (Ne.symm hj)]
    simp
  · simp

omit [DecidableEq ι] in
theorem inner_sum_smul (b : OrthonormalBasis ι ℂ E) (v w : ι → ℂ) :
    ⟪∑ j, v j • b j, ∑ j, w j • b j⟫_ℂ = ∑ k, conj (v k) * w k := by
  rw [sum_inner]
  exact Finset.sum_congr rfl fun i _ => by rw [inner_smul_left, inner_basis_sum]

theorem sum_pairCoord (b : OrthonormalBasis ι ℂ E) {o i : ι} (hi : i ≠ o) :
    ∑ j, pairCoord o i j • b j = b o + b i := by
  have hz : ∀ j ∈ (Finset.univ : Finset ι), j ∉ ({o, i} : Finset ι) →
      pairCoord o i j • b j = 0 := by
    intro j _ hj
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hj
    simp [pairCoord, hj.1, hj.2]
  rw [← Finset.sum_subset (Finset.subset_univ _) hz, Finset.sum_pair (Ne.symm hi)]
  simp [pairCoord, hi]

/-! ### Rephasing the image basis -/

/-- The phase by which the image `T (b i)` has to be rotated so that the two nonzero
coordinates of `T (b o + b i)` become equal. -/
noncomputable def alignPhase (b : OrthonormalBasis ι ℂ E) (T : E → E) (o i : ι) : ℂ :=
  if i = o then 1 else ⟪T (b i), T (b o + b i)⟫_ℂ / ⟪T (b o), T (b o + b i)⟫_ℂ

/-- The rephased images of the basis vectors. -/
noncomputable def imgVec (b : OrthonormalBasis ι ℂ E) (T : E → E) (o i : ι) : E :=
  alignPhase b T o i • T (b i)

variable {b : OrthonormalBasis ι ℂ E} {o : ι}

omit [DecidableEq ι] in
theorem inner_pair_left_norm (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    ‖⟪T (b o), T (b o + b i)⟫_ℂ‖ = 1 := by
  classical
  rw [hT (b o) (b o + b i), inner_add_right,
    orthonormal_iff_ite.mp b.orthonormal o o, orthonormal_iff_ite.mp b.orthonormal o i]
  simp [Ne.symm hi]

omit [DecidableEq ι] in
theorem inner_pair_right_norm (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    ‖⟪T (b i), T (b o + b i)⟫_ℂ‖ = 1 := by
  classical
  rw [hT (b i) (b o + b i), inner_add_right,
    orthonormal_iff_ite.mp b.orthonormal i o, orthonormal_iff_ite.mp b.orthonormal i i]
  simp [hi]

theorem alignPhase_norm (hT : IsWignerSymmetry T) (i : ι) : ‖alignPhase b T o i‖ = 1 := by
  rw [alignPhase]
  split_ifs with h
  · simp
  · rw [norm_div, inner_pair_right_norm hT h, inner_pair_left_norm hT h, div_one]

theorem alignPhase_self : alignPhase b T o o = 1 := by simp [alignPhase]

/-- The rephased images of an orthonormal basis are again orthonormal. -/
theorem orthonormal_imgVec (hT : IsWignerSymmetry T) : Orthonormal ℂ (imgVec b T o) := by
  rw [orthonormal_iff_ite]
  intro i j
  rw [imgVec, imgVec, inner_smul_left, inner_smul_right]
  by_cases h : i = j
  · subst h
    have hn : ‖T (b i)‖ = 1 := by rw [norm_map hT, b.orthonormal.1 i]
    have h1 : ⟪T (b i), T (b i)⟫_ℂ = 1 := by
      rw [inner_self_eq_norm_sq_to_K, hn]; norm_num
    have h2 : conj (alignPhase b T o i) * alignPhase b T o i = 1 := by
      rw [mul_comm, Complex.mul_conj]
      have hsq : Complex.normSq (alignPhase b T o i) = ‖alignPhase b T o i‖ ^ 2 := by
        rw [Complex.sq_norm]
      rw [hsq, alignPhase_norm hT]
      norm_num
    rw [h1, mul_one, h2]
    simp
  · have h0 : ⟪T (b i), T (b j)⟫_ℂ = 0 := by
      have := hT (b i) (b j)
      rw [orthonormal_iff_ite.mp b.orthonormal i j, if_neg h] at this
      simpa using this
    rw [h0, if_neg h]
    ring

/-- The rephased images of `b`, as an orthonormal basis. -/
noncomputable def imgBasis (b : OrthonormalBasis ι ℂ E) (T : E → E) (o : ι)
    (hT : IsWignerSymmetry T) : OrthonormalBasis ι ℂ E :=
  haveI : Nonempty ι := ⟨o⟩
  haveI : FiniteDimensional ℂ E := Module.Basis.finiteDimensional_of_finite b.toBasis
  (basisOfLinearIndependentOfCardEqFinrank
      (orthonormal_imgVec (b := b) (o := o) hT).linearIndependent
      (Module.finrank_eq_card_basis b.toBasis).symm).toOrthonormalBasis (by
    rw [coe_basisOfLinearIndependentOfCardEqFinrank]
    exact orthonormal_imgVec hT)

theorem imgBasis_apply (hT : IsWignerSymmetry T) (i : ι) :
    imgBasis b T o hT i = alignPhase b T o i • T (b i) := by
  haveI : Nonempty ι := ⟨o⟩
  haveI : FiniteDimensional ℂ E := Module.Basis.finiteDimensional_of_finite b.toBasis
  have h : ⇑(imgBasis b T o hT) = imgVec b T o := by
    rw [imgBasis, Module.Basis.coe_toOrthonormalBasis,
      coe_basisOfLinearIndependentOfCardEqFinrank]
  rw [h, imgVec]

/-! ### The coordinate map of `T` and Wigner's theorem -/

/-- The matrix of `T` between the basis `b` and the rephased image basis. -/
noncomputable def coordMap (b : OrthonormalBasis ι ℂ E) (T : E → E)
    (G : OrthonormalBasis ι ℂ E) : (ι → ℂ) → (ι → ℂ) :=
  fun v k => ⟪G k, T (∑ j, v j • b j)⟫_ℂ

/-- The coordinate map of a Wigner symmetry satisfies the hypotheses of Part I. -/
theorem wignerCoord_coordMap (hT : IsWignerSymmetry T) :
    WignerCoord (coordMap b T (imgBasis b T o hT)) o := by
  set G := imgBasis b T o hT with hG
  constructor
  · intro v w
    have h1 : ∑ k, conj (coordMap b T G v k) * coordMap b T G w k
        = ⟪T (∑ j, v j • b j), T (∑ j, w j • b j)⟫_ℂ := by
      rw [← G.sum_inner_mul_inner (T (∑ j, v j • b j)) (T (∑ j, w j • b j))]
      exact Finset.sum_congr rfl fun k _ => by
        rw [coordMap, coordMap, inner_conj_symm]
    rw [h1, hT, inner_sum_smul]
  · intro v k
    have h1 : coordMap b T G v k
        = conj (alignPhase b T o k) * ⟪T (b k), T (∑ j, v j • b j)⟫_ℂ := by
      rw [coordMap, hG, imgBasis_apply hT, inner_smul_left]
    rw [h1, norm_mul, Complex.norm_conj, alignPhase_norm hT, one_mul, hT, inner_basis_sum]
  · intro i hi
    have hA : ‖⟪T (b o), T (b o + b i)⟫_ℂ‖ = 1 := inner_pair_left_norm hT hi
    have hB : ‖⟪T (b i), T (b o + b i)⟫_ℂ‖ = 1 := inner_pair_right_norm hT hi
    set A := ⟪T (b o), T (b o + b i)⟫_ℂ with hAdef
    set B := ⟪T (b i), T (b o + b i)⟫_ℂ with hBdef
    have hAne : A ≠ 0 := by intro h; rw [h] at hA; simp at hA
    have hcA : conj A ≠ 0 := by simpa using hAne
    have hAc : A * conj A = 1 := by
      rw [Complex.mul_conj]
      have hsq : Complex.normSq A = ‖A‖ ^ 2 := by rw [Complex.sq_norm]
      rw [hsq, hA]; norm_num
    have hBc : conj B * B = 1 := by
      rw [mul_comm, Complex.mul_conj]
      have hsq : Complex.normSq B = ‖B‖ ^ 2 := by rw [Complex.sq_norm]
      rw [hsq, hB]; norm_num
    have hLHS : coordMap b T G (pairCoord o i) o = A := by
      rw [coordMap, sum_pairCoord b hi, hG, imgBasis_apply hT, inner_smul_left,
        alignPhase_self]
      simp [hAdef]
    have hRHS : coordMap b T G (pairCoord o i) i = conj (B / A) * B := by
      rw [coordMap, sum_pairCoord b hi, hG, imgBasis_apply hT, inner_smul_left, alignPhase]
      rw [if_neg hi]
    rw [hLHS, hRHS, map_div₀]
    field_simp
    calc A * conj A = 1 := hAc
      _ = conj B * B := hBc.symm

omit [DecidableEq ι] in
/-- **Wigner's symmetry theorem.**  Every map `T` of a complex inner-product space with a
finite orthonormal basis that preserves all transition probabilities `|⟪x, y⟫|` agrees,
up to a phase depending on the vector, with a single unitary operator or with a single
antiunitary operator. -/
theorem wigner_symmetry (b : OrthonormalBasis ι ℂ E) (o : ι) (hT : IsWignerSymmetry T) :
    (∃ U : E ≃ₗᵢ[ℂ] E, ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) ∨
    (∃ U : E → E, IsAntiunitary U ∧ ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) := by
  classical
  set G := imgBasis b T o hT with hG
  have hcoord : ∀ (x : E) (k : ι),
      coordMap b T G (fun j => b.repr x j) k = ⟪G k, T x⟫_ℂ := by
    intro x k
    rw [coordMap]
    congr 1
    exact congrArg T (b.sum_repr x)
  have hexp : ∀ x : E, T x = ∑ k, ⟪G k, T x⟫_ℂ • G k := by
    intro x
    conv_lhs => rw [← G.sum_repr (T x)]
    exact Finset.sum_congr rfl fun k _ => by rw [G.repr_apply_apply]
  rcases wigner_coord (wignerCoord_coordMap (b := b) (o := o) hT) with h | h
  · left
    refine ⟨b.repr.trans G.repr.symm, fun x => ?_⟩
    obtain ⟨lam, hlam, hk⟩ := h (fun j => b.repr x j)
    refine ⟨lam, hlam, ?_⟩
    have hU : (b.repr.trans G.repr.symm) x = ∑ k, (b.repr x k) • G k := by
      simpa using (G.sum_repr_symm (b.repr x)).symm
    rw [hU, Finset.smul_sum, hexp x]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [← hcoord x k, hk k, smul_smul]
  · right
    refine ⟨fun x => ∑ k, conj (b.repr x k) • G k, ⟨?_, ?_, ?_, ?_⟩, fun x => ?_⟩
    · intro x y
      rw [← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun k _ => by rw [map_add, ← add_smul]; simp
    · intro a x
      rw [Finset.smul_sum]
      exact Finset.sum_congr rfl fun k _ => by rw [map_smul, smul_smul]; simp
    · intro x y
      rw [inner_sum_smul G]
      have hxy : ⟪x, y⟫_ℂ = ∑ k, conj (b.repr x k) * (b.repr y k) := by
        conv_lhs => rw [← b.sum_repr x, ← b.sum_repr y]
        rw [inner_sum_smul b]
      rw [hxy, map_sum]
      exact Finset.sum_congr rfl fun k _ => by
        rw [Complex.conj_conj, map_mul, Complex.conj_conj, mul_comm]
    · intro y
      refine ⟨∑ j, conj (G.repr y j) • b j, ?_⟩
      have hrep : ∀ k, b.repr (∑ j, conj (G.repr y j) • b j) k = conj (G.repr y k) := by
        intro k
        rw [b.repr_apply_apply, inner_basis_sum]
      have : ∑ k, conj (b.repr (∑ j, conj (G.repr y j) • b j) k) • G k
          = ∑ k, (G.repr y k) • G k := by
        exact Finset.sum_congr rfl fun k _ => by rw [hrep k, Complex.conj_conj]
      exact this.trans (by simpa using G.sum_repr y)
    · obtain ⟨lam, hlam, hk⟩ := h (fun j => b.repr x j)
      refine ⟨lam, hlam, ?_⟩
      rw [Finset.smul_sum, hexp x]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [← hcoord x k, hk k, smul_smul]

/-- **Wigner's symmetry theorem** in a nontrivial finite-dimensional complex Hilbert
space. -/
theorem wigner_symmetry_of_finiteDimensional {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [FiniteDimensional ℂ F] [Nontrivial F] {T : F → F}
    (hT : IsWignerSymmetry T) :
    (∃ U : F ≃ₗᵢ[ℂ] F, ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) ∨
    (∃ U : F → F, IsAntiunitary U ∧ ∀ x, ∃ lam : ℂ, ‖lam‖ = 1 ∧ T x = lam • U x) := by
  have hpos : 0 < Module.finrank ℂ F := Module.finrank_pos
  exact wigner_symmetry (stdOrthonormalBasis ℂ F) ⟨0, hpos⟩ hT

end Hilbert

end BookProof.ChapterWignerSymmetry

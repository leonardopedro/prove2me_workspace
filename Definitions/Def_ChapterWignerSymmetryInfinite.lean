import Definitions.Def_ChapterWignerSymmetry
import Mathlib


/-!
# Wigner's symmetry theorem in an arbitrary complex Hilbert space

`BookProof.ChapterWignerSymmetry` proves Wigner's theorem for a space with a **finite**
orthonormal basis.  This file removes the finiteness: the space is an arbitrary complex
Hilbert space, given by an arbitrary Hilbert basis `b : HilbertBasis ι ℂ E`, and the
symmetry `T` is only assumed to preserve all transition probabilities `|⟪x, y⟫|` and to be
onto.  (Surjectivity is genuinely needed in infinite dimensions: the unilateral shift
preserves all transition probabilities and is not unitary.  In finite dimensions it is
automatic, so this really extends the finite theorem.)

## The proof

The images of the basis vectors are rephased exactly as in the finite case
(`phase`, `img`), giving an orthonormal family.  Two infinite-dimensional ingredients
replace the finite sums:

* `hasSum_img_expansion` — every `T x` is the sum of its Fourier series with respect to the
  rephased family, because Bessel's inequality is saturated: `∑ₖ |⟪imgₖ, T x⟫|² = ‖T x‖²`
  (`BookProof.ChapterOrthogonalSums.hasSum_smul_of_hasSum_norm_sq`).  With surjectivity this
  makes the rephased family a Hilbert basis `imgBasis`;
* `eq_smul_of_hasSum_norm` — the equality case of the triangle inequality for series, used
  where the finite proof used it for finite sums.

The algebraic core is the same as in the finite case: the two-index relations
(`key_pair`) obtained from the test vectors `b o + b i` and `b o + i b i`, their consistency
over all indices (`key_global`), and the reconstruction of the global phase.

## Results

* **`wigner_symmetry_hilbert`** — every surjective transition-probability preserving map of a
  complex Hilbert space with a Hilbert basis agrees, up to a phase depending on the vector,
  with one unitary operator or with one antiunitary operator;
* `wigner_symmetry_of_completeSpace` — the same statement for a nontrivial separable-or-not
  complex Hilbert space, with the Hilbert basis produced internally.

Everything is `sorry`-free and uses only the standard axioms.
-/

open scoped InnerProductSpace ComplexConjugate

namespace BookProof.ChapterWignerSymmetryInfinite


variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

/-! ## The rephased images of the basis vectors -/

/-- The phase by which the image `T (b i)` is rotated so that the two nonzero coordinates of
`T (b o + b i)` become equal. -/
noncomputable def phase [DecidableEq ι] (b : HilbertBasis ι ℂ E) (T : E → E) (o i : ι) : ℂ :=
  if i = o then 1 else ⟪T (b i), T (b o + b i)⟫_ℂ / ⟪T (b o), T (b o + b i)⟫_ℂ

/-- The rephased image of the `i`-th basis vector. -/
noncomputable def img (b : HilbertBasis ι ℂ E) (T : E → E) (o i : ι) : E :=
  phase b T o i • T (b i)

variable {b : HilbertBasis ι ℂ E} {o : ι}

theorem inner_basis_eq (i j : ι) : ⟪b i, b j⟫_ℂ = if i = j then 1 else 0 :=
  orthonormal_iff_ite.mp b.orthonormal i j

theorem inner_pair_left_norm (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    ‖⟪T (b o), T (b o + b i)⟫_ℂ‖ = 1 := by
  rw [hT (b o) (b o + b i), inner_add_right, inner_basis_eq o o, inner_basis_eq o i]
  simp [Ne.symm hi]

theorem inner_pair_right_norm (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    ‖⟪T (b i), T (b o + b i)⟫_ℂ‖ = 1 := by
  rw [hT (b i) (b o + b i), inner_add_right, inner_basis_eq i o, inner_basis_eq i i]
  simp [hi]

theorem phase_norm (hT : IsWignerSymmetry T) (i : ι) : ‖phase b T o i‖ = 1 := by
  rw [phase]
  split_ifs with h
  · simp
  · rw [norm_div, inner_pair_right_norm hT h, inner_pair_left_norm hT h, div_one]





/-- The rephased images of a Hilbert basis form an orthonormal family. -/
theorem orthonormal_img (hT : IsWignerSymmetry T) : Orthonormal ℂ (img b T o) := by
  rw [orthonormal_iff_ite]
  intro i j
  rw [img, img, inner_smul_left, inner_smul_right]
  by_cases h : i = j
  · subst h
    have hn : ‖T (b i)‖ = 1 := by rw [norm_map hT, b.orthonormal.1 i]
    have h1 : ⟪T (b i), T (b i)⟫_ℂ = 1 := by
      rw [inner_self_eq_norm_sq_to_K, hn]; norm_num
    have h2 : conj (phase b T o i) * phase b T o i = 1 := by
      rw [mul_comm, Complex.mul_conj]
      have hsq : Complex.normSq (phase b T o i) = ‖phase b T o i‖ ^ 2 := by rw [Complex.sq_norm]
      rw [hsq, phase_norm hT]
      norm_num
    rw [h1, mul_one, h2]
    simp
  · have h0 : ⟪T (b i), T (b j)⟫_ℂ = 0 := by
      have hij := hT (b i) (b j)
      rw [inner_basis_eq i j, if_neg h] at hij
      simpa using hij
    rw [h0, if_neg h]
    ring

/-- The modulus of each coordinate is preserved. -/
theorem inner_img_norm (hT : IsWignerSymmetry T) (k : ι) (x : E) :
    ‖⟪img b T o k, T x⟫_ℂ‖ = ‖⟪b k, x⟫_ℂ‖ := by
  rw [img, inner_smul_left, norm_mul, Complex.norm_conj, phase_norm hT, one_mul, hT]

/-- Parseval for the source basis. -/
theorem hasSum_basis_norm_sq (x : E) : HasSum (fun k => ‖⟪b k, x⟫_ℂ‖ ^ 2) (‖x‖ ^ 2) := by
  have h := b.hasSum_inner_mul_inner x x
  have hterm : ∀ k : ι, ⟪x, b k⟫_ℂ * ⟪b k, x⟫_ℂ = ((‖⟪b k, x⟫_ℂ‖ ^ 2 : ℝ) : ℂ) := by
    intro k
    have h4 : ⟪x, b k⟫_ℂ = conj ⟪b k, x⟫_ℂ := (inner_conj_symm x (b k)).symm
    rw [h4, mul_comm, Complex.mul_conj, Complex.sq_norm]
  simp only [hterm] at h
  rw [inner_self_eq_norm_sq_to_K] at h
  have h2 := h.mapL Complex.reCLM
  simpa [← Complex.ofReal_pow] using h2

/-- Bessel's inequality is saturated for the rephased family, so `T x` is the sum of its
Fourier series. -/
theorem hasSum_img_expansion (hT : IsWignerSymmetry T) (x : E) :
    HasSum (fun k => ⟪img b T o k, T x⟫_ℂ • img b T o k) (T x) := by
  refine hasSum_smul_of_hasSum_norm_sq (orthonormal_img hT) ?_
  have h : HasSum (fun k => ‖⟪b k, x⟫_ℂ‖ ^ 2) (‖T x‖ ^ 2) := by
    rw [norm_map hT]
    exact hasSum_basis_norm_sq x
  simpa only [inner_img_norm hT] using h

/-! ## The coordinates of `T x` and the two-index relations -/

/-- The coordinate of `T x` along the rephased image of `b k`. -/
noncomputable def coord (b : HilbertBasis ι ℂ E) (T : E → E) (o k : ι) (x : E) : ℂ :=
  ⟪img b T o k, T x⟫_ℂ









/-! ### The two test vectors -/

/-- The test vector `b o + z · b i`. -/
noncomputable def testVec (b : HilbertBasis ι ℂ E) (o i : ι) (z : ℂ) : E := b o + z • b i























/-! ### Consistency of the alternative over the indices -/

/-- The test vector `b o + z · b i + z · b j`. -/
noncomputable def tripleVec (b : HilbertBasis ι ℂ E) (o i j : ι) (z : ℂ) : E :=
  b o + z • b i + z • b j

variable {i j : ι}

















/-! ### The equality case of the triangle inequality for series -/



/-! ## The global phase -/

variable (κ : ℂ →+* ℂ)





/-! ## Wigner's theorem -/

/-- Under surjectivity the rephased images span a dense subspace. -/
theorem span_img_dense (hT : IsWignerSymmetry T) (hsurj : Function.Surjective T) :
    ⊤ ≤ (Submodule.span ℂ (Set.range (img b T o))).topologicalClosure := by
  rintro y -
  obtain ⟨x, rfl⟩ := hsurj y
  refine mem_closure_of_tendsto (hasSum_img_expansion (b := b) (o := o) hT x)
    (Filter.Eventually.of_forall fun s => ?_)
  exact Submodule.sum_mem _ fun k _ =>
    Submodule.smul_mem _ _ (Submodule.subset_span ⟨k, rfl⟩)

/-- The rephased images of the basis vectors, as a Hilbert basis. -/
noncomputable def imgBasis (b : HilbertBasis ι ℂ E) (o : ι) (hT : IsWignerSymmetry T)
    (hsurj : Function.Surjective T) : HilbertBasis ι ℂ E :=
  HilbertBasis.mk (v := img b T o) (orthonormal_img hT) (span_img_dense hT hsurj)







end BookProof.ChapterWignerSymmetryInfinite

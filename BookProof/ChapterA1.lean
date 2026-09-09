import Mathlib
import BookProof.ChapterA

/-!
# Chapter A, §A.1 scaffolding — anti-unitary operators and Def 8 structures

This file formalizes the self-contained infrastructure of Chapter A §A.1 of
`book.tex` (see `FORMALIZATION_ROADMAP.md`, work-package **N1**): the notion of an
**anti-unitary** operator (Note 4) and the two **Def 8** structures attached to a
system — a **C-conjugation** on a complex system and an **R-imaginary** operator
on a real system — together with the elementary structural lemmas about them.

An anti-unitary operator on a complex inner-product space is exactly a
conjugate-linear isometric equivalence, i.e. a `LinearIsometryEquiv` whose ring
homomorphism is complex conjugation `starRingEnd ℂ` (`V ≃ₗᵢ⋆[ℂ] V`).  We take
this as the definition of `AntiUnitary V`, so that the whole `LinearIsometryEquiv`
API is available.

The deep §A.1 propositions (Prop 11/12, the R-real/R-pseudoreal/R-complex
trichotomy) require a *complex inner-product* structure on the complexification
`W^c = ℂ ⊗_ℝ W` of a real Hilbert space, which is **not** available in Mathlib and
would have to be built from scratch; that remains an outstanding obstruction
recorded in `BookProof/STATUS.md`.  Everything in this file is `sorry`-free and
`axiom`-free.
-/

open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

namespace BookProof.ChapterA

/-! ## Note 4 / Def 8 — anti-unitary operators -/

/-- **Note 4 (anti-unitary operator).** An anti-unitary operator on a complex
inner-product space `V` is a conjugate-linear (semilinear over `starRingEnd ℂ`)
isometric equivalence of `V`. -/
abbrev AntiUnitary (V : Type*) [NormedAddCommGroup V] [InnerProductSpace ℂ V] :=
  V ≃ₗᵢ⋆[ℂ] V

namespace AntiUnitary

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

/--
An anti-unitary operator preserves the inner product up to complex
conjugation: `⟪θ x, θ y⟫ = conj ⟪x, y⟫`.
-/
lemma inner_map_map (θ : AntiUnitary V) (x y : V) :
    inner ℂ (θ x) (θ y) = conj (inner ℂ x y) := by
  rw [inner_eq_sum_norm_sq_div_four (𝕜 := ℂ), inner_eq_sum_norm_sq_div_four (𝕜 := ℂ)]
  have hn : ∀ z : V, ‖θ z‖ = ‖z‖ := fun z => θ.norm_map z
  have hI : (RCLike.I : ℂ) • θ y = θ (-(RCLike.I : ℂ) • y) := by
    rw [θ.map_smulₛₗ]; simp
  have e1 : ‖θ x + θ y‖ = ‖x + y‖ := by rw [← map_add, hn]
  have e2 : ‖θ x - θ y‖ = ‖x - y‖ := by rw [← map_sub, hn]
  have e3 : ‖θ x + (RCLike.I : ℂ) • θ y‖ = ‖x - (RCLike.I : ℂ) • y‖ := by
    rw [hI, ← map_add, hn, neg_smul, ← sub_eq_add_neg]
  have e4 : ‖θ x - (RCLike.I : ℂ) • θ y‖ = ‖x + (RCLike.I : ℂ) • y‖ := by
    rw [hI, ← map_sub, hn, neg_smul, sub_neg_eq_add]
  rw [e1, e2, e3, e4, map_div₀]
  apply Complex.ext <;>
    simp [Complex.div_re, Complex.div_im, Complex.add_im, Complex.add_re, Complex.mul_re,
      Complex.mul_im] <;> ring

/-- The composite of two anti-unitary operators preserves the inner product
(it is a unitary): `⟪θ' (θ x), θ' (θ y)⟫ = ⟪x, y⟫`. -/
lemma comp_inner (θ θ' : AntiUnitary V) (x y : V) :
    inner ℂ (θ' (θ x)) (θ' (θ y)) = inner ℂ x y := by
  rw [inner_map_map, inner_map_map]; simp

end AntiUnitary

/-! ## Def 8 — C-conjugation and R-imaginary structures on a system -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-- **Def 8.1 (C-conjugation).** On a complex system `(M, V)`, a *C-conjugation*
`θ` is an anti-unitary **involution** (`θ² = 1`) commuting with every `m ∈ M`. -/
def IsConjugation (M : System ℂ V) (θ : AntiUnitary V) : Prop :=
  (∀ x, θ (θ x) = x) ∧ (∀ m ∈ M.ops, ∀ x, θ (m x) = m (θ x))

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

/-- **Def 8.2 (R-imaginary).** On a real system `(M, W)`, an *R-imaginary*
operator `J` is a (linear) isometry with `J² = -1` commuting with every
`m ∈ M`. -/
def IsRImaginary (M : System ℝ W) (J : W ≃ₗᵢ[ℝ] W) : Prop :=
  (∀ x, J (J x) = -x) ∧ (∀ m ∈ M.ops, ∀ x, J (m x) = m (J x))

/-! ### Structural lemmas for a C-conjugation -/

omit [CompleteSpace V] in
/-- If `θ y = -y` (an anti-fixed vector of a conjugation) then `Complex.I • y` is
fixed by `θ`.  Hence the `(-1)`-eigenspace of `θ` is `I •` the fixed space. -/
lemma conjugation_smul_I_of_neg (θ : AntiUnitary V) {y : V} (hy : θ y = -y) :
    θ (Complex.I • y) = Complex.I • y := by
  convert θ.map_smulₛₗ ( Complex.I : ℂ ) y using 1
  simp [ hy ]

omit [CompleteSpace V] in
/-- The averaging map `x ↦ ½ • (x + θ x)` lands in the fixed space of a
conjugation `θ`. -/
lemma conjugation_avg_fixed (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = x) (x : V) :
    θ ((2⁻¹ : ℂ) • (x + θ x)) = (2⁻¹ : ℂ) • (x + θ x) := by
  have key : θ (x + θ x) = x + θ x := by rw [map_add, hθ, add_comm]
  rw [θ.map_smulₛₗ, key]
  simp [map_ofNat]

omit [CompleteSpace V] in
/-- The complementary averaging map `x ↦ ½ • (x - θ x)` lands in the
`(-1)`-eigenspace of a conjugation `θ`. -/
lemma conjugation_avg_antifixed (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = x) (x : V) :
    θ ((2⁻¹ : ℂ) • (x - θ x)) = -((2⁻¹ : ℂ) • (x - θ x)) := by
  have key : θ ( x - θ x ) = - ( x - θ x ) := by
    have := θ.map_sub x ( θ x ) ; simp_all [ sub_eq_add_neg ]
  convert congr_arg ( fun y => ( 2⁻¹ : ℂ ) • y ) key using 1;
  · convert θ.map_smulₛₗ ( 2⁻¹ : ℂ ) ( x - θ x ) using 1;
    erw [ Complex.conj_inv, Complex.conj_ofReal ] ; norm_num;
  · rw [ smul_neg ]

omit [CompleteSpace V] in
/-- **Real form decomposition.** Every vector splits as a `θ`-fixed part plus a
`θ`-anti-fixed part. -/
lemma conjugation_decomp (θ : AntiUnitary V) (x : V) :
    x = (2⁻¹ : ℂ) • (x + θ x) + (2⁻¹ : ℂ) • (x - θ x) := by
  rw [ ← smul_add, add_comm ];
  simp [ ← two_smul ℂ ]

/-! ### Structural lemmas for an R-imaginary operator -/

omit [CompleteSpace W] in
/-- An R-imaginary operator is skew: `⟪J x, x⟫_ℝ = 0` for every `x`. -/
lemma rimaginary_orthogonal (J : W ≃ₗᵢ[ℝ] W) (hJ : ∀ x, J (J x) = -x) (x : W) :
    inner ℝ (J x) x = 0 := by
  have := J.inner_map_map ( J x ) x; simp_all [ inner_neg_left ] ;
  linarith [ real_inner_comm x ( J x ) ]

omit [CompleteSpace W] in
/-- An R-imaginary operator squares to `-1` as an equivalence: its inverse is
`-J`. -/
lemma rimaginary_symm_apply (J : W ≃ₗᵢ[ℝ] W) (hJ : ∀ x, J (J x) = -x) (x : W) :
    J.symm x = -J x := by
  apply J.injective
  rw [J.apply_symm_apply, map_neg, hJ, neg_neg]

end BookProof.ChapterA

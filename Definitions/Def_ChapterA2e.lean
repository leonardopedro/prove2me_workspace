import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA2
import Definitions.Def_ChapterA2b
import Definitions.Def_ChapterA2c
import Mathlib


/-!
# Chapter A, §A.2 — realification isomorphism criterion (Prop 16), N2 leftover

This file discharges the **Prop 16** leftover of work-package **N2** of
`FORMALIZATION_ROADMAP.md` (§A.2, the commutant classification): the criterion
that identifies C-complex / C-pseudoreal Schur systems by their *realifications*.

## The framework

For a complex system `(M, V)` its **realification** `(M, V^r)` is `V` viewed as a
real inner-product space (`Module ℝ V` / `V →L[ℝ] V`) with the operators of `M`
restricted to `ℝ`-scalars (`ContinuousLinearMap.restrictScalars ℝ`).  A
**realification isometry** between `(M, V)` and `(N, W)` is an `ℝ`-linear
isometric equivalence `β : V ≃ₗᵢ[ℝ] W` carrying the realified `M` onto the
realified `N` by conjugation (`IsRealSystemIso`).

In this language a *complex system isometry* is a realification isometry that is
additionally **`ℂ`-linear** (`∀ x, β (i • x) = i • β x`), and a *complex system
antiisometry* is one that is **`ℂ`-antilinear** (`∀ x, β (i • x) = -(i • β x)`).
Thus **Prop 16** ("two C-complex / C-pseudoreal Schur systems are isometric *or*
antiisometric iff their realifications are isometric") becomes:

> a realification isometry that is `ℂ`-linear or `ℂ`-antilinear exists **iff** a
> realification isometry exists.

The backward direction is trivial.  The forward (content) direction is proved via
the **real commutant classification** already established in `ChapterA2c.lean`
(Props 18–19): the operator `K := β ∘ (i·) ∘ β⁻¹` is an `ℝ`-linear operator of
the realified target commuting with `N` and squaring to `-1`, i.e. an element of
the real commutant.

* **C-complex case.**  By Prop 18 (`Rcomplex_realCommutant_eq_complex`) the real
  commutant is `ℂ`, so `K = c·1` with `c² = -1`, i.e. `c = ±i`; since
  `K (β x) = β (i • x)` this says `β (i • x) = ±(i • β x)`, i.e. `β` is *itself*
  `ℂ`-linear or `ℂ`-antilinear.  (`Ccomplex_realification_dichotomy`,
  `Ccomplex_iso_or_antiiso_iff_realification_iso`.)

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped ComplexConjugate InnerProductSpace

namespace BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

/-! ## Realification isometries -/

/-- The underlying `ℝ`-linear continuous map of an `ℝ`-linear isometric
equivalence. -/
noncomputable def betaR (β : V ≃ₗᵢ[ℝ] W) : V →L[ℝ] W :=
  β.toContinuousLinearEquiv.toContinuousLinearMap



/-- Conjugation of an `ℝ`-linear operator `m : V →L[ℝ] V` by an `ℝ`-linear
isometric equivalence `β : V ≃ₗᵢ[ℝ] W`, giving `β ∘ m ∘ β⁻¹ : W →L[ℝ] W`. -/
noncomputable def conjClmR (β : V ≃ₗᵢ[ℝ] W) (m : V →L[ℝ] V) : W →L[ℝ] W :=
  (betaR β) ∘L m ∘L (betaR β.symm)



/-- A **realification system isometry** between complex systems `(M, V)` and
`(N, W)`: the `ℝ`-linear isometric equivalence `β` carries the realified `M` onto
the realified `N` by conjugation. -/
def IsRealSystemIso (M : System ℂ V) (N : System ℂ W) (β : V ≃ₗᵢ[ℝ] W) : Prop :=
  (fun n : W →L[ℂ] W => n.restrictScalars ℝ) '' N.ops
    = (fun m : V →L[ℂ] V => conjClmR β (m.restrictScalars ℝ)) '' M.ops

/-- `ℂ`-linearity of a realification isometry — it *is* a complex system
isometry. -/
def CLinear (β : V ≃ₗᵢ[ℝ] W) : Prop := ∀ x, β (Complex.I • x) = Complex.I • β x

/-- `ℂ`-antilinearity of a realification isometry — it *is* a complex system
antiisometry. -/
def CAntilinear (β : V ≃ₗᵢ[ℝ] W) : Prop := ∀ x, β (Complex.I • x) = -(Complex.I • β x)

/-! ## The transported complex structure `K = β ∘ (i·) ∘ β⁻¹` -/

/-- The transported complex structure: `K := β ∘ mulI ∘ β⁻¹`, an `ℝ`-linear
operator on `W`. -/
noncomputable def transK (β : V ≃ₗᵢ[ℝ] W) : W →L[ℝ] W := conjClmR β mulI











/-! ## C-complex case (Prop 16) -/





/-! ## C-pseudoreal case: the `rot` (quaternion) rotations

The C-pseudoreal target carries a commuting anti-unitary `θN` with `θN² = -1`.
By Prop 19 (`Rpseudoreal_realCommutant_eq_quaternion`) the real commutant is the
quaternions `ℝ⟨1, i, θN, i·θN⟩`.  We realize this algebra concretely through the
operators `rot θ p s : w ↦ p • w + s • θ w` (`p, s : ℂ`), which is the quaternion
`p + s·j` acting on `w`; `rot` composition is quaternion multiplication and, for a
`θ`-anti-unitary with `θ² = -1`, the crucial orthogonality `x ⊥ θ x`
(`theta_inner_self_zero`, a Frobenius–Schur relation) makes every unit `rot` an
isometry. -/

section Rot

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- Scalar multiplication by `p : ℂ` as an `ℝ`-linear operator. -/
noncomputable def cScal (p : ℂ) : H →L[ℝ] H :=
  ContinuousLinearMap.restrictScalars ℝ (p • (1 : H →L[ℂ] H))

omit [CompleteSpace H] in
@[simp] lemma cScal_apply (p : ℂ) (w : H) : cScal p w = p • w := by simp [cScal]

/-- The quaternion rotation `w ↦ p • w + s • θ w`. -/
noncomputable def rot (θ : AntiUnitary H) (p s : ℂ) : H →L[ℝ] H :=
  cScal p + cScal s ∘L thetaR θ

omit [CompleteSpace H] in
@[simp] lemma rot_apply (θ : AntiUnitary H) (p s : ℂ) (w : H) :
    rot θ p s w = p • w + s • θ w := by simp [rot, cScal_apply, thetaR_apply]

omit [CompleteSpace H] in
/-- **Frobenius–Schur orthogonality.**  For an anti-unitary `θ` with `θ² = -1`,
every vector is orthogonal to its image `x ⊥ θ x`. -/
lemma theta_inner_self_zero (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) (x : H) :
    inner ℂ x (θ x) = (0 : ℂ) := by
  have h1 : inner ℂ (θ x) (θ (θ x)) = conj (inner ℂ x (θ x)) := θ.inner_map_map x (θ x)
  rw [hθ x, inner_neg_right, inner_conj_symm] at h1
  have h2 : inner ℂ (θ x) x = (0 : ℂ) := by linear_combination (-1 / 2 : ℂ) * h1
  rw [← inner_conj_symm, h2, map_zero]

omit [CompleteSpace H] in
/-- `rot` composition is quaternion multiplication `(p₁ + s₁ j)(p₂ + s₂ j)`. -/
lemma rot_comp (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) (p1 s1 p2 s2 : ℂ) :
    rot θ p1 s1 ∘L rot θ p2 s2
      = rot θ (p1 * p2 - s1 * conj s2) (p1 * s2 + s1 * conj p2) := by
  ext w
  simp only [ContinuousLinearMap.comp_apply, rot_apply, map_add, map_smulₛₗ, smul_smul, hθ w]
  simp only [smul_neg, sub_smul, add_smul, mul_smul]; abel

omit [CompleteSpace H] in
/-- The squared norm of a `rot` image: `‖rot θ p s x‖² = (‖p‖² + ‖s‖²)·‖x‖²`. -/
lemma rot_normSq (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) (p s : ℂ) (x : H) :
    ‖rot θ p s x‖ ^ 2 = (‖p‖ ^ 2 + ‖s‖ ^ 2) * ‖x‖ ^ 2 := by
  rw [rot_apply]
  have horth : inner ℂ (p • x) (s • θ x) = (0 : ℂ) := by
    rw [inner_smul_left, inner_smul_right, theta_inner_self_zero θ hθ x]; ring
  rw [norm_add_sq (𝕜 := ℂ), horth]; simp only [map_zero, mul_zero, add_zero]
  rw [norm_smul, norm_smul, θ.norm_map, mul_pow, mul_pow]; ring

omit [CompleteSpace H] in
/-- Unit `rot`s are isometries. -/
lemma rot_isometry (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) (p s : ℂ)
    (hps : ‖p‖ ^ 2 + ‖s‖ ^ 2 = 1) (x : H) : ‖rot θ p s x‖ = ‖x‖ := by
  have hsq : ‖rot θ p s x‖ ^ 2 = ‖x‖ ^ 2 := by rw [rot_normSq θ hθ, hps, one_mul]
  have h := congr_arg Real.sqrt hsq
  rwa [Real.sqrt_sq (norm_nonneg _), Real.sqrt_sq (norm_nonneg _)] at h

omit [CompleteSpace H] in
lemma rot_one_zero (θ : AntiUnitary H) : rot θ 1 0 = (1 : H →L[ℝ] H) := by ext w; simp



/-- A unit `rot` as an `ℝ`-linear isometric equivalence. -/
noncomputable def rotEquiv (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) (p s : ℂ)
    (hps : ‖p‖ ^ 2 + ‖s‖ ^ 2 = 1) : H ≃ₗᵢ[ℝ] H := by
  have hinvR : rot θ p s ∘L rot θ (conj p) (-s) = 1 := by
    rw [rot_comp θ hθ]
    have h1 : p * conj p - s * conj (-s) = 1 := by
      rw [map_neg, mul_neg, sub_neg_eq_add, Complex.mul_conj, Complex.mul_conj]
      push_cast [Complex.normSq_eq_norm_sq]; exact_mod_cast hps
    have h2 : p * -s + s * conj (conj p) = 0 := by rw [Complex.conj_conj]; ring
    rw [h1, h2, rot_one_zero]
  refine LinearIsometryEquiv.ofSurjective
    ⟨(rot θ p s).toLinearMap, fun x => rot_isometry θ hθ p s hps x⟩ ?_
  intro w
  exact ⟨rot θ (conj p) (-s) w, by
    have := congr_arg (fun T : H →L[ℝ] H => T w) hinvR; simpa using this⟩









end Rot

/-! ## C-pseudoreal case (Prop 16) -/









end BookProof.ChapterA

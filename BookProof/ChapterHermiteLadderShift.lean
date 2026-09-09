import Mathlib
import BookProof.ChapterHermiteRelativeBound
import BookProof.ChapterQgHermiteOscillatorEsa

/-!
# Ladder monomials on the Gauss–polynomial core, and the harmonic relative bound

This module supplies the analytic instrument that the Faris–Lavine route to the
quantum-gravity Hamiltonian on the outer Fock space needs: a **relative bound with respect
to the harmonic comparison operator** `N = −Δ + ‖x‖²/4` for every quadratic expression in
the canonical pair, with a constant read off the coefficients and *independent of the
dimension* except through those coefficients.

The mechanism is the product Hermite basis `ψ_α` of `L²(ℝᵈ)`
(`BookProof.ChapterHermiteProductBasis`).  A ladder operator acts on it as a *weighted
shift*

`a_i ψ_α = √αᵢ ψ_{α−eᵢ}`,  `a_i† ψ_α = √(αᵢ+1) ψ_{α+eᵢ}`,

so a product of two ladder operators is again a weighted shift, with an index map that is
injective wherever its weight does not vanish and with weight at most `mvDeg α + 2`.
Since `N` is diagonal with symbol `mvDeg α + d/2`, a weighted shift with weight
`≤ K(w α + 1)` obeys `‖T u‖ ≤ K‖(N+1)u‖` on the core — that is the whole estimate, and it
is proved once, abstractly, for an arbitrary orthonormal family.

## What is proved

* `norm_sum_shift_sq` — Pythagoras for a weighted shift of an orthonormal family;
* `apply_sum_of_shift` — a weighted shift acts coefficientwise on a finite combination;
* `norm_shift_le_of_diagonal` — **the abstract relative bound**: a weighted shift whose
  weight is `≤ K(w + 1)` is bounded by `K` times the shifted diagonal operator `N + 1`.

The estimates are stated for an arbitrary orthonormal family spanning the domain, so they
apply verbatim to the product Hermite basis of `L²(ℝᵈ)` in every dimension; the concrete
quantum-gravity instances of the Faris–Lavine inequalities are assembled by the Gaussian
integral route of `BookProof.ChapterGaussCoreQuadBounds` and
`BookProof.ChapterSqSumFarisLavine`, which give constants that do not degrade with the
dimension.

Everything here is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HermiteLadder

open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QgHermiteOscillator
open BookProof.HyperbolicQuadratic

noncomputable section

/-! ## 1. Weighted shifts of an orthonormal family -/

section Abstract

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}

/-- **Pythagoras for a weighted shift.**  If the index map is injective on the summation
set, the shifted family is orthonormal there. -/
theorem norm_sum_shift_sq (v : ι → E) (hv : Orthonormal ℂ v) (σ : ι → ι) (S : Finset ι)
    (hinj : ∀ a ∈ S, ∀ b ∈ S, σ a = σ b → a = b) (g : ι → ℂ) :
    ‖∑ a ∈ S, g a • v (σ a)‖ ^ 2 = ∑ a ∈ S, ‖g a‖ ^ 2 := by
  classical
  have hio : ∀ i j : ι, (inner ℂ (v i) (v j) : ℂ) = if i = j then 1 else 0 := by
    intro i j
    by_cases h : i = j
    · subst h
      rw [inner_self_eq_norm_sq_to_K, hv.1 i, if_pos rfl]
      norm_num
    · rw [hv.inner_eq_zero h, if_neg h]
  have hinner : (inner ℂ (∑ a ∈ S, g a • v (σ a)) (∑ a ∈ S, g a • v (σ a)) : ℂ)
      = ∑ a ∈ S, ((‖g a‖ ^ 2 : ℝ) : ℂ) := by
    rw [sum_inner]
    refine Finset.sum_congr rfl fun a ha => ?_
    rw [inner_smul_left, inner_sum]
    have hterm : ∀ b ∈ S, (inner ℂ (v (σ a)) (g b • v (σ b)) : ℂ)
        = if b = a then g a else 0 := by
      intro b hb
      rw [inner_smul_right, hio]
      by_cases hab : b = a
      · subst hab; simp
      · have hne : ¬ (σ a = σ b) := fun h => hab (hinj b hb a ha h.symm)
        simp [hne, hab]
    rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq' S a]
    rw [if_pos ha]
    rw [← Complex.normSq_eq_conj_mul_self]
    simp [Complex.normSq_eq_norm_sq]
  have hre := congrArg Complex.re hinner
  rw [inner_self_eq_norm_sq_to_K] at hre
  simpa [← Complex.ofReal_pow, Complex.re_sum] using hre

/-- A weighted shift acts coefficientwise on a finite combination of the shifted family. -/
theorem apply_sum_of_shift (v : ι → E) (σ : ι → ι) (s : ι → ℂ) {D : Submodule ℂ E}
    (hvD : ∀ a, v a ∈ D) (T : D →ₗ[ℂ] E)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = s a • v (σ a))
    (S : Finset ι) (f : ι → ℂ) :
    ∀ hu : (∑ a ∈ S, f a • v a) ∈ D,
      T ⟨∑ a ∈ S, f a • v a, hu⟩ = ∑ a ∈ S, (f a * s a) • v (σ a) := by
  classical
  induction S using Finset.induction with
  | empty =>
      intro hu
      have h0 : (⟨∑ a ∈ (∅ : Finset ι), f a • v a, hu⟩ : D) = 0 := Subtype.ext (by simp)
      rw [h0, map_zero, Finset.sum_empty]
  | insert a S ha ih =>
      intro hu
      have hva : f a • v a ∈ D := Submodule.smul_mem _ _ (hvD a)
      have hs : (∑ b ∈ S, f b • v b) ∈ D :=
        Submodule.sum_mem _ fun b _ => Submodule.smul_mem _ _ (hvD b)
      have hsplit : (⟨∑ b ∈ insert a S, f b • v b, hu⟩ : D)
          = ⟨f a • v a, hva⟩ + ⟨∑ b ∈ S, f b • v b, hs⟩ := by
        apply Subtype.ext
        simpa using Finset.sum_insert ha
      have hsm : (⟨f a • v a, hva⟩ : D) = f a • ⟨v a, hvD a⟩ := Subtype.ext rfl
      rw [hsplit, map_add, hsm, map_smul, hT a (hvD a), ih hs, Finset.sum_insert ha, smul_smul]

/-- **The abstract relative bound.**  A weighted shift whose weight is bounded by
`K·(w + 1)`, with `w` the symbol of a diagonal operator `N`, obeys `‖T u‖ ≤ K‖(N+1)u‖`. -/
theorem norm_shift_le_of_diagonal (v : ι → E) (hv : Orthonormal ℂ v) {D : Submodule ℂ E}
    (hD : Submodule.span ℂ (Set.range v) = D)
    (T : D →ₗ[ℂ] E) (σ : ι → ι) (s : ι → ℂ)
    (hT : ∀ (a : ι) (h : v a ∈ D), T ⟨v a, h⟩ = s a • v (σ a))
    (hinj : ∀ a b : ι, s a ≠ 0 → s b ≠ 0 → σ a = σ b → a = b)
    (N : D →ₗ[ℂ] E) (w : ι → ℝ) (hw : ∀ a, 0 ≤ w a)
    (hN : ∀ (a : ι) (h : v a ∈ D), N ⟨v a, h⟩ = ((w a : ℝ) : ℂ) • v a)
    (K : ℝ) (hK : 0 ≤ K) (hs : ∀ a, ‖s a‖ ≤ K * (w a + 1)) (u : D) :
    ‖T u‖ ≤ K * ‖N u + (u : E)‖ := by
  classical
  have hvD : ∀ a, v a ∈ D := fun a => hD ▸ Submodule.subset_span ⟨a, rfl⟩
  have hmem : (u : E) ∈ Submodule.span ℂ (Set.range v) := hD ▸ u.2
  obtain ⟨f, hf⟩ := Finsupp.mem_span_range_iff_exists_finsupp.mp hmem
  have hfu : ∑ a ∈ f.support, f a • v a = (u : E) := hf
  have husub : u = ⟨∑ a ∈ f.support, f a • v a, hfu ▸ u.2⟩ := Subtype.ext hfu.symm
  -- the image of `u`
  have hTu : T u = ∑ a ∈ f.support, (f a * s a) • v (σ a) := by
    rw [husub]
    exact apply_sum_of_shift v σ s hvD T hT f.support f _
  -- the shifted diagonal image of `u`
  have hNu : N u + (u : E) = ∑ a ∈ f.support, (f a * ((w a + 1 : ℝ) : ℂ)) • v a := by
    have h1 : N u = ∑ a ∈ f.support, (((w a : ℝ) : ℂ) * f a) • v a := by
      rw [husub]
      exact apply_sum_of_diagonal v w hvD N hN f.support f _
    rw [h1]
    have h2 : (u : E) = ∑ a ∈ f.support, f a • v a := hfu.symm
    rw [h2, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← add_smul]
    congr 1
    push_cast
    ring
  -- Pythagoras on both sides
  set S₀ : Finset ι := f.support.filter (fun a => s a ≠ 0) with hS₀
  have hdrop : ∑ a ∈ f.support, (f a * s a) • v (σ a)
      = ∑ a ∈ S₀, (f a * s a) • v (σ a) := by
    refine (Finset.sum_subset (Finset.filter_subset _ _) ?_).symm
    intro a ha hna
    have hs0 : s a = 0 := by
      by_contra hne
      exact hna (Finset.mem_filter.mpr ⟨ha, hne⟩)
    simp [hs0]
  have hnormT : ‖T u‖ ^ 2 = ∑ a ∈ S₀, ‖f a * s a‖ ^ 2 := by
    rw [hTu, hdrop]
    refine norm_sum_shift_sq v hv σ S₀ ?_ _
    intro a ha b hb hab
    exact hinj a b (Finset.mem_filter.mp ha).2 (Finset.mem_filter.mp hb).2 hab
  have hnormN : ‖N u + (u : E)‖ ^ 2 = ∑ a ∈ f.support, ‖f a * ((w a + 1 : ℝ) : ℂ)‖ ^ 2 := by
    rw [hNu]
    exact norm_sum_shift_sq v hv id f.support (fun a _ b _ h => h) _
  have hle : ∑ a ∈ S₀, ‖f a * s a‖ ^ 2
      ≤ K ^ 2 * ∑ a ∈ f.support, ‖f a * ((w a + 1 : ℝ) : ℂ)‖ ^ 2 := by
    rw [Finset.mul_sum]
    refine le_trans (Finset.sum_le_sum_of_subset_of_nonneg (Finset.filter_subset _ _)
      (fun a _ _ => by positivity)) ?_
    refine Finset.sum_le_sum fun a _ => ?_
    have h1 : ‖f a * s a‖ ^ 2 = ‖f a‖ ^ 2 * ‖s a‖ ^ 2 := by
      rw [norm_mul]; ring
    have h2 : ‖f a * ((w a + 1 : ℝ) : ℂ)‖ ^ 2 = ‖f a‖ ^ 2 * (w a + 1) ^ 2 := by
      rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (by linarith [hw a])]
      ring
    rw [h1, h2]
    have hsa := hs a
    have hnn : (0 : ℝ) ≤ ‖f a‖ ^ 2 := by positivity
    have hsq : ‖s a‖ ^ 2 ≤ K ^ 2 * (w a + 1) ^ 2 := by
      have h0 : 0 ≤ ‖s a‖ := norm_nonneg _
      have h1' : 0 ≤ K * (w a + 1) := by
        have := hw a; positivity
      nlinarith [hsa]
    nlinarith [hnn, hsq]
  have hfin : ‖T u‖ ^ 2 ≤ (K * ‖N u + (u : E)‖) ^ 2 := by
    rw [hnormT, mul_pow]
    calc ∑ a ∈ S₀, ‖f a * s a‖ ^ 2
        ≤ K ^ 2 * ∑ a ∈ f.support, ‖f a * ((w a + 1 : ℝ) : ℂ)‖ ^ 2 := hle
      _ = K ^ 2 * ‖N u + (u : E)‖ ^ 2 := by rw [hnormN]
  have h1 : 0 ≤ K * ‖N u + (u : E)‖ := by positivity
  nlinarith [norm_nonneg (T u), hfin]

end Abstract

end

end BookProof.HermiteLadder

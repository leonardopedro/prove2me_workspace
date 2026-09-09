import Mathlib
import BookProof.ChapterHermiteGalerkinFriedrichs

/-!
# Chapter SirkRitzSpectrum — the Rayleigh–Ritz values converge to the bottom of the
spectrum

`CONSOLIDATED_PLAN.md` §12.2 **Gap 2, QYM**: "the Friedrichs route gives the
resolvent geometry; missing … the statement that the Ritz/gap values converge to
the *spectrum* of the Friedrichs extension as `m → ∞`".

`BookProof.HermiteGalerkin.ritzInf_tendsto_domainInf` already proves that the
Rayleigh–Ritz values of the Galerkin truncations decrease to the infimum of the
*energy form* over the finite-mode domain.  What was missing is the identification
of that limit with a *spectral* quantity — the bottom of the spectrum of the
selected (Friedrichs) extension.  This chapter supplies the missing link and the
assembled statement.

## Deliverables

* `rayleighSet` / `rayleighInf` — the Rayleigh quotients of the unit vectors of a
  bounded operator, and their infimum.
* `le_rayleigh_iff_le_spectrum` — **the numerical characterisation of the bottom of
  the spectrum**: for a bounded self-adjoint operator `T` and a real `c`,
  `c‖x‖² ≤ ⟪Tx, x⟫` for every `x` **iff** `c ≤ μ` for every `μ ∈ spectrum ℝ T`.
* `spectrum_real_nonempty`, `spectrum_real_bddBelow` — the real spectrum of a
  bounded self-adjoint operator on a nonzero Hilbert space is a nonempty set that
  is bounded below (by `−‖T‖`).
* `sInf_spectrum_eq_rayleighInf` — **the bottom of the spectrum is the bottom of the
  numerical range**, `sInf (spectrum ℝ T) = rayleighInf T`.
* `ritzInf_finiteModeDomain_eq_rayleighInf` — the Ritz infimum over the finite-mode
  (Hermite) domain equals the Rayleigh infimum over the whole space: the truncation
  domain is dense, and the Rayleigh quotient is continuous.
* `ritzInf_tendsto_sInf_spectrum` — **headline**: for a bounded positive
  self-adjoint operator, the Rayleigh–Ritz values of the Hermite–Galerkin
  truncations converge to `sInf (spectrum ℝ A)`.
* `galerkin_ritz_tendsto_sInf_spectrum_of_selected` — the same statement with the
  extension named: the limit is the bottom of the spectrum of the operator the
  Galerkin/Hashimoto algorithm *selects* (the positive self-adjoint extension of
  the matrix, which for the bounded regime is the Friedrichs extension of
  `BookProof.YangMillsFriedrichsLimit`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkRitzSpectrum

open BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. Two elementary identities -/

/-- For a self-adjoint operator the Rayleigh quotient is a real number. -/
theorem selfAdjoint_re_inner_coe (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) (x : F) :
    (((inner ℂ (T x) x : ℂ).re : ℝ) : ℂ) = inner ℂ (T x) x := by
  have hsym := (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hT) x x
  refine Complex.conj_eq_iff_re.mp ?_
  rw [inner_conj_symm]
  exact hsym.symm

omit [CompleteSpace F] in
/-- `⟪Tx, x⟫` and `⟪x, Tx⟫` are conjugate, hence have the same real part. -/
theorem re_inner_comm (T : F →L[ℂ] F) (x : F) :
    (inner ℂ (T x) x : ℂ).re = (inner ℂ x (T x) : ℂ).re := by
  have h : (starRingEnd ℂ) (inner ℂ x (T x)) = inner ℂ (T x) x := inner_conj_symm _ _
  rw [← h, Complex.conj_re]

omit [CompleteSpace F] in
/-- The Rayleigh quotient of the shifted operator `T − c`. -/
theorem re_inner_sub_algebraMap (T : F →L[ℂ] F) (c : ℝ) (x : F) :
    (inner ℂ ((T - (algebraMap ℝ (F →L[ℂ] F)) c) x) x : ℂ).re
      = (inner ℂ (T x) x : ℂ).re - c * ‖x‖ ^ 2 := by
  have h : (T - (algebraMap ℝ (F →L[ℂ] F)) c) x = T x - (c : ℂ) • x := by
    simp [Algebra.algebraMap_eq_smul_one]
  rw [h, inner_sub_left, Complex.sub_re, inner_smul_left]
  simp [Complex.conj_ofReal, inner_self_eq_norm_sq_to_K, ← Complex.ofReal_pow]

/-! ## 2. The numerical characterisation of the bottom of the spectrum -/

/-- **The bottom of the spectrum is the bottom of the numerical range, in
inequality form.**  A real number `c` is a lower bound for the Rayleigh quotients
of a bounded self-adjoint operator exactly when it is a lower bound for its
spectrum.  The proof runs through the C\*-algebra fact that a self-adjoint element
is nonnegative iff its spectrum is, applied to the shift `T − c`. -/
theorem le_rayleigh_iff_le_spectrum (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) (c : ℝ) :
    (∀ x : F, c * ‖x‖ ^ 2 ≤ (inner ℂ x (T x) : ℂ).re) ↔ ∀ μ ∈ spectrum ℝ T, c ≤ μ := by
  have hS : IsSelfAdjoint (T - (algebraMap ℝ (F →L[ℂ] F)) c) :=
    hT.sub (IsSelfAdjoint.algebraMap (F →L[ℂ] F) rfl)
  have hmain := StarOrderedRing.nonneg_iff_spectrum_nonneg
    (R := ℝ) (T - (algebraMap ℝ (F →L[ℂ] F)) c) hS
  have hpos : (0 ≤ T - (algebraMap ℝ (F →L[ℂ] F)) c) ↔
      ∀ x : F, c * ‖x‖ ^ 2 ≤ (inner ℂ x (T x) : ℂ).re := by
    rw [nonneg_iff_isPositive, isPositive_iff_complex]
    constructor
    · intro h x
      have h2 := (h x).2
      rw [RCLike.re_to_complex, re_inner_sub_algebraMap T c x] at h2
      rw [← re_inner_comm]
      linarith
    · intro h x
      refine ⟨by simpa only [RCLike.re_to_complex] using selfAdjoint_re_inner_coe _ hS x, ?_⟩
      rw [RCLike.re_to_complex, re_inner_sub_algebraMap T c x, re_inner_comm]
      linarith [h x]
  have hspec : spectrum ℝ (T - (algebraMap ℝ (F →L[ℂ] F)) c) = spectrum ℝ T - {c} :=
    (spectrum.sub_singleton_eq T c).symm
  rw [← hpos, hmain]
  constructor
  · intro h μ hμ
    have := h (μ - c) (by rw [hspec]; exact ⟨μ, hμ, c, rfl, rfl⟩)
    linarith
  · intro h ν hν
    rw [hspec] at hν
    obtain ⟨μ, hμ, d, hd, rfl⟩ := hν
    simp only [Set.mem_singleton_iff] at hd
    subst hd
    linarith [h μ hμ]

omit [CompleteSpace F] in
/-- The Rayleigh quotient is bounded, in absolute value, by the operator norm. -/
theorem abs_re_inner_le (T : F →L[ℂ] F) (x : F) :
    |(inner ℂ x (T x) : ℂ).re| ≤ ‖T‖ * ‖x‖ ^ 2 := by
  calc |(inner ℂ x (T x) : ℂ).re| ≤ ‖(inner ℂ x (T x) : ℂ)‖ := Complex.abs_re_le_norm _
    _ ≤ ‖x‖ * ‖T x‖ := norm_inner_le_norm _ _
    _ ≤ ‖x‖ * (‖T‖ * ‖x‖) := mul_le_mul_of_nonneg_left (T.le_opNorm x) (norm_nonneg _)
    _ = ‖T‖ * ‖x‖ ^ 2 := by ring

omit [CompleteSpace F] in
/-- The Rayleigh quotient of a unit vector is bounded by the operator norm. -/
theorem re_inner_le_norm (T : F →L[ℂ] F) (x : F) :
    (inner ℂ x (T x) : ℂ).re ≤ ‖T‖ * ‖x‖ ^ 2 :=
  (le_abs_self _).trans (abs_re_inner_le T x)

omit [CompleteSpace F] in
/-- The Rayleigh quotient of a unit vector is bounded below by `−‖T‖`. -/
theorem neg_norm_le_re_inner (T : F →L[ℂ] F) (x : F) :
    -(‖T‖ * ‖x‖ ^ 2) ≤ (inner ℂ x (T x) : ℂ).re :=
  neg_le_of_abs_le (abs_re_inner_le T x)

/-- The real spectrum of a bounded self-adjoint operator on a nonzero Hilbert space
is nonempty. -/
theorem spectrum_real_nonempty [Nontrivial F] (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) :
    (spectrum ℝ T).Nonempty := by
  by_contra hempty
  rw [Set.not_nonempty_iff_eq_empty] at hempty
  obtain ⟨y, hy⟩ := exists_ne (0 : F)
  set x : F := ‖y‖⁻¹ • y with hx
  have hxnorm : ‖x‖ = 1 := by
    rw [hx, norm_smul]
    simp [norm_ne_zero_iff.mpr hy]
  have hbound := (le_rayleigh_iff_le_spectrum T hT (‖T‖ + 1)).mpr
    (by intro μ hμ; rw [hempty] at hμ; simp at hμ) x
  have hupper := re_inner_le_norm T x
  rw [hxnorm] at hbound hupper
  norm_num at hbound hupper
  linarith

/-- The real spectrum of a bounded self-adjoint operator is bounded below, by `−‖T‖`. -/
theorem spectrum_real_bddBelow (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) :
    BddBelow (spectrum ℝ T) := by
  refine ⟨-‖T‖, ?_⟩
  intro μ hμ
  refine (le_rayleigh_iff_le_spectrum T hT (-‖T‖)).mp ?_ μ hμ
  intro x
  have := neg_norm_le_re_inner T x
  linarith

/-! ## 3. The bottom of the spectrum as an infimum of Rayleigh quotients -/

/-- The set of Rayleigh quotients of the unit vectors of a bounded operator. -/
def rayleighSet (T : F →L[ℂ] F) : Set ℝ :=
  {t : ℝ | ∃ x : F, ‖x‖ = 1 ∧ t = (inner ℂ x (T x) : ℂ).re}

/-- The bottom of the numerical range. -/
def rayleighInf (T : F →L[ℂ] F) : ℝ := sInf (rayleighSet T)

omit [CompleteSpace F] in
theorem rayleighSet_nonempty [Nontrivial F] (T : F →L[ℂ] F) : (rayleighSet T).Nonempty := by
  obtain ⟨y, hy⟩ := exists_ne (0 : F)
  refine ⟨_, ‖y‖⁻¹ • y, ?_, rfl⟩
  rw [norm_smul]
  simp [norm_ne_zero_iff.mpr hy]

omit [CompleteSpace F] in
theorem rayleighSet_bddBelow (T : F →L[ℂ] F) : BddBelow (rayleighSet T) := by
  refine ⟨-‖T‖, ?_⟩
  rintro t ⟨x, hx1, rfl⟩
  have := neg_norm_le_re_inner T x
  rw [hx1] at this
  simpa using this

omit [CompleteSpace F] in
/-- The Rayleigh quotient scales quadratically under a real rescaling. -/
theorem re_inner_real_smul (T : F →L[ℂ] F) (c : ℝ) (x : F) :
    (inner ℂ ((c : ℂ) • x) (T ((c : ℂ) • x)) : ℂ).re = c ^ 2 * (inner ℂ x (T x) : ℂ).re := by
  rw [ContinuousLinearMap.map_smul, inner_smul_left, inner_smul_right]
  simp [Complex.conj_ofReal, ← mul_assoc, ← Complex.ofReal_mul, sq]

omit [CompleteSpace F] in
/-- A Rayleigh quotient bound for unit vectors upgrades to all vectors. -/
theorem rayleighInf_mul_normSq_le [Nontrivial F] (T : F →L[ℂ] F) (x : F) :
    rayleighInf T * ‖x‖ ^ 2 ≤ (inner ℂ x (T x) : ℂ).re := by
  rcases eq_or_ne x 0 with rfl | hx
  · simp
  · have hxpos : (0 : ℝ) < ‖x‖ := norm_pos_iff.mpr hx
    set u : F := ((‖x‖⁻¹ : ℝ) : ℂ) • x with hu
    have hunorm : ‖u‖ = 1 := by
      rw [hu, norm_smul]
      simp [hxpos.ne']
    have hmem : (inner ℂ u (T u) : ℂ).re ∈ rayleighSet T := ⟨u, hunorm, rfl⟩
    have hle : rayleighInf T ≤ (inner ℂ u (T u) : ℂ).re :=
      csInf_le (rayleighSet_bddBelow T) hmem
    have hval : (inner ℂ u (T u) : ℂ).re = ‖x‖⁻¹ ^ 2 * (inner ℂ x (T x) : ℂ).re := by
      rw [hu, re_inner_real_smul T (‖x‖⁻¹) x]
    rw [hval] at hle
    have hsq : (0 : ℝ) < ‖x‖ ^ 2 := by positivity
    have := mul_le_mul_of_nonneg_right hle (le_of_lt hsq)
    calc rayleighInf T * ‖x‖ ^ 2 ≤ ‖x‖⁻¹ ^ 2 * (inner ℂ x (T x) : ℂ).re * ‖x‖ ^ 2 := this
      _ = (inner ℂ x (T x) : ℂ).re := by
          field_simp

/-- **The bottom of the spectrum equals the bottom of the numerical range.** -/
theorem sInf_spectrum_eq_rayleighInf [Nontrivial F] (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) :
    sInf (spectrum ℝ T) = rayleighInf T := by
  have hspecne := spectrum_real_nonempty T hT
  have hspecbdd := spectrum_real_bddBelow T hT
  refine le_antisymm ?_ ?_
  · -- every Rayleigh quotient dominates the bottom of the spectrum
    refine le_csInf (rayleighSet_nonempty T) ?_
    rintro t ⟨x, hx1, rfl⟩
    have hlb : ∀ μ ∈ spectrum ℝ T, sInf (spectrum ℝ T) ≤ μ := fun μ hμ => csInf_le hspecbdd hμ
    have := (le_rayleigh_iff_le_spectrum T hT (sInf (spectrum ℝ T))).mpr hlb x
    rwa [hx1, one_pow, mul_one] at this
  · -- and the bottom of the numerical range is a lower bound for the spectrum
    refine le_csInf hspecne ?_
    intro μ hμ
    exact (le_rayleigh_iff_le_spectrum T hT (rayleighInf T)).mp
      (rayleighInf_mul_normSq_le T) μ hμ

/-! ## 4. The Ritz infimum over the finite-mode domain is the Rayleigh infimum -/

omit [CompleteSpace F] in
/-- The Ritz values available on the finite-mode domain are Rayleigh quotients. -/
theorem ritzSet_subset_rayleighSet (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    ritzSet (finiteModeRestrict A b) (finiteModeDomain b) ⊆ rayleighSet A := by
  rintro t ⟨x, -, hx1, rfl⟩
  exact ⟨(x : F), hx1, rfl⟩

omit [CompleteSpace F] in
/-- The Ritz set of the finite-mode restriction, written without the subtype. -/
theorem ritzSet_finiteModeRestrict_eq (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    ritzSet (finiteModeRestrict A b) (finiteModeDomain b) =
      {t : ℝ | ∃ u : F, u ∈ finiteModeDomain b ∧ ‖u‖ = 1 ∧ t = (inner ℂ u (A u) : ℂ).re} := by
  ext t
  constructor
  · rintro ⟨x, -, hx1, rfl⟩
    exact ⟨(x : F), x.2, hx1, rfl⟩
  · rintro ⟨u, hu, hu1, rfl⟩
    exact ⟨⟨u, hu⟩, hu, hu1, rfl⟩

omit [CompleteSpace F] in
theorem ritzSet_finiteModeRestrict_bddBelow (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    BddBelow (ritzSet (finiteModeRestrict A b) (finiteModeDomain b)) :=
  (rayleighSet_bddBelow A).mono (ritzSet_subset_rayleighSet A b)

omit [CompleteSpace F] in
/-- **The truncation domain sees the whole numerical range.**  The finite-mode
(Hermite) domain is dense and the Rayleigh quotient is continuous, so every
Rayleigh quotient is approximated by Ritz values of the finite-mode domain. -/
theorem ritzInf_finiteModeDomain_le (A : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    {x : F} (hx1 : ‖x‖ = 1) :
    ritzInf (finiteModeRestrict A b) (finiteModeDomain b) ≤ (inner ℂ x (A x) : ℂ).re := by
  have hbdd := ritzSet_finiteModeRestrict_bddBelow A b
  rw [ritzSet_finiteModeRestrict_eq A b] at hbdd
  change sInf (ritzSet (finiteModeRestrict A b) (finiteModeDomain b)) ≤ _
  rw [ritzSet_finiteModeRestrict_eq A b]
  set S : Submodule ℂ F := finiteModeDomain b with hS
  have hdense : Dense (S : Set F) := finiteModeDomain_dense b
  have hf : Continuous (fun z : F => (inner ℂ z (A z) : ℂ).re) := by fun_prop
  choose y hymem hydist using
    fun n : ℕ => Metric.mem_closure_iff.mp (hdense x) (1 / (n + 1)) (by positivity)
  have hy : Tendsto y atTop (nhds x) := by
    rw [tendsto_iff_dist_tendsto_zero]
    refine squeeze_zero (fun n => dist_nonneg) (fun n => ?_)
      tendsto_one_div_add_atTop_nhds_zero_nat
    rw [dist_comm]
    exact (hydist n).le
  have hnorm : Tendsto (fun n => ‖y n‖) atTop (nhds 1) := by
    simpa [hx1] using (continuous_norm.continuousAt.tendsto.comp hy)
  set u : ℕ → F := fun n => ‖y n‖⁻¹ • y n with hu
  have hutend : Tendsto u atTop (nhds x) := by
    have h1 : Tendsto (fun n => ‖y n‖⁻¹) atTop (nhds 1) := by
      simpa using hnorm.inv₀ (by norm_num)
    have := h1.smul hy
    simpa [hu] using this
  have hev : ∀ᶠ n in atTop, ‖u n‖ = 1 := by
    have hpos : ∀ᶠ n in atTop, (0 : ℝ) < ‖y n‖ := hnorm.eventually_const_lt (by norm_num)
    filter_upwards [hpos] with n hn
    rw [hu]
    simp [norm_smul, hn.ne']
  have hle : ∀ᶠ n in atTop, sInf {t : ℝ | ∃ w : F, w ∈ S ∧ ‖w‖ = 1 ∧
      t = (inner ℂ w (A w) : ℂ).re} ≤ (inner ℂ (u n) (A (u n)) : ℂ).re := by
    filter_upwards [hev] with n hn
    exact csInf_le hbdd ⟨u n, S.smul_mem _ (hymem n), hn, rfl⟩
  exact ge_of_tendsto ((hf.tendsto x).comp hutend) hle

omit [CompleteSpace F] in
/-- **The Ritz infimum over the finite-mode (Hermite) domain is the bottom of the
numerical range.** -/
theorem ritzInf_finiteModeDomain_eq_rayleighInf [Nontrivial F] (A : F →L[ℂ] F)
    (b : HilbertBasis ℕ ℂ F) :
    ritzInf (finiteModeRestrict A b) (finiteModeDomain b) = rayleighInf A := by
  refine le_antisymm ?_ ?_
  · refine le_csInf (rayleighSet_nonempty A) ?_
    rintro t ⟨x, hx1, rfl⟩
    exact ritzInf_finiteModeDomain_le A b hx1
  · refine csInf_le_csInf (rayleighSet_bddBelow A) ?_ (ritzSet_subset_rayleighSet A b)
    exact ⟨(inner ℂ (b 0) (A (b 0)) : ℂ).re, ⟨⟨b 0, Submodule.subset_span ⟨0, rfl⟩⟩,
      Submodule.subset_span ⟨0, rfl⟩, b.orthonormal.1 0, rfl⟩⟩

/-! ## 5. The headline: Ritz values converge to the bottom of the spectrum -/

/-- **The Rayleigh–Ritz values converge to the bottom of the spectrum.** -/
theorem ritzInf_tendsto_sInf_spectrum [Nontrivial F] (A : F →L[ℂ] F) (hsa : IsSelfAdjoint A)
    (hpos : ∀ u : F, 0 ≤ (inner ℂ u (A u) : ℂ).re) (b : HilbertBasis ℕ ℂ F) :
    Tendsto (fun m : ℕ => ritzInf (finiteModeRestrict A b) (galerkinSpan b (m + 1))) atTop
      (nhds (sInf (spectrum ℝ A))) := by
  have hq : ∀ x : finiteModeDomain b, 0 ≤ quadForm (finiteModeRestrict A b) x :=
    fun x => hpos _
  have hlim := ritzInf_tendsto_domainInf b (finiteModeRestrict A b) hq
  rw [sInf_spectrum_eq_rayleighInf A hsa, ← ritzInf_finiteModeDomain_eq_rayleighInf A b]
  exact hlim

/-- **The limit is the bottom of the spectrum of the *selected* extension.**  The
Galerkin/Hashimoto algorithm applied to the matrix `⟨bᵢ | A | bⱼ⟩` of a bounded
positive self-adjoint operator selects `A` itself (that is
`BookProof.HermiteGalerkin.finiteModeRestrict_selects_operator`), and the Ritz
values it produces converge to the bottom of the spectrum of that selected
extension. -/
theorem galerkin_ritz_tendsto_sInf_spectrum_of_selected [Nontrivial F] (A : F →L[ℂ] F)
    (hsa : IsSelfAdjoint A) (hpos : ∀ u : F, 0 ≤ (inner ℂ u (A u) : ℂ).re)
    (b : HilbertBasis ℕ ℂ F) :
    IsPositiveSelfAdjointExtension (finiteModeRestrict A b) (topRestrict A) ∧
      Tendsto (fun m : ℕ => ritzInf (finiteModeRestrict A b) (galerkinSpan b (m + 1))) atTop
        (nhds (sInf (spectrum ℝ A))) :=
  ⟨(finiteModeRestrict_selects_operator A hsa hpos b).1,
    ritzInf_tendsto_sInf_spectrum A hsa hpos b⟩

end BookProof.ChapterSirkRitzSpectrum

import Mathlib
import BookProof.ChapterH9
import BookProof.ChapterSirkEndToEnd
import BookProof.ChapterHashimotoShiftInvert
import BookProof.ChapterHashimotoComplexShifts

/-!
# Chapter SirkSpectralGeometry — the Crouzeix domain of the shift-invert operator

`CONSOLIDATED_PLAN.md` §12.2 **Gap 2** asks for the finite-`m` quantitative
constants of the SIRK bound *per system*, "from the actual spectral geometry".
`ChapterSirkEndToEnd` closed the assembly (Gap 1) with abstract `C`, `Dmin`, `h`
and showed (`crouzeix_domain_transfer`) that a *single* convex set `Σ ⊇ W(X)`
serves both Crouzeix bounds.  What was still missing is the identification of
that `Σ` from the operator the algorithm actually iterates — the **shift-invert**
`X = (A − γ)⁻¹`.  This chapter supplies it, generically, in the two regimes the
project uses:

* **the positive/Friedrichs regime** (real shift `γ > 0`): the shift-invert `R`
  of a positive symmetric operator is self-adjoint and positive with
  `‖R‖ ≤ γ⁻¹`, hence its numerical range is contained in the **real segment**
  `[0, γ⁻¹]` — `numRange_subset_realSegment_of_shiftInvert`.  A segment is a
  degenerate (one-dimensional) convex set: this is the best possible Crouzeix
  domain, and it is inherited by every Krylov compression
  (`crouzeix_domain_shiftInvert`).
* **the indefinite regime** (non-real shift `γ`, `Im γ ≠ 0`, no positivity):
  `‖X‖ ≤ |Im γ|⁻¹` gives the **closed disc** of radius `|Im γ|⁻¹` around the
  origin — `numRange_subset_closedBall_of_shiftInvertC` and
  `crouzeix_domain_shiftInvertC`.

The last theorem, `sirk_end_to_end_crouzeix_domain`, is the form of the
end-to-end bound in which the *domain* is the hypothesis: one convex `Σ`
containing `W(X)` is enough — the compression side is discharged by
`ChapterH9.numRange_compress_subset`.  Its two shift-invert instances
`sirk_end_to_end_shiftInvert` and `sirk_end_to_end_shiftInvertC` are the
system-independent statements that `ChapterSirkPerSystem` instantiates for
QYM, NS (Eulerian and Lagrangian) and QG.

## Honest boundary

Crouzeix's inequality itself is still a named hypothesis, exactly as in
`ChapterH4`: what is proved here is that *one explicit convex set* — determined
by the shift alone — can be used for it, uniformly in the reduction order `m`.
Nothing is claimed about floating-point arithmetic (§12.2 Gap 6).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkSpectralGeometry

open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.HashimotoShiftInvert BookProof.FarisLavine

/-! ## 1. The real segment as a Crouzeix domain -/

/-- The segment `[a, b]` of the real axis, viewed inside `ℂ`. -/
def realSegment (a b : ℝ) : Set ℂ := {z : ℂ | z.im = 0 ∧ a ≤ z.re ∧ z.re ≤ b}

theorem convex_realSegment (a b : ℝ) : Convex ℝ (realSegment a b) := by
  rintro x ⟨hxi, hxl, hxu⟩ y ⟨hyi, hyl, hyu⟩ s t hs ht hst
  have him : (s • x + t • y : ℂ).im = 0 := by
    simp [Complex.real_smul, hxi, hyi]
  have hre : (s • x + t • y : ℂ).re = s * x.re + t * y.re := by
    simp [Complex.real_smul, Complex.mul_re, hxi, hyi]
  have hsa : s * a + t * a = a := by rw [← add_mul, hst, one_mul]
  have hsb : s * b + t * b = b := by rw [← add_mul, hst, one_mul]
  refine ⟨him, ?_, ?_⟩ <;> rw [hre]
  · linarith [mul_le_mul_of_nonneg_left hxl hs, mul_le_mul_of_nonneg_left hyl ht]
  · linarith [mul_le_mul_of_nonneg_left hxu hs, mul_le_mul_of_nonneg_left hyu ht]

theorem realSegment_subset_closedBall {a b : ℝ} (ha : 0 ≤ a) :
    realSegment a b ⊆ Metric.closedBall (0 : ℂ) b := by
  rintro z ⟨hzi, hzl, hzu⟩
  have hz : z = ((z.re : ℝ) : ℂ) := by apply Complex.ext <;> simp [hzi]
  simp only [Metric.mem_closedBall, dist_zero_right]
  rw [hz]
  simp only [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (le_trans ha hzl)]
  exact hzu

/-! ## 2. The positive (Friedrichs) regime: the numerical range is a segment -/

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

/-- **The Crouzeix domain of the shift-invert of a positive operator.**  If `A` is
positive and symmetric on its domain and `R = (A + γ)⁻¹` is its shift-invert at a
positive shift, then every Rayleigh quotient of `R` is a *real* number in
`[0, γ⁻¹]`: the numerical range degenerates to a segment. -/
theorem numRange_subset_realSegment_of_shiftInvert {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) :
    numRange R ⊆ realSegment 0 γ⁻¹ := by
  rintro c ⟨x, hx, rfl⟩
  have hsa : IsSelfAdjoint R := hR.isSelfAdjoint hsym
  have hsymm : ∀ u v : F, (inner ℂ (R u) v : ℂ) = inner ℂ u (R v) :=
    ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hsa
  refine ⟨?_, ?_, ?_⟩
  · have h1 : (starRingEnd ℂ) (inner ℂ x (R x) : ℂ) = (inner ℂ x (R x) : ℂ) := by
      rw [inner_conj_symm, hsymm x x]
    have := Complex.conj_eq_iff_im.mp h1
    simpa using this
  · simpa using hR.inner_nonneg hpos hγ x
  · have hR' : ‖R x‖ ≤ γ⁻¹ * ‖x‖ := hR.norm_apply_le hpos hγ x
    calc (inner ℂ x (R x) : ℂ).re
        ≤ ‖(inner ℂ x (R x) : ℂ)‖ := Complex.re_le_norm _
      _ ≤ ‖x‖ * ‖R x‖ := norm_inner_le_norm _ _
      _ ≤ γ⁻¹ := by rw [hx, one_mul]; simpa [hx] using hR'

/-- **The Crouzeix domain is inherited by every Krylov compression** (positive
regime): the reduced generator `B = V∗RV` of any isometric reduction has its
numerical range — and even its convex hull — inside the *same* segment
`[0, γ⁻¹]`, uniformly in the reduction order. -/
theorem crouzeix_domain_shiftInvert {G : Type*} [NormedAddCommGroup G]
    [InnerProductSpace ℂ G] [CompleteSpace G] {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ)
    (V : G →L[ℂ] F) (hViso : ∀ x : G, ‖V x‖ = ‖x‖) :
    convexHull ℝ (numRange (compress V R)) ⊆ realSegment 0 γ⁻¹ :=
  crouzeix_domain_transfer V R hViso _ (convex_realSegment 0 γ⁻¹)
    (numRange_subset_realSegment_of_shiftInvert hR hsym hpos hγ)

/-! ## 3. The indefinite regime: the numerical range is a disc -/

omit [CompleteSpace F] in
/-- **The Crouzeix domain of the shift-invert at a non-real shift.**  With no
positivity at all, `‖(A − γ)⁻¹‖ ≤ |Im γ|⁻¹`, so the numerical range sits in the
closed disc of that radius. -/
theorem numRange_subset_closedBall_of_shiftInvertC {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0) :
    numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ :=
  (numRange_subset_closedBall X).trans
    (Metric.closedBall_subset_closedBall (hX.opNorm_le hsym hγ))

/-- **The disc is inherited by every Krylov compression** (indefinite regime). -/
theorem crouzeix_domain_shiftInvertC {G : Type*} [NormedAddCommGroup G]
    [InnerProductSpace ℂ G] [CompleteSpace G] {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0)
    (V : G →L[ℂ] F) (hViso : ∀ x : G, ‖V x‖ = ‖x‖) :
    convexHull ℝ (numRange (compress V X)) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ :=
  crouzeix_domain_transfer V X hViso _ (convex_closedBall _ _)
    (numRange_subset_closedBall_of_shiftInvertC hX hsym hγ)

/-! ## 4. The end-to-end bound with the Crouzeix domain as the hypothesis -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  {G : Type*} [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

/-- **The end-to-end SIRK bound, domain form.**  Compared with
`ChapterSirkEndToEnd.sirk_end_to_end` the two Crouzeix bounds are no longer
assumed outright: they are assumed *conditionally on the numerical range lying in
a single convex set `Σ`*, and the compression side of that condition is
discharged here (`ChapterH9.numRange_compress_subset`).  This is what makes the
constants `C` and `Dmin` computable from `Σ` alone — that is, from the spectral
geometry of the generator rather than from the reduction. -/
theorem sirk_end_to_end_crouzeix_domain
    (V : G →L[ℂ] E) (X qX qXinv : E →L[ℂ] E) (qBinv : G →L[ℂ] G) (p : Polynomial ℂ)
    (flow psiX : E →L[ℂ] E) (psiB : G →L[ℂ] G)
    (C Dmin h : ℝ) (m : ℕ) (S : Set ℂ)
    (hS : numRange X ⊆ S)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ G)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : E, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : G, ∃ y : G, X (V x) = V y)
    (hinvq : ∀ x : G, ∃ y : G, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ G)
    (hflow : flow = psiX)
    (hcxX : numRange X ⊆ S →
      ‖psiX - (Polynomial.aeval X p).comp qXinv‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcxB : numRange (compress V X) ⊆ S →
      ‖psiB - (Polynomial.aeval (compress V X) p).comp qBinv‖
        ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : E) (hv : V (V.adjoint v) = v) :
    ‖flow v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  have hSB : numRange (compress V X) ⊆ S :=
    ((numRange_compress_subset V X hViso).trans hS)
  exact sirk_end_to_end V X qX qXinv qBinv p flow psiX psiB C Dmin h m hVV hViso hVadj
    hinvX hinvq hqXl hqBr hflow (hcxX hS) (hcxB hSB) v hv

/-- The convexity hypothesis of `sirk_end_to_end_crouzeix_domain` is not needed
for the bound itself; it is what makes `Σ` a legitimate Crouzeix domain — the
convex hull of the numerical range of *every* compression stays inside it. -/
theorem crouzeix_domain_convexHull (V : G →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖) (S : Set ℂ) (hconv : Convex ℝ S) (hS : numRange X ⊆ S) :
    convexHull ℝ (numRange (compress V X)) ⊆ S :=
  crouzeix_domain_transfer V X hViso S hconv hS

/-! ## 5. The two shift-invert instances -/

/-- **The SIRK end-to-end bound for the shift-invert of a positive operator**
(the Friedrichs/real-shift route, used by QYM).  The Crouzeix constants are those
of the segment `[0, γ⁻¹]`, which depends only on the shift. -/
theorem sirk_end_to_end_shiftInvert
    {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ)
    (V : G →L[ℂ] F) (qX qXinv : F →L[ℂ] F) (qBinv : G →L[ℂ] G) (p : Polynomial ℂ)
    (flow psiX : F →L[ℂ] F) (psiB : G →L[ℂ] G) (C Dmin h : ℝ) (m : ℕ)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ G)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : F, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : G, ∃ y : G, R (V x) = V y)
    (hinvq : ∀ x : G, ∃ y : G, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ F)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ G)
    (hflow : flow = psiX)
    (hcxX : numRange R ⊆ realSegment 0 γ⁻¹ →
      ‖psiX - (Polynomial.aeval R p).comp qXinv‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcxB : numRange (compress V R) ⊆ realSegment 0 γ⁻¹ →
      ‖psiB - (Polynomial.aeval (compress V R) p).comp qBinv‖
        ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : F) (hv : V (V.adjoint v) = v) :
    ‖flow v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m :=
  sirk_end_to_end_crouzeix_domain V R qX qXinv qBinv p flow psiX psiB C Dmin h m
    (realSegment 0 γ⁻¹)
    (numRange_subset_realSegment_of_shiftInvert hR hsym hpos hγ)
    hVV hViso hVadj hinvX hinvq hqXl hqBr hflow hcxX hcxB v hv

/-- **The SIRK end-to-end bound at a non-real shift** (the indefinite route, used
by NS Eulerian, NS Lagrangian and QG).  The Crouzeix domain is the disc of radius
`|Im γ|⁻¹`, again depending only on the shift. -/
theorem sirk_end_to_end_shiftInvertC
    {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0)
    (V : G →L[ℂ] F) (qX qXinv : F →L[ℂ] F) (qBinv : G →L[ℂ] G) (p : Polynomial ℂ)
    (flow psiX : F →L[ℂ] F) (psiB : G →L[ℂ] G) (C Dmin h : ℝ) (m : ℕ)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ G)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖)
    (hVadj : ∀ v : F, ‖V.adjoint v‖ ≤ ‖v‖)
    (hinvX : ∀ x : G, ∃ y : G, X (V x) = V y)
    (hinvq : ∀ x : G, ∃ y : G, qX (V x) = V y)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ F)
    (hqBr : (compress V qX).comp qBinv = ContinuousLinearMap.id ℂ G)
    (hflow : flow = psiX)
    (hcxX : numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ →
      ‖psiX - (Polynomial.aeval X p).comp qXinv‖ ≤ C * (Real.exp (-(h * m)) * Dmin))
    (hcxB : numRange (compress V X) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ →
      ‖psiB - (Polynomial.aeval (compress V X) p).comp qBinv‖
        ≤ C * (Real.exp (-(h * m)) * Dmin))
    (v : F) (hv : V (V.adjoint v) = v) :
    ‖flow v - sirkApprox V psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m :=
  sirk_end_to_end_crouzeix_domain V X qX qXinv qBinv p flow psiX psiB C Dmin h m
    (Metric.closedBall (0 : ℂ) |γ.im|⁻¹)
    (numRange_subset_closedBall_of_shiftInvertC hX hsym hγ)
    hVV hViso hVadj hinvX hinvq hqXl hqBr hflow hcxX hcxB v hv

end BookProof.ChapterSirkSpectralGeometry

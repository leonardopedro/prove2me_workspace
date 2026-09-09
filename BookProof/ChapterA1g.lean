import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA1
import BookProof.ChapterA1c
import BookProof.ChapterA1d
import BookProof.ChapterA1e
import BookProof.ChapterA1f
import BookProof.ChapterA2b
import BookProof.ChapterA2c

/-!
# Chapter A, §A.1 — the converse realification dichotomy (work-package N1 residue)

This file discharges the remaining N1 residue of `FORMALIZATION_ROADMAP.md`
(§A.1, Prop 12 R-pseudoreal / R-complex cases): the **converse** of
`realification_reducible_of_conjugation` (`BookProof/ChapterA1f.lean`).

> **`realification_irreducible_of_not_isCReal`.**  A *normal*, complex-irreducible
> Schur system `(M, V)` that is **not** C-real has an **irreducible**
> realification `(M, V^r)`.

Together with `isCReal_realification_reducible` (C-real ⇒ realification reducible)
this gives the full Def-10 dichotomy `realification_irreducible ↔ ¬ IsCReal`
for a normal complex-irreducible Schur system (`realification_irreducible_iff`).

## The Frobenius–Schur construction

The recorded crux is the orthogonality obstruction: from a proper real
subsystem `Y` one must build a commuting anti-unitary.  We do this via the
**linear/antilinear decomposition** of `ChapterA2c.lean`.

Assume the realification is reducible, with `Y` a proper non-trivial real
subsystem.  Let `E := Y.starProjection` be the real orthogonal projection onto
`Y`.  Then `E` is self-adjoint and (using normality, so that `Yᗮ` is also a
subsystem) commutes with `M` (`RealCommutes M E`).  Its **`ℂ`-antilinear part**
`Q := Qanti E = (E + i·E·i)/2` is again self-adjoint, commutes with `M`, and is
`ℂ`-antilinear.  Its square `Q²` is `ℂ`-linear, self-adjoint, and commutes with
`M`, so by the Schur hypothesis `Q² = r·1` for a real `r ≥ 0`.

* If `r > 0`, then `θ := r^{-1/2}·Q` is an anti-unitary involution commuting
  with `M` — a **C-conjugation** — so `M` is C-real, contradicting the
  hypothesis.
* If `r = 0`, then `Q = 0` (self-adjoint with `Q² = 0`), so `E` is `ℂ`-linear,
  whence `Y` is a *complex* subspace — a proper non-trivial complex subsystem,
  contradicting complex irreducibility of `M`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).  The Schur input is the named hypothesis
`IsSchurFull` (never an `axiom`), matching the design of §A.2.
-/

open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

namespace BookProof.ChapterA

attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-! ## Self-adjointness bookkeeping for `mulI` and `Qanti` -/

/-- `mulI` (multiplication by `i`) is **skew-adjoint** on the realification:
its real adjoint is `-mulI`. -/
lemma mulI_adjoint : ContinuousLinearMap.adjoint (mulI : V →L[ℝ] V) = -mulI := by
  refine ContinuousLinearMap.ext fun x => ?_
  refine ext_inner_right ℝ fun y => ?_
  rw [ContinuousLinearMap.adjoint_inner_left]
  simp only [ContinuousLinearMap.neg_apply, mulI_apply, inner_neg_left]
  rw [real_inner_eq_re_inner (𝕜 := ℂ), real_inner_eq_re_inner (𝕜 := ℂ)]
  rw [inner_smul_left, inner_smul_right]
  simp [Complex.mul_re]

/-- `star (mulI) = -mulI` (the `star` form of `mulI_adjoint`). -/
lemma star_mulI : star (mulI : V →L[ℝ] V) = -mulI := mulI_adjoint

/-- The `ℂ`-antilinear part `Qanti E` of a self-adjoint operator is self-adjoint. -/
lemma Qanti_selfAdjoint (E : V →L[ℝ] V) (hE : IsSelfAdjoint E) :
    IsSelfAdjoint (Qanti E) := by
  have hEs : star E = E := hE
  change star (Qanti E) = Qanti E
  rw [Qanti, star_smul, star_add, star_mul, star_mul, star_mulI, hEs]
  simp only [star_trivial]
  congr 1
  noncomm_ring

omit [CompleteSpace V] in
/-- A real-linear operator that anticommutes with `mulI` is `ℂ`-antilinear:
`T (c • x) = conj c • T x`. -/
lemma anti_conj_smul (T : V →L[ℝ] V)
    (hT : ∀ x, T (Complex.I • x) = -(Complex.I • T x)) (c : ℂ) (x : V) :
    T (c • x) = (starRingEnd ℂ) c • T x := by
  have hre : ∀ (r : ℝ) (y : V), T ((r : ℂ) • y) = (r : ℂ) • T y := by
    intro r y
    have := T.map_smul r y
    simp only [Complex.coe_smul]; exact this
  have hc : (starRingEnd ℂ) c = (c.re : ℂ) - (c.im : ℂ) * Complex.I := by
    apply Complex.ext <;> simp
  calc T (c • x) = T (((c.re : ℂ) + (c.im : ℂ) * Complex.I) • x) := by rw [Complex.re_add_im]
    _ = (c.re : ℂ) • T x - (c.im : ℂ) • (Complex.I • T x) := by
        rw [add_smul, mul_smul, map_add, hre, hre, hT]; module
    _ = (starRingEnd ℂ) c • T x := by rw [hc, sub_smul, mul_smul]

omit [CompleteSpace V] in
/-- `Qanti E` is `ℂ`-antilinear (anticommutes with `mulI`) — a restatement of
`Qanti_anticommutes_mulI` in the `conj`-smul form. -/
lemma Qanti_conj_smul (E : V →L[ℝ] V) (c : ℂ) (x : V) :
    Qanti E (c • x) = (starRingEnd ℂ) c • Qanti E x :=
  anti_conj_smul (Qanti E) (Qanti_anticommutes_mulI E) c x

omit [CompleteSpace V] in
/-- `Q²` is `ℂ`-linear when `Q` anticommutes with `mulI`. -/
lemma Qanti_sq_commutes_mulI (E : V →L[ℝ] V) (x : V) :
    (Qanti E) ((Qanti E) (Complex.I • x))
      = Complex.I • ((Qanti E) ((Qanti E) x)) := by
  rw [Qanti_anticommutes_mulI, map_neg, Qanti_anticommutes_mulI, neg_neg]

/-! ## The orthogonal projection onto a subsystem commutes with a normal system -/

/-- The real adjoint of a realified operator is the realification of the complex
adjoint. -/
lemma adjoint_rxMap (m : V →L[ℂ] V) :
    ContinuousLinearMap.adjoint (rxMap m) = rxMap (ContinuousLinearMap.adjoint m) := by
  refine ContinuousLinearMap.ext fun x => ?_
  refine ext_inner_right ℝ fun y => ?_
  rw [ContinuousLinearMap.adjoint_inner_left]
  simp only [rxMap_apply]
  rw [real_inner_eq_re_inner (𝕜 := ℂ), real_inner_eq_re_inner (𝕜 := ℂ),
    ContinuousLinearMap.adjoint_inner_left]

/-- The realification of a **normal** complex system is normal. -/
lemma rxSystem_isNormal (M : System ℂ V) (hM : M.IsNormal) : (rxSystem M).IsNormal := by
  rintro _ ⟨m, hm, rfl⟩
  exact ⟨ContinuousLinearMap.adjoint m, hM m hm, (adjoint_rxMap m).symm⟩

/-- For a **normal** system `M`, the real orthogonal projection onto a subsystem
`Y` of the realification commutes with `M`. -/
lemma starProjection_realCommutes (M : System ℂ V) (hM : M.IsNormal)
    {Y : Submodule ℝ V} (hY : (rxSystem M).IsSubsystem Y) :
    haveI : CompleteSpace Y := hY.1.completeSpace_coe
    RealCommutes M (Y.starProjection) := by
  haveI : CompleteSpace Y := hY.1.completeSpace_coe
  have hYperp : (rxSystem M).IsSubsystem Yᗮ :=
    System.orthogonal_isSubsystem (rxSystem M) (rxSystem_isNormal M hM) hY
  intro m hm x
  set P := Y.starProjection with hP
  have hmemY : m (P x) ∈ Y := by
    have := hY.2 (rxMap m) ⟨m, hm, rfl⟩ (P x) (Submodule.starProjection_apply_mem Y x)
    simpa [rxMap_apply] using this
  have hmemYperp : m (x - P x) ∈ Yᗮ := by
    have hsub := Submodule.sub_starProjection_mem_orthogonal (K := Y) x
    have := hYperp.2 (rxMap m) ⟨m, hm, rfl⟩ (x - P x) hsub
    simpa [rxMap_apply] using this
  have hdecomp : m x = m (P x) + m (x - P x) := by rw [← map_add, add_sub_cancel]
  have hPx : P (m x) = P (m (P x)) + P (m (x - P x)) := by rw [hdecomp, map_add]
  rw [hPx, Submodule.starProjection_eq_self_iff.mpr hmemY,
    (Submodule.starProjection_apply_eq_zero_iff Y).mpr hmemYperp, add_zero]

/-! ## Real-inner-product identities for complex scalars -/

omit [CompleteSpace V] in
/-- `⟪w, i·w⟫_ℝ = 0` (the real part of `i‖w‖²`). -/
lemma real_inner_I_smul_self (w : V) : (inner ℝ w (Complex.I • w) : ℝ) = 0 := by
  have h1 : ((‖w‖:ℂ)^2).re = ‖w‖^2 := by norm_cast
  have h2 : ((‖w‖:ℂ)^2).im = 0 := by norm_cast
  rw [real_inner_eq_re_inner (𝕜 := ℂ), inner_smul_right, inner_self_eq_norm_sq_to_K]
  simp [h1, h2]

omit [CompleteSpace V] in
/-- `⟪c·x, i·x⟫_ℝ = ‖x‖²·c.im`. -/
lemma real_inner_smul_I (c : ℂ) (x : V) :
    (inner ℝ (c • x) (Complex.I • x) : ℝ) = ‖x‖^2 * c.im := by
  have h1 : ((‖x‖:ℂ)^2).re = ‖x‖^2 := by norm_cast
  have h2 : ((‖x‖:ℂ)^2).im = 0 := by norm_cast
  rw [real_inner_eq_re_inner (𝕜 := ℂ), inner_smul_left, inner_smul_right,
    inner_self_eq_norm_sq_to_K]
  simp [h1, h2]; ring

omit [CompleteSpace V] in
/-- `⟪c·x, x⟫_ℝ = ‖x‖²·c.re`. -/
lemma real_inner_smul_self (c : ℂ) (x : V) :
    (inner ℝ (c • x) x : ℝ) = ‖x‖^2 * c.re := by
  have h1 : ((‖x‖:ℂ)^2).re = ‖x‖^2 := by norm_cast
  have h2 : ((‖x‖:ℂ)^2).im = 0 := by norm_cast
  rw [real_inner_eq_re_inner (𝕜 := ℂ), inner_smul_left, inner_self_eq_norm_sq_to_K]
  simp [h1, h2]; ring

/-! ## Schur scalar extraction for `Q²` -/

/-- **Schur scalar extraction.**  For a self-adjoint operator `E` in the real
commutant of a Schur system, the square of its `ℂ`-antilinear part is a
non-negative real scalar: `Qanti E (Qanti E x) = r • x` with `0 ≤ r`. -/
lemma Qanti_sq_scalar [Nontrivial V] (M : System ℂ V) (hSchur : IsSchurFull M)
    {E : V →L[ℝ] V} (hEsa : IsSelfAdjoint E) (hEc : RealCommutes M E) :
    ∃ r : ℝ, 0 ≤ r ∧ ∀ x, Qanti E (Qanti E x) = (r : ℝ) • x := by
  set Q := Qanti E with hQdef
  have hQsa : IsSelfAdjoint Q := Qanti_selfAdjoint E hEsa
  have hQadj : ContinuousLinearMap.adjoint Q = Q := hQsa
  have hanti : ∀ x, Q (Complex.I • x) = -(Complex.I • Q x) := Qanti_anticommutes_mulI E
  have hcomm : ∀ x, (Q * Q) (Complex.I • x) = Complex.I • ((Q * Q) x) := by
    intro x
    simp only [ContinuousLinearMap.mul_apply]
    exact Qanti_sq_commutes_mulI E x
  have hQQc : RealCommutes M (Q * Q) :=
    realCommutes_mul (Qanti_realCommutes hEc) (Qanti_realCommutes hEc)
  obtain ⟨c, hc⟩ := hSchur (cplxify (Q * Q) hcomm) (cplxify_commutes hcomm hQQc)
  have hRx : ∀ x, Q (Q x) = c • x := by
    intro x
    have := congr_arg (fun T => T x) hc
    simpa only [cplxify_apply, ContinuousLinearMap.mul_apply, ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.one_apply] using this
  have hsaI : ∀ a y : V, (inner ℝ (Q a) y : ℝ) = inner ℝ a (Q y) := by
    intro a y
    conv_lhs => rw [← hQadj]
    exact ContinuousLinearMap.adjoint_inner_left Q y a
  obtain ⟨x0, hx0⟩ := exists_ne (0 : V)
  have hnorm0 : (0:ℝ) < ‖x0‖^2 := by positivity
  have him : c.im = 0 := by
    have e1 : (inner ℝ (Q (Q x0)) (Complex.I • x0) : ℝ) = 0 := by
      rw [hsaI, hanti, inner_neg_right, real_inner_I_smul_self]; ring
    have e2 : (inner ℝ (Q (Q x0)) (Complex.I • x0) : ℝ) = ‖x0‖^2 * c.im := by
      rw [hRx, real_inner_smul_I]
    rw [e2] at e1
    rcases mul_eq_zero.mp e1 with h | h
    · exact absurd h (by positivity)
    · exact h
  have hre : 0 ≤ c.re := by
    have e1 : (inner ℝ (Q (Q x0)) x0 : ℝ) = ‖Q x0‖^2 := by
      rw [hsaI, real_inner_self_eq_norm_sq]
    have e2 : (inner ℝ (Q (Q x0)) x0 : ℝ) = ‖x0‖^2 * c.re := by
      rw [hRx, real_inner_smul_self]
    rw [e2] at e1
    have hpos : 0 ≤ ‖x0‖^2 * c.re := e1 ▸ (by positivity)
    exact (mul_nonneg_iff_of_pos_left hnorm0).mp hpos
  have hcr : c = (c.re : ℂ) := by apply Complex.ext <;> simp [him]
  refine ⟨c.re, hre, fun x => ?_⟩
  have hcx : c • x = (c.re : ℝ) • x := by
    conv_lhs => rw [hcr]
    rw [Complex.coe_smul]
  rw [hRx, hcx]

/-
A self-adjoint operator with vanishing square is zero.
-/
lemma selfAdjoint_sq_eq_zero {Q : V →L[ℝ] V} (hQ : IsSelfAdjoint Q)
    (hsq : ∀ x, Q (Q x) = 0) : ∀ x, Q x = 0 := by
  have hQadj : ContinuousLinearMap.adjoint Q = Q := hQ
  intro x
  have h : (inner ℝ (Q x) (Q x) : ℝ) = inner ℝ x (Q (Q x)) := by
    rw [← ContinuousLinearMap.adjoint_inner_left Q (Q x) x, hQadj]
  rw [hsq, inner_zero_right] at h
  exact inner_self_eq_zero.mp h

/-! ## The C-conjugation from the positive case -/

/-- **The C-conjugation from the positive Schur scalar.**  A `ℂ`-antilinear,
self-adjoint operator `Q` in the real commutant of `M` with `Q² = r·1`, `r > 0`,
gives a C-conjugation `θ := r^{-1/2}·Q`; hence `M` is C-real. -/
lemma isCReal_of_antilinear_sq_pos [Nontrivial V] (M : System ℂ V) {Q : V →L[ℝ] V}
    (hanti : ∀ x, Q (Complex.I • x) = -(Complex.I • Q x)) (hsa : IsSelfAdjoint Q)
    (hcomm : RealCommutes M Q) {r : ℝ} (hr : 0 < r)
    (hsq : ∀ x, Q (Q x) = (r : ℝ) • x) : IsCReal M := by
  set s := Real.sqrt r with hsdef
  have hs_pos : 0 < s := Real.sqrt_pos.mpr hr
  have hs_ne : s ≠ 0 := ne_of_gt hs_pos
  have hs_sq : s * s = r := by rw [hsdef]; exact Real.mul_self_sqrt hr.le
  have hQadj : ContinuousLinearMap.adjoint Q = Q := hsa
  have hinv : ∀ x, s⁻¹ • Q (s⁻¹ • Q x) = x := by
    intro x
    rw [map_smul, hsq, smul_smul, smul_smul]
    rw [show s⁻¹ * s⁻¹ * r = 1 by field_simp [hs_ne]; rw [← hs_sq]; ring]
    simp
  have hsaId : ∀ a y : V, (inner ℝ (Q a) y : ℝ) = inner ℝ a (Q y) := by
    intro a y
    conv_lhs => rw [← hQadj]
    exact ContinuousLinearMap.adjoint_inner_left Q y a
  let L : V ≃ₛₗ[starRingEnd ℂ] V :=
    { toFun := fun x => s⁻¹ • Q x
      map_add' := by intro x y; simp [smul_add]
      map_smul' := by
        intro c x
        change s⁻¹ • Q (c • x) = (starRingEnd ℂ) c • (s⁻¹ • Q x)
        rw [anti_conj_smul Q hanti c x, smul_comm]
      invFun := fun x => s⁻¹ • Q x
      left_inv := hinv
      right_inv := hinv }
  have hnorm : ∀ x, ‖L x‖ = ‖x‖ := by
    intro x
    have hQx : ‖Q x‖^2 = r * ‖x‖^2 := by
      have key : (inner ℝ (Q x) (Q x) : ℝ) = inner ℝ x (Q (Q x)) := hsaId x (Q x)
      rw [← real_inner_self_eq_norm_sq, key, hsq, real_inner_smul_right,
        real_inner_self_eq_norm_sq]
    have hLx : ‖L x‖^2 = ‖x‖^2 := by
      change ‖s⁻¹ • Q x‖^2 = ‖x‖^2
      rw [norm_smul, mul_pow, hQx, Real.norm_eq_abs, sq_abs, ← hs_sq]
      field_simp
    have := congr_arg Real.sqrt hLx
    rwa [Real.sqrt_sq (norm_nonneg _), Real.sqrt_sq (norm_nonneg _)] at this
  let θ₀ : AntiUnitary V := { L with norm_map' := hnorm }
  refine ⟨θ₀, ?_, ?_⟩
  · intro x
    change s⁻¹ • Q (s⁻¹ • Q x) = x
    exact hinv x
  · intro m hm x
    change s⁻¹ • Q (m x) = m (s⁻¹ • Q x)
    rw [hcomm m hm x, ContinuousLinearMap.map_smul_of_tower]

/-! ## The `ℂ`-linearity in the vanishing case -/

omit [CompleteSpace V] in
/-
If the `ℂ`-antilinear part of `E` vanishes, `E` is `ℂ`-linear.
-/
lemma clinear_of_Qanti_eq_zero {E : V →L[ℝ] V} (hQ : ∀ x, Qanti E x = 0) (x : V) :
    E (Complex.I • x) = Complex.I • E x := by
  have hE_plin : E = Plin E := by
    convert Plin_add_Qanti E |> Eq.symm using 1;
    exact Eq.symm ( add_eq_left.mpr ( ContinuousLinearMap.ext hQ ) )
  rw [hE_plin]
  apply Plin_commutes_mulI E x

/-! ## Headline: the converse dichotomy -/

/-- **`realification_irreducible_of_not_isCReal` (§A.1, Prop 12 residue).**  A
normal, complex-irreducible Schur system `(M, V)` that is **not** C-real has an
irreducible realification `(M, V^r)`. -/
theorem realification_irreducible_of_not_isCReal [Nontrivial V] (M : System ℂ V)
    (hM : M.IsNormal) (hirr : M.IsIrreducible) (hSchur : IsSchurFull M)
    (hnc : ¬ IsCReal M) : (rxSystem M).IsIrreducible := by
  by_contra hcon
  rw [System.IsIrreducible] at hcon
  push_neg at hcon
  obtain ⟨Y, hYsub, hYbot, hYtop⟩ := hcon
  haveI : CompleteSpace Y := hYsub.1.completeSpace_coe
  set E := Y.starProjection with hE
  have hEsa : IsSelfAdjoint E := isSelfAdjoint_starProjection Y
  have hEc : RealCommutes M E := starProjection_realCommutes M hM hYsub
  obtain ⟨r, hr0, hsq⟩ := Qanti_sq_scalar M hSchur hEsa hEc
  rcases eq_or_lt_of_le hr0 with hr | hr
  · have hQ0 : ∀ x, Qanti E x = 0 := by
      have hsq0 : ∀ x, Qanti E (Qanti E x) = 0 := by
        intro x; rw [hsq x, ← hr]; simp
      exact selfAdjoint_sq_eq_zero (Qanti_selfAdjoint E hEsa) hsq0
    have hEcl : ∀ x, E (Complex.I • x) = Complex.I • E x := clinear_of_Qanti_eq_zero hQ0
    have hYcl : ∀ y ∈ Y, (Complex.I : ℂ) • y ∈ Y := by
      intro y hy
      have hEy : E y = y := Submodule.starProjection_eq_self_iff.mpr hy
      have heq : E (Complex.I • y) = Complex.I • y := by rw [hEcl, hEy]
      have hmem : E (Complex.I • y) ∈ Y := Submodule.starProjection_apply_mem Y _
      rwa [heq] at hmem
    have hcsub : M.IsSubsystem (cplxSub Y hYcl) := cplxSub_isSubsystem M hYcl hYsub
    rcases hirr _ hcsub with h | h
    · apply hYbot
      have := congrArg realSub h
      rwa [realSub_cplxSub, realSub_bot] at this
    · apply hYtop
      have := congrArg realSub h
      rwa [realSub_cplxSub, realSub_top] at this
  · exact hnc (isCReal_of_antilinear_sq_pos M (Qanti_anticommutes_mulI E)
      (Qanti_selfAdjoint E hEsa) (Qanti_realCommutes hEc) hr hsq)

/-- **The Def-10 realification dichotomy.**  For a normal, complex-irreducible
Schur system, the realification is irreducible iff the system is not C-real. -/
theorem realification_irreducible_iff [Nontrivial V] (M : System ℂ V)
    (hM : M.IsNormal) (hirr : M.IsIrreducible) (hSchur : IsSchurFull M) :
    (rxSystem M).IsIrreducible ↔ ¬ IsCReal M := by
  constructor
  · exact fun h => not_isCReal_of_realification_irreducible M h
  · exact fun h => realification_irreducible_of_not_isCReal M hM hirr hSchur h

/-- **Realification classification (Prop 11, complex side).**  A normal,
complex-irreducible Schur system falls into exactly one of the three C-types,
with the R-type behaviour of its realification determined accordingly:

* **C-real** ⇒ the realification is **reducible** (the R-real case);
* **C-pseudoreal** ⇒ the realification is **irreducible** (the R-pseudoreal case);
* **C-complex** ⇒ the realification is **irreducible** (the R-complex case).

This is the complex-side statement of Prop 11's trichotomy: it combines
`cType_exhaustive` with the realification dichotomy
`realification_irreducible_iff`. -/
theorem realification_classification [Nontrivial V] (M : System ℂ V)
    (hM : M.IsNormal) (hirr : M.IsIrreducible) (hSchur : IsSchurFull M) :
    (IsCReal M ∧ ¬ (rxSystem M).IsIrreducible)
    ∨ (IsCPseudoreal M ∧ (rxSystem M).IsIrreducible)
    ∨ (IsCComplex M ∧ (rxSystem M).IsIrreducible) := by
  rcases cType_exhaustive M with h | h | h
  · exact Or.inl ⟨h, fun hcon => (not_isCReal_of_realification_irreducible M hcon) h⟩
  · exact Or.inr (Or.inl ⟨h, realification_irreducible_of_not_isCReal M hM hirr hSchur h.1⟩)
  · exact Or.inr (Or.inr ⟨h, realification_irreducible_of_not_isCReal M hM hirr hSchur
      (fun hcr => h hcr.hasCommutingAntiUnitary)⟩)

end BookProof.ChapterA

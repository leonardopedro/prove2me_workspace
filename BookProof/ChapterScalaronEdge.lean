import Mathlib
import BookProof.ChapterStarobinskyPotential
import BookProof.ChapterScalaronWallEsa
import BookProof.ChapterScalaronCoreEsa
import BookProof.ChapterWallEsaSemibounded
import BookProof.ChapterFriedrichsFormGap

/-!
# The strict one-particle edge for the Starobinsky fiber

`CONSOLIDATED_PLAN.md` §state 28j/29, item 4: the strict one-particle edge for the
Starobinsky fiber.

The Einstein-frame scalaron potential is `V(φ) = K(1 − e^{−aφ})²` with `K = M⁴/(16α)`
and `a = √(2/3)/M` (`BookProof.Starobinsky.starobinskyV`).  Its plateau value — the
limit as `φ → +∞`, `starobinskyV_tendsto_plateau` — is `K = M⁴/(16α)`, and it has an
exponential wall as `φ → −∞` (`starobinskyV_tendsto_atBot_atTop`).  Consequently the
classically allowed region `{φ | V(φ) < c}` is *bounded* for every `0 < c < K`; we work
with the fixed working threshold `edgeShelf = M⁴/(32α) < K` (any constant strictly below
the plateau works, and a smaller constant only shrinks the window).

## What is proved

* `starobinskyV_lt_shelf_bounded` — for `0 < c < edgeShelf` the sublevel set
  `{φ | V(φ) < c}` is contained in `[−A, B]` with the explicit positive endpoints
  `A = log(1 + √(c/K))/a`, `B = −log(1 − √(c/K))/a`.
* `edge_sup_sq_le` — the elementary one-dimensional Agmon/Gagliardo bound
  `‖f(x)‖² ≤ δ‖f‖²_{L²} + δ⁻¹‖f'‖²_{L²}` for every compactly supported `C²` function
  and every `δ > 0` (integration of `d/dt‖f‖²` from the left end of the support).
* `edge_energy_bound` — the confinement estimate it buys: if `V ≥ 0` everywhere and
  `V ≥ c` outside `[−A, B]`, then
  `∫|f'|² + ∫V|f|² ≥ min(1/(4(A+B)²), c/2) · ∫|f|²`.
* **`starobinskyEdge_quadForm`** — the strict one-particle edge for the fiber
  Hamiltonian `h_ψ = −d²/dφ² + V(φ̂)` on the compactly supported smooth core of `L²(ℝ)`:
  `⟪h_ψ ψ, ψ⟫ ≥ E₀⟪ψ, ψ⟫` with the explicit `E₀ = min(edgeKinConst A B) (edgeMassConst c) > 0`.
* `starobinskyEdge_form_gap` — the same statement in the project's `quadForm` shape.
* **`scalaronEdge_friedrichs_gap`** — the lift of the edge off the core: the Friedrichs
  extension of `h_ψ` is a positive self-adjoint extension, is the operator the Hashimoto
  shift-invert scheme selects, and inherits the strict lower bound `E₀ > 0` on its whole
  domain (`BookProof.FriedrichsFormGap.friedrichs_extension_form_gap`).

## Honest boundary

* What becomes unconditional: the strict one-particle edge for the scalaron-fiber
  Schrödinger operator `−d²/dφ² + starobinskyV(φ̂)` on the compactly supported smooth
  core, and its transfer to the Friedrichs extension selected by the shift-invert scheme.
* What stays a modelling statement: that this fiber operator is *the* scalaron sector's
  one-particle input of the enclosure doctrine (same boundary as the constant-model wave).
  The TEGR kinetic/gravity sector is untouched and remains outside the gap claims.  No
  mass gap of any physical Yang–Mills or gravity Hamiltonian is claimed.
* The `E₀` produced is the constructive (non-sharp) confinement constant — the numerically
  observed `E₀ ≈ 0.689` at `α = 1/12` is a different, sharper statement, not claimed here.
* The number-preserving `dΓ` lift of `ChapterFockNumberPreservingGap` is *not* instantiated
  here: it consumes a one-particle operator that is an endomorphism of the finite-mode
  domain of a Hilbert basis, and `−d²/dφ² + V` leaves no finite-mode subspace of the
  compactly supported core invariant.  The Friedrichs transfer above is the honest
  off-core statement for this fiber.
-/

namespace BookProof.ScalaronEdge

open Complex Real MeasureTheory Function SchwartzMap ComplexOrder
open BookProof.Starobinsky
open BookProof.ScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.FarisLavine
open BookProof.WallEsaSemibounded
open BookProof.FriedrichsExtension
open BookProof.FriedrichsFormGap
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert

/-! ## 0. The Starobinsky potential and the operator

The wall module works with the *explicit* potential `fun phi => starobinskyV M alpha phi`
at parameters `M, alpha` (see `starobinskyWall_esa`).  We fix parameters once and work with
that operator, so every statement below is an instance of the wall API. -/

variable (M alpha : ℝ)

/-- The wall potential at the fixed parameters. -/
noncomputable def scalV : ℝ → ℝ := fun phi => starobinskyV M alpha phi

theorem scalV_smooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (scalV M alpha) :=
  contDiff_starobinskyV M alpha

theorem scalV_nonneg (halpha : 0 < alpha) (x : ℝ) : 0 ≤ scalV M alpha x :=
  starobinskyV_nonneg halpha x

/-- The working threshold below the shelf of the wall potential.  The plateau value is
`lim_{φ→+∞} V = M⁴/(16α)` (`starobinskyV_tendsto_plateau`), so the sublevel sets `{V < c}`
are bounded exactly for `c` strictly below it; `edgeShelf := M⁴/(32α)` is the fixed working
threshold used here (any constant strictly below the plateau works; the smaller the
constant, the smaller the window). -/
noncomputable def edgeShelf : ℝ := M ^ 4 / (32 * alpha)

theorem edgeShelf_pos (hM : 0 < M) (halpha : 0 < alpha) : 0 < edgeShelf M alpha := by
  unfold edgeShelf; positivity

/-- The fiber Hamiltonian: the Schrödinger operator with the wall potential on the
compactly supported smooth core of `L²(ℝ)` — exactly the operator of
`starobinskyWall_esa`. -/
noncomputable def starobinskyEdgeHam : ccDomain ℝ →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ) :=
  wallHam (scalV M alpha) (scalV_smooth M alpha)

/-- The fiber Hamiltonian is symmetric on the core (from `wallHam_symmetricOn`). -/
theorem starobinskyEdgeHam_symmetricOn :
    SymmetricOn (ccDomain ℝ) (starobinskyEdgeHam M alpha) :=
  wallHam_symmetricOn _ (scalV_smooth M alpha)

/-! ## 1. Boundedness of the classically allowed region -/

/-- **Boundedness of the classically allowed region.**  For `0 < c < edgeShelf` the
sublevel set `{x | scalV x < c}` is contained in a bounded interval `[−A, B]` with
explicit, positive endpoints: the exponential wall (`scalV → ∞` as `x → −∞`) and the
plateau (`scalV → M⁴/(16α)` as `x → +∞`) each give one side.  With `K = M⁴/(16α)`,
`a = √(2/3)/M` and `s = √(c/K) ∈ (0,1)` the endpoints are `A = log(1+s)/a` and
`B = −log(1−s)/a`. -/
theorem starobinskyV_lt_shelf_bounded (hM : 0 < M) (halpha : 0 < alpha) (c : ℝ) (hc : 0 < c)
    (hcs : c < edgeShelf M alpha) :
    ∃ A B : ℝ, 0 < A ∧ 0 < B ∧
      ∀ x : ℝ, scalV M alpha x < c → x ∈ Set.Icc (-A) B := by
  set K : ℝ := M ^ 4 / (16 * alpha) with hK
  have hKpos : 0 < K := by rw [hK]; positivity
  have hcK : c < K := by
    have h1 : M ^ 4 / (32 * alpha) < M ^ 4 / (16 * alpha) :=
      div_lt_div_of_pos_left (by positivity) (by positivity) (by linarith)
    rw [hK]
    unfold edgeShelf at hcs
    linarith
  set a : ℝ := Real.sqrt (2 / 3) / M with ha
  have hapos : 0 < a := div_pos (Real.sqrt_pos.mpr (by norm_num)) hM
  set s : ℝ := Real.sqrt (c / K) with hs
  have hspos : 0 < s := Real.sqrt_pos.mpr (by positivity)
  have hs1 : s < 1 := by
    rw [hs, show (1 : ℝ) = Real.sqrt 1 by simp]
    exact Real.sqrt_lt_sqrt (by positivity) ((div_lt_one hKpos).mpr hcK)
  have hssq : s ^ 2 = c / K := Real.sq_sqrt (by positivity)
  refine ⟨Real.log (1 + s) / a, -Real.log (1 - s) / a, div_pos (Real.log_pos (by linarith))
    hapos, div_pos (by simpa using Real.log_neg (by linarith) (by linarith)) hapos, ?_⟩
  intro x hx
  have hexp : -(Real.sqrt (2 / 3)) * x / M = -(a * x) := by rw [ha]; field_simp
  rw [scalV, starobinskyV, hexp] at hx
  set E : ℝ := Real.exp (-(a * x)) with hE
  have hEpos : 0 < E := Real.exp_pos _
  have hsq : (1 - E) ^ 2 < s ^ 2 := by
    rw [hssq, ← hK] at *
    rw [lt_div_iff₀ hKpos]
    nlinarith
  have h1 : -s < 1 - E := by nlinarith
  have h2 : 1 - E < s := by nlinarith
  constructor
  · have hE1 : Real.exp (-(a * x)) < Real.exp (Real.log (1 + s)) := by
      rw [Real.exp_log (by linarith), ← hE]; linarith
    have h3 : -(a * x) < Real.log (1 + s) := Real.exp_lt_exp.mp hE1
    rw [neg_le, le_div_iff₀ hapos]
    nlinarith
  · have hE2 : Real.exp (Real.log (1 - s)) < Real.exp (-(a * x)) := by
      rw [Real.exp_log (by linarith), ← hE]; linarith
    have h3 : Real.log (1 - s) < -(a * x) := Real.exp_lt_exp.mp hE2
    rw [le_div_iff₀ hapos]
    nlinarith

/-! ## 2. The two explicit constants of the edge -/

/-- The kinetic part of the edge constant: the confinement cost of the window `[−A, B]`,
`E_kin = 1/(4(A+B)²)`. -/
noncomputable def edgeKinConst (A B : ℝ) : ℝ := 1 / (4 * (A + B) ^ 2)

theorem edgeKinConst_pos {A B : ℝ} (hA : 0 < A) (hB : 0 < B) : 0 < edgeKinConst A B := by
  unfold edgeKinConst
  have : 0 < A + B := by linarith
  positivity

/-- The mass part of the edge constant: half the outside cost, `E_mass = c/2`. -/
noncomputable def edgeMassConst (c : ℝ) : ℝ := c / 2

theorem edgeMassConst_pos {c : ℝ} (hc : 0 < c) : 0 < edgeMassConst c := by
  unfold edgeMassConst; linarith

/-! ## 3. The elementary confinement estimate

Everything in this section is classical one-dimensional calculus for a compactly supported
`C²` function `f : ℝ → ℂ`; no property of the Starobinsky potential is used. -/

/-- The energy density `t ↦ ‖f t‖²` is differentiable with derivative
`Re(conj(f')f + conj(f)f')`. -/
theorem edge_normSq_hasDerivAt (f : ℝ → ℂ) (hf : ContDiff ℝ 2 f) (x : ℝ) :
    HasDerivAt (fun t => ‖f t‖ ^ 2)
      (((starRingEnd ℂ) (deriv f x) * f x + (starRingEnd ℂ) (f x) * deriv f x).re) x := by
  have hfd : Differentiable ℝ f := hf.differentiable (by norm_num)
  have h1 : HasDerivAt f (deriv f x) x := (hfd x).hasDerivAt
  have hG : HasDerivAt (fun t => (starRingEnd ℂ) (f t) * f t)
      ((starRingEnd ℂ) (deriv f x) * f x + (starRingEnd ℂ) (f x) * deriv f x) x :=
    (h1.star).mul h1
  refine (Complex.reCLM.hasFDerivAt.comp_hasDerivAt x hG).congr_of_eventuallyEq ?_
  filter_upwards with t
  simp [Complex.sq_norm, Complex.normSq_apply]

/-- The pointwise absorption inequality `2|z||w| ≤ δ|z|² + δ⁻¹|w|²`, in the form the energy
density needs. -/
theorem edge_re_mul_le (z w : ℂ) {δ : ℝ} (hδ : 0 < δ) :
    ((starRingEnd ℂ) w * z + (starRingEnd ℂ) z * w).re ≤ δ * ‖z‖ ^ 2 + δ⁻¹ * ‖w‖ ^ 2 := by
  have h1 : ((starRingEnd ℂ) w * z + (starRingEnd ℂ) z * w).re
      ≤ ‖(starRingEnd ℂ) w * z + (starRingEnd ℂ) z * w‖ := Complex.re_le_norm _
  have h2 : ‖(starRingEnd ℂ) w * z + (starRingEnd ℂ) z * w‖ ≤ 2 * (‖z‖ * ‖w‖) := by
    calc ‖(starRingEnd ℂ) w * z + (starRingEnd ℂ) z * w‖
        ≤ ‖(starRingEnd ℂ) w * z‖ + ‖(starRingEnd ℂ) z * w‖ := norm_add_le _ _
      _ = 2 * (‖z‖ * ‖w‖) := by simp [mul_comm]; ring
  have h3 : δ * ‖z‖ ^ 2 + δ⁻¹ * ‖w‖ ^ 2 - 2 * (‖z‖ * ‖w‖) = δ⁻¹ * (δ * ‖z‖ - ‖w‖) ^ 2 := by
    field_simp; ring
  nlinarith [sq_nonneg (δ * ‖z‖ - ‖w‖), inv_pos.mpr hδ]

/-- **The one-dimensional sup bound.**  For a compactly supported `C²` function on the line
and any `δ > 0`, `‖f(x)‖² ≤ δ∫‖f‖² + δ⁻¹∫‖f'‖²` — integrate `d/dt‖f‖²` from a point to the
left of the support and absorb with `edge_re_mul_le`. -/
theorem edge_sup_sq_le (f : ℝ → ℂ) (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f)
    {δ : ℝ} (hδ : 0 < δ) (x : ℝ) :
    ‖f x‖ ^ 2 ≤ ∫ t, (δ * ‖f t‖ ^ 2 + δ⁻¹ * ‖deriv f t‖ ^ 2) := by
  set g' : ℝ → ℝ := fun t =>
    ((starRingEnd ℂ) (deriv f t) * f t + (starRingEnd ℂ) (f t) * deriv f t).re with hg'def
  set h : ℝ → ℝ := fun t => δ * ‖f t‖ ^ 2 + δ⁻¹ * ‖deriv f t‖ ^ 2 with hhdef
  have hcont0 : Continuous f := hf.continuous
  have hcont1 : Continuous (deriv f) := (hf.deriv' (n := 1)).continuous
  have hs1 : HasCompactSupport (deriv f) := hs.deriv
  have hgc : Continuous g' := by rw [hg'def]; fun_prop
  have hhc : Continuous h := by rw [hhdef]; fun_prop
  have hhsupp : HasCompactSupport h :=
    HasCompactSupport.add (hs.comp_left (g := fun z : ℂ => δ * ‖z‖ ^ 2) (by simp))
      (hs1.comp_left (g := fun z : ℂ => δ⁻¹ * ‖z‖ ^ 2) (by simp))
  have hhint : Integrable h := hhc.integrable_of_hasCompactSupport hhsupp
  have hhnn : ∀ t, 0 ≤ h t := fun t => by rw [hhdef]; positivity
  obtain ⟨R, hR⟩ := hs.isCompact.isBounded.subset_closedBall 0
  set y : ℝ := min x (-|R| - 1) with hydef
  have hyx : y ≤ x := min_le_left _ _
  have hy0 : ‖f y‖ ^ 2 = 0 := by
    have hny : y ∉ tsupport f := by
      intro hmem
      have h2 : |y| ≤ R := by simpa [Real.norm_eq_abs] using hR hmem
      have h1 : y ≤ -|R| - 1 := min_le_right _ _
      have h3 : -y ≤ |y| := neg_le_abs _
      have h4 : R ≤ |R| := le_abs_self R
      linarith
    simp [image_eq_zero_of_notMem_tsupport hny]
  have hint : IntervalIntegrable g' volume y x := hgc.intervalIntegrable _ _
  have hftc : ∫ t in y..x, g' t = ‖f x‖ ^ 2 - ‖f y‖ ^ 2 :=
    intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun t _ => edge_normSq_hasDerivAt f hf t) hint
  have hmono : ∫ t in y..x, g' t ≤ ∫ t in y..x, h t :=
    intervalIntegral.integral_mono_on hyx hint (hhc.intervalIntegrable _ _)
      (fun t _ => edge_re_mul_le (f t) (deriv f t) hδ)
  have hle : ∫ t in y..x, h t ≤ ∫ t, h t := by
    rw [intervalIntegral.integral_of_le hyx]
    exact setIntegral_le_integral hhint (Filter.Eventually.of_forall hhnn)
  rw [hy0, sub_zero] at hftc
  linarith [hftc ▸ hmono]

/-- **The confinement estimate.**  If `V ≥ 0` everywhere and `V ≥ c > 0` outside the window
`[−A, B]`, then the Schrödinger energy of every compactly supported `C²` function is at
least `min(1/(4(A+B)²), c/2)` times its `L²` norm squared. -/
theorem edge_energy_bound {A B c : ℝ} (hA : 0 < A) (hB : 0 < B) (hc : 0 < c)
    (V : ℝ → ℝ) (hVcont : Continuous V) (hVnn : ∀ x, 0 ≤ V x)
    (hVout : ∀ x, x ∉ Set.Icc (-A) B → c ≤ V x)
    (f : ℝ → ℂ) (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f) :
    min (edgeKinConst A B) (edgeMassConst c) * (∫ x, ‖f x‖ ^ 2)
      ≤ (∫ x, ‖deriv f x‖ ^ 2) + ∫ x, V x * ‖f x‖ ^ 2 := by
  have hL : 0 < A + B := by linarith
  set S := ∫ x, ‖f x‖ ^ 2 with hS
  set T := ∫ x, ‖deriv f x‖ ^ 2 with hT
  set U := ∫ x, V x * ‖f x‖ ^ 2 with hU
  have hcont0 : Continuous f := hf.continuous
  have hcont1 : Continuous (deriv f) := (hf.deriv' (n := 1)).continuous
  have hs1 : HasCompactSupport (deriv f) := hs.deriv
  have hsq : Continuous fun x => ‖f x‖ ^ 2 := by fun_prop
  have hsqsupp : HasCompactSupport fun x => ‖f x‖ ^ 2 :=
    hs.comp_left (g := fun z : ℂ => ‖z‖ ^ 2) (by simp)
  have hSint : Integrable fun x => ‖f x‖ ^ 2 := hsq.integrable_of_hasCompactSupport hsqsupp
  have hTint : Integrable fun x => ‖deriv f x‖ ^ 2 :=
    (by fun_prop : Continuous fun x => ‖deriv f x‖ ^ 2).integrable_of_hasCompactSupport
      (hs1.comp_left (g := fun z : ℂ => ‖z‖ ^ 2) (by simp))
  have hUint : Integrable fun x => V x * ‖f x‖ ^ 2 :=
    (hVcont.mul hsq).integrable_of_hasCompactSupport hsqsupp.mul_left
  have hSnn : 0 ≤ S := integral_nonneg fun x => by positivity
  have hTnn : 0 ≤ T := integral_nonneg fun x => by positivity
  have hUnn : 0 ≤ U := integral_nonneg fun x => by have := hVnn x; positivity
  have hsplit : (∫ t, ((2 * (A + B))⁻¹ * ‖f t‖ ^ 2 + (2 * (A + B)) * ‖deriv f t‖ ^ 2))
      = (2 * (A + B))⁻¹ * S + (2 * (A + B)) * T := by
    rw [integral_add (hSint.const_mul _) (hTint.const_mul _), integral_const_mul,
      integral_const_mul]
  have hsup : ∀ x, ‖f x‖ ^ 2 ≤ (2 * (A + B))⁻¹ * S + (2 * (A + B)) * T := by
    intro x
    have hδ : (0 : ℝ) < (2 * (A + B))⁻¹ := by positivity
    have := edge_sup_sq_le f hf hs hδ x
    rw [inv_inv] at this
    rw [← hsplit]
    exact this
  have hmeas : volume (Set.Icc (-A) B) ≠ ⊤ := by
    rw [Real.volume_Icc]; exact ENNReal.ofReal_ne_top
  have hvol : volume.real (Set.Icc (-A) B) = A + B := by
    rw [measureReal_def, Real.volume_Icc, ENNReal.toReal_ofReal (by linarith)]; ring
  have hin : ∫ x in Set.Icc (-A) B, ‖f x‖ ^ 2
      ≤ (A + B) * ((2 * (A + B))⁻¹ * S + (2 * (A + B)) * T) := by
    have h1 : ∫ x in Set.Icc (-A) B, ‖f x‖ ^ 2
        ≤ ∫ _x in Set.Icc (-A) B, ((2 * (A + B))⁻¹ * S + (2 * (A + B)) * T) :=
      setIntegral_mono_on hSint.integrableOn (integrableOn_const hmeas)
        measurableSet_Icc (fun x _ => hsup x)
    rw [setIntegral_const, hvol, smul_eq_mul] at h1
    exact h1
  have hout : ∫ x in (Set.Icc (-A) B)ᶜ, ‖f x‖ ^ 2 ≤ U / c := by
    have h1 : ∫ x in (Set.Icc (-A) B)ᶜ, ‖f x‖ ^ 2
        ≤ ∫ x in (Set.Icc (-A) B)ᶜ, V x * ‖f x‖ ^ 2 / c := by
      refine setIntegral_mono_on hSint.integrableOn (hUint.div_const c).integrableOn
        measurableSet_Icc.compl (fun x hx => ?_)
      have hVx := hVout x hx
      rw [le_div_iff₀ hc]
      nlinarith [sq_nonneg ‖f x‖]
    have h2 : ∫ x in (Set.Icc (-A) B)ᶜ, V x * ‖f x‖ ^ 2 / c ≤ ∫ x, V x * ‖f x‖ ^ 2 / c :=
      setIntegral_le_integral (hUint.div_const c)
        (Filter.Eventually.of_forall fun x => by have := hVnn x; positivity)
    have h3 : (∫ x, V x * ‖f x‖ ^ 2 / c) = U / c := integral_div c _
    linarith
  have hSsplit : (∫ x in Set.Icc (-A) B, ‖f x‖ ^ 2)
      + ∫ x in (Set.Icc (-A) B)ᶜ, ‖f x‖ ^ 2 = S := integral_add_compl measurableSet_Icc hSint
  have hkey : S ≤ (A + B) * ((2 * (A + B))⁻¹ * S + (2 * (A + B)) * T) + U / c := by linarith
  have hkey2 : S ≤ 4 * (A + B) ^ 2 * T + 2 * (U / c) := by
    have hexp : (A + B) * ((2 * (A + B))⁻¹ * S + (2 * (A + B)) * T)
        = S / 2 + 2 * (A + B) ^ 2 * T := by field_simp
    rw [hexp] at hkey
    linarith
  set m := min (edgeKinConst A B) (edgeMassConst c) with hm
  have hm1 : m ≤ 1 / (4 * (A + B) ^ 2) := min_le_left _ _
  have hm2 : m ≤ c / 2 := min_le_right _ _
  have hmpos : 0 < m := lt_min (edgeKinConst_pos hA hB) (edgeMassConst_pos hc)
  have h4L : (0 : ℝ) < 4 * (A + B) ^ 2 := by positivity
  have hm1' : m * (4 * (A + B) ^ 2) ≤ 1 := by rw [le_div_iff₀ h4L] at hm1; exact hm1
  calc m * S ≤ m * (4 * (A + B) ^ 2 * T + 2 * (U / c)) := by nlinarith
    _ ≤ T + U := by
        have hA1 : m * (4 * (A + B) ^ 2 * T) ≤ T := by nlinarith
        have hA2 : m * (2 * (U / c)) ≤ U := by
          have hUc : 0 ≤ U / c := by positivity
          have hmc : m * 2 ≤ c := by linarith
          calc m * (2 * (U / c)) = (m * 2) * (U / c) := by ring
            _ ≤ c * (U / c) := mul_le_mul_of_nonneg_right hmc hUc
            _ = U := by field_simp
        linarith

/-! ## 4. The strict one-particle edge -/

/-- The pairing of the fiber Hamiltonian with a core vector, as ordinary integrals. -/
theorem starobinskyEdge_inner_eq (f : ccSchwartz ℝ) :
    (inner ℂ (starobinskyEdgeHam M alpha (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = (((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2)
          + ∫ x, scalV M alpha x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by
  have hk := kinCcR_quadratic_form f
  have hp := opCc_quadratic_form (scalV M alpha) (scalV_smooth M alpha) f
  simp only [starobinskyEdgeHam, wallHam, LinearMap.add_apply, inner_add_left, hk, hp]
  push_cast
  ring

/-- The `L²` square of a core vector, as an ordinary integral. -/
theorem starobinskyEdge_self_inner (f : ccSchwartz ℝ) :
    (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by
  rw [ccEquiv_coe]
  exact inner_toLp_self _

/-- The quadratic form of the fiber Hamiltonian on a core vector, as ordinary integrals. -/
theorem starobinskyEdge_quadForm_eq (f : ccSchwartz ℝ) :
    quadForm (starobinskyEdgeHam M alpha) (ccEquiv ℝ f)
      = (∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2)
        + ∫ x, scalV M alpha x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  have hconj : (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))
      (starobinskyEdgeHam M alpha (ccEquiv ℝ f)) : ℂ)
      = (starRingEnd ℂ) (inner ℂ (starobinskyEdgeHam M alpha (ccEquiv ℝ f))
          ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ))) :=
    (inner_conj_symm _ _).symm
  rw [quadForm, hconj, starobinskyEdge_inner_eq, Complex.conj_ofReal, Complex.ofReal_re]

/-- **The strict one-particle edge, in the project's `quadForm` shape.**  For every
`0 < c < edgeShelf` the form of the Starobinsky fiber Hamiltonian is bounded below by
`E₀‖ψ‖²` on the compactly supported smooth core, with the explicit positive constant
`E₀ = min (edgeKinConst A B) (edgeMassConst c)`.

This is the elementary-confinement route of plan item 4(b): the form does not vanish on any
nonzero core vector. -/
theorem starobinskyEdge_form_gap (hM : 0 < M) (halpha : 0 < alpha) (c : ℝ) (hc : 0 < c)
    (hcs : c < edgeShelf M alpha) :
    ∃ E₀ : ℝ, 0 < E₀ ∧ ∀ ψ : ccDomain ℝ,
      E₀ * ‖(ψ : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
        ≤ quadForm (starobinskyEdgeHam M alpha) ψ := by
  obtain ⟨A, B, hA, hB, hbound⟩ :=
    starobinskyV_lt_shelf_bounded M alpha hM halpha c hc hcs
  refine ⟨min (edgeKinConst A B) (edgeMassConst c),
    lt_min (edgeKinConst_pos hA hB) (edgeMassConst_pos hc), ?_⟩
  intro ψ
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective ψ
  have hVcont : Continuous (scalV M alpha) := (scalV_smooth M alpha).continuous
  have hVout : ∀ x, x ∉ Set.Icc (-A) B → c ≤ scalV M alpha x := by
    intro x hx
    exact le_of_not_gt fun hlt => hx (hbound x hlt)
  have hmain := edge_energy_bound hA hB hc (scalV M alpha) hVcont
    (scalV_nonneg M alpha halpha) hVout ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)
    ((f : 𝓢(ℝ, ℂ)).smooth 2) f.2
  rw [starobinskyEdge_quadForm_eq, ccEquiv_norm_sq]
  exact hmain

/-- **The strict one-particle edge.**  The same statement as `starobinskyEdge_form_gap`, in
the `L²` pairing form the plan states it in:

`⟪h_ψ ψ, ψ⟫ ≥ E₀⟪ψ, ψ⟫` for every `ψ` in the compactly supported smooth core. -/
theorem starobinskyEdge_quadForm (hM : 0 < M) (halpha : 0 < alpha) (c : ℝ) (hc : 0 < c)
    (hcs : c < edgeShelf M alpha) :
    ∃ E₀ : ℝ, 0 < E₀ ∧ ∀ ψ : ccDomain ℝ,
      (inner ℂ (starobinskyEdgeHam M alpha ψ)
          ((ψ : Lp ℂ 2 (volume : Measure ℝ))) : ℂ)
        ≥ (E₀ : ℂ) * inner ℂ ((ψ : Lp ℂ 2 (volume : Measure ℝ)))
            ((ψ : Lp ℂ 2 (volume : Measure ℝ))) := by
  obtain ⟨E₀, hE₀, hgap⟩ := starobinskyEdge_form_gap M alpha hM halpha c hc hcs
  refine ⟨E₀, hE₀, fun ψ => ?_⟩
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective ψ
  have hgapf := hgap (ccEquiv ℝ f)
  rw [starobinskyEdge_quadForm_eq, ccEquiv_norm_sq] at hgapf
  rw [starobinskyEdge_inner_eq, starobinskyEdge_self_inner, ← Complex.ofReal_mul, ge_iff_le,
    Complex.real_le_real]
  exact hgapf

/-! ## 5. The edge off the core: the Friedrichs extension -/

/-- **The strict edge transfers to the Friedrichs extension.**  The fiber Hamiltonian is a
densely defined positive symmetric operator, so it has a Friedrichs extension `A` which is a
positive self-adjoint extension, is the operator the Hashimoto shift-invert scheme selects
at `γ = 1`, and satisfies the *same* strict lower bound `⟪y, A y⟫ ≥ E₀‖y‖²` on its whole
domain.  This is the one-particle mass gap of the scalaron fiber, off the core. -/
theorem scalaronEdge_friedrichs_gap (hM : 0 < M) (halpha : 0 < alpha) (c : ℝ) (hc : 0 < c)
    (hcs : c < edgeShelf M alpha) :
    ∃ E₀ : ℝ, 0 < E₀ ∧ ∃ (Dom : Submodule ℂ (Lp ℂ 2 (volume : Measure ℝ)))
      (A : Dom →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ))
      (S : Lp ℂ 2 (volume : Measure ℝ) →L[ℂ] Lp ℂ 2 (volume : Measure ℝ)),
      IsPositiveSelfAdjointExtension (starobinskyEdgeHam M alpha) A ∧ IsShiftInvert A 1 S ∧
        IsSelfAdjoint S ∧ (∀ y : Dom, E₀ * ‖(y : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2
          ≤ quadForm A y) := by
  obtain ⟨E₀, hE₀, hgap⟩ := starobinskyEdge_form_gap M alpha hM halpha c hc hcs
  have hpos : ∀ x : ccDomain ℝ, 0 ≤ quadForm (starobinskyEdgeHam M alpha) x := by
    intro x
    have := hgap x
    have h2 : 0 ≤ E₀ * ‖(x : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2 := by positivity
    linarith
  let P : PosSymOp (Lp ℂ 2 (volume : Measure ℝ)) :=
    { dom := ccDomain ℝ
      op := starobinskyEdgeHam M alpha
      sym := starobinskyEdgeHam_symmetricOn M alpha
      pos := hpos }
  obtain ⟨Dom, A, S, hext, hshift, hsa, hlow⟩ :=
    friedrichs_extension_form_gap P ccDomain_dense hgap
  exact ⟨E₀, hE₀, Dom, A, S, hext, hshift, hsa, hlow⟩

end BookProof.ScalaronEdge

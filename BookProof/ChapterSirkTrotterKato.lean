import Mathlib
import BookProof.ChapterStoneGenerator

/-!
# Chapter SirkTrotterKato — the unbounded half of §12 Gap 3 (Trotter–Kato)

`CONSOLIDATED_PLAN.md` §12.2 **Gap 3** asks for the transfer of generator
convergence to the *unitary group*: `e^{−itAₙ} → e^{−itA}` strongly, locally
uniformly in `t`.  `ChapterSirkGroupTransfer` settled the **bounded** half (norm
convergence of bounded generators, with an explicit rate).  This chapter settles
the **unbounded** half — the Trotter–Kato theorem itself — for the unbounded
self-adjoint operators of `ChapterStoneResolvent`, i.e. exactly the objects the
selection theorems of the project produce:

> if the resolvents `(Aₙ − i)⁻¹` converge strongly to `(A − i)⁻¹`, then
> `e^{−itAₙ} v → e^{−itA} v` for every `v`, uniformly for `t` in a bounded
> interval.

The proof is the classical Duhamel argument, formalized in four steps.

* `hasDerivAt_stoneU_const_sub` — the backwards flow `r ↦ e^{−i(t−r)A} z`
  differentiates to `+ i A` on the domain.
* `hasDerivAt_stoneU_const_sub_apply` — the **weak product rule**: the flow is
  only strongly continuous, so `r ↦ e^{−i(t−r)A} (y r)` cannot be differentiated
  by the ordinary product rule; it is differentiated here from the definition,
  for a curve `y` differentiable at the point and taking its value there in the
  domain.
* `resolvent_commutator_eq` — the algebraic heart, `Aₛ Rₛ − Rₛ A = (R − Rₛ)(A − i)`
  on `dom A`, where `R = (A − i)⁻¹` and `Rₛ = (Aₛ − i)⁻¹`.
* `hasDerivAt_duhamel` — the Duhamel derivative
  `d/dr [ e^{−i(t−r)Aₛ} Rₛ e^{−irA} χ ] = i e^{−i(t−r)Aₛ} (R − Rₛ) e^{−irA}(A − i)χ`,
  and `norm_res_stoneU_sub_stoneU_res_le` — the resulting mean-value estimate.

The convergence statements are `trotterKato_uniform_of_mem_range` (on the dense
set `R(dom A)`), `trotterKato_uniform_on_interval` and
`trotterKato_tendstoUniformlyOn` (**the headline: locally uniformly in `t`**) and
`trotterKato_tendsto` (strong convergence at a fixed time).  The auxiliary
`tendsto_uniformly_on_isCompact_of_tendsto` is the standard equi-Lipschitz upgrade
of pointwise convergence to uniform convergence on a compact set.

## Honest boundary

Strong resolvent convergence is *assumed* at the single point `i` of the
resolvent set, which is all the theorem needs; nothing here proves that the
Galerkin/Hashimoto compressions of a given physical Hamiltonian satisfy it — that
is the content of the per-system selection theorems, which the project proves
separately.  Together with those, this chapter closes the transfer step: the
flow of the selected generator is the limit of the approximating flows.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open Filter Topology Asymptotics
open scoped InnerProductSpace

namespace BookProof.ChapterSirkTrotterKato

open BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-! ## 1. Differentiating the backwards flow -/

/-- The backwards flow `r ↦ e^{−i(t−r)A} z` on the domain: its derivative is
`+ i A` applied to the current point (the sign flip of Stone's equation). -/
theorem hasDerivAt_stoneU_const_sub (S : UnboundedSelfAdjoint H) (z : S.domain) (t u : ℝ) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (z : H))
      (Complex.I • S.op ⟨S.stoneU (t - u) (z : H), S.stoneU_mem_domain (t - u) z⟩) u := by
  have h := S.hasDerivAt_stoneU_op z (t - u)
  have h2 : HasDerivAt (fun r : ℝ => S.stoneU (t - r) (z : H))
      (-((-Complex.I) • S.op ⟨S.stoneU (t - u) (z : H), S.stoneU_mem_domain (t - u) z⟩)) u :=
    h.comp_const_sub t u
  simpa using h2

/-- The flow applied to a *moving* vector: the increment of `y` is handled by
isometry plus strong continuity.  (Auxiliary half of the weak product rule; the
value `y u` is subtracted off, so no domain hypothesis is needed.) -/
theorem hasDerivAt_stoneU_const_sub_incr (S : UnboundedSelfAdjoint H) {y : ℝ → H} {y' : H}
    {t u : ℝ} (hy : HasDerivAt y y' u) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (y r - y u)) (S.stoneU (t - u) y') u := by
  rw [hasDerivAt_iff_isLittleO]
  have hA : (fun r : ℝ => S.stoneU (t - r) (y r - y u - (r - u) • y')) =o[𝓝 u]
      fun r : ℝ => r - u := by
    have h := hasDerivAt_iff_isLittleO.mp hy
    rw [isLittleO_iff] at h ⊢
    intro c hc
    filter_upwards [h hc] with r hr
    calc ‖S.stoneU (t - r) (y r - y u - (r - u) • y')‖ = ‖y r - y u - (r - u) • y'‖ :=
          S.norm_stoneU_apply _ _
      _ ≤ c * ‖r - u‖ := hr
  have hB : (fun r : ℝ => (r - u) • (S.stoneU (t - r) y' - S.stoneU (t - u) y')) =o[𝓝 u]
      fun r : ℝ => r - u := by
    rw [isLittleO_iff]
    intro c hc
    have hcty : Continuous fun r : ℝ => S.stoneU (t - r) y' :=
      (S.continuous_stoneU_apply y').comp (continuous_const.sub continuous_id)
    have hc0 : Tendsto (fun r : ℝ => S.stoneU (t - r) y' - S.stoneU (t - u) y') (𝓝 u) (𝓝 0) := by
      have h1 : Tendsto (fun r : ℝ => S.stoneU (t - r) y') (𝓝 u) (𝓝 (S.stoneU (t - u) y')) :=
        hcty.tendsto u
      have h2 := h1.sub (tendsto_const_nhds (x := S.stoneU (t - u) y') (f := 𝓝 u))
      simpa using h2
    have hev : ∀ᶠ r in 𝓝 u, ‖S.stoneU (t - r) y' - S.stoneU (t - u) y'‖ ≤ c := by
      have h3 := hc0.norm
      simp only [norm_zero] at h3
      exact h3.eventually_le_const hc
    filter_upwards [hev] with r hr
    rw [norm_smul]
    simp only [Real.norm_eq_abs]
    calc |r - u| * ‖S.stoneU (t - r) y' - S.stoneU (t - u) y'‖ ≤ |r - u| * c :=
          mul_le_mul_of_nonneg_left hr (abs_nonneg _)
      _ = c * ‖r - u‖ := by rw [Real.norm_eq_abs]; ring
  have heq : (fun r : ℝ => S.stoneU (t - r) (y r - y u) - S.stoneU (t - u) (y u - y u)
        - (r - u) • S.stoneU (t - u) y')
      = fun r : ℝ => S.stoneU (t - r) (y r - y u - (r - u) • y')
          + (r - u) • (S.stoneU (t - r) y' - S.stoneU (t - u) y') := by
    funext r
    have h1 : S.stoneU (t - r) (y r - y u - (r - u) • y')
        = S.stoneU (t - r) (y r - y u) - (r - u) • S.stoneU (t - r) y' := by
      rw [map_sub, ContinuousLinearMap.map_smul_of_tower]
    simp only [sub_self, map_zero, sub_zero, h1, smul_sub]
    abel
  rw [heq]
  exact hA.add hB

/-- **The weak product rule.**  `e^{−isA}` is only strongly continuous, so the
curve `r ↦ e^{−i(t−r)A} (y r)` cannot be differentiated by the ordinary product
rule; it is differentiated here from the definition. -/
theorem hasDerivAt_stoneU_const_sub_apply (S : UnboundedSelfAdjoint H) {y : ℝ → H} {y' : H}
    {t u : ℝ} (hy : HasDerivAt y y' u) (hmem : y u ∈ S.domain) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (y r))
      (Complex.I • S.op ⟨S.stoneU (t - u) (y u), S.stoneU_mem_domain (t - u) ⟨y u, hmem⟩⟩
        + S.stoneU (t - u) y') u := by
  have h1 := hasDerivAt_stoneU_const_sub S ⟨y u, hmem⟩ t u
  have h2 := hasDerivAt_stoneU_const_sub_incr S hy (t := t)
  have heq : (fun r : ℝ => S.stoneU (t - r) ((⟨y u, hmem⟩ : S.domain) : H))
      + (fun r : ℝ => S.stoneU (t - r) (y r - y u)) = fun r : ℝ => S.stoneU (t - r) (y r) := by
    funext r
    simp only [Pi.add_apply, map_sub]
    abel
  have := h1.add h2
  rwa [heq] at this

/-! ## 2. The Duhamel derivative -/

/-- The algebraic heart of Trotter–Kato: on `dom A`,
`Aₛ Rₛ − Rₛ A = (R − Rₛ)(A − i)`, where `R = (A − i)⁻¹`, `Rₛ = (Aₛ − i)⁻¹`. -/
theorem resolvent_commutator_eq (T S : UnboundedSelfAdjoint H) (y : T.domain) :
    S.op ⟨S.resCLM 1 (y : H), S.resCLM_mem 1 (y : H)⟩ - S.resCLM 1 (T.op y)
      = T.resCLM 1 (T.shift 1 y) - S.resCLM 1 (T.shift 1 y) := by
  have h1 : S.op ⟨S.resCLM 1 (y : H), S.resCLM_mem 1 (y : H)⟩
      = (y : H) + ((1 : ℂ) * Complex.I) • (S.resCLM 1 (y : H)) := by
    have := S.op_res (l := 1) one_ne_zero (y : H)
    simpa using this
  have h2 : T.op y = T.shift 1 y + ((1 : ℂ) * Complex.I) • (y : H) := by
    rw [T.shift_apply]
    push_cast
    abel
  have h3 : T.resCLM 1 (T.shift 1 y) = (y : H) := by
    have := T.res_shift (l := 1) one_ne_zero y
    simpa using congrArg (fun (x : T.domain) => (x : H)) this
  rw [h1, h2, h3, map_add, ContinuousLinearMap.map_smul]
  abel

/-- The generator commutes with its flow, in shifted form:
`(A − i) e^{−irA} χ = e^{−irA} (A − i) χ`. -/
theorem stoneU_shift (T : UnboundedSelfAdjoint H) (chi : T.domain) (u : ℝ) :
    T.shift 1 ⟨T.stoneU u (chi : H), T.stoneU_mem_domain u chi⟩
      = T.stoneU u (T.shift 1 chi) := by
  rw [T.shift_apply, T.shift_apply, T.stoneU_op u chi, map_sub,
    ContinuousLinearMap.map_smul]

/-- **The Duhamel derivative.**  With `R = (A − i)⁻¹` and `Rₛ = (Aₛ − i)⁻¹`,
`d/dr [ e^{−i(t−r)Aₛ} Rₛ e^{−irA} χ ] = i e^{−i(t−r)Aₛ} (R − Rₛ) e^{−irA} (A − i)χ`. -/
theorem hasDerivAt_duhamel (T S : UnboundedSelfAdjoint H) (chi : T.domain) (t u : ℝ) :
    HasDerivAt (fun r : ℝ => S.stoneU (t - r) (S.resCLM 1 (T.stoneU r (chi : H))))
      (Complex.I • S.stoneU (t - u)
        (T.resCLM 1 (T.stoneU u (T.shift 1 chi))
          - S.resCLM 1 (T.stoneU u (T.shift 1 chi)))) u := by
  set y : ℝ → H := fun r => S.resCLM 1 (T.stoneU r (chi : H)) with hy
  have hmem : y u ∈ S.domain := S.resCLM_mem 1 _
  have hderiv : HasDerivAt y
      (S.resCLM 1 ((-Complex.I) • T.op ⟨T.stoneU u (chi : H), T.stoneU_mem_domain u chi⟩)) u := by
    have h := T.hasDerivAt_stoneU_op chi u
    exact ((S.resCLM 1).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt u h
  have hprod := hasDerivAt_stoneU_const_sub_apply S hderiv hmem (t := t)
  refine hprod.congr_deriv ?_
  -- identify the two derivative values
  set z : T.domain := ⟨T.stoneU u (chi : H), T.stoneU_mem_domain u chi⟩ with hz
  have hop : S.op ⟨S.stoneU (t - u) (y u), S.stoneU_mem_domain (t - u) ⟨y u, hmem⟩⟩
      = S.stoneU (t - u) (S.op ⟨y u, hmem⟩) := S.stoneU_op (t - u) ⟨y u, hmem⟩
  have hsm : S.resCLM 1 ((-Complex.I) • T.op z) = (-Complex.I) • S.resCLM 1 (T.op z) := by
    rw [ContinuousLinearMap.map_smul]
  have hcomm : S.op ⟨y u, hmem⟩ - S.resCLM 1 (T.op z)
      = T.resCLM 1 (T.shift 1 z) - S.resCLM 1 (T.shift 1 z) :=
    resolvent_commutator_eq T S z
  have hshift : T.shift 1 z = T.stoneU u (T.shift 1 chi) := stoneU_shift T chi u
  rw [hop, hsm, ← hshift]
  rw [show (S.stoneU (t - u) ((-Complex.I) • S.resCLM 1 (T.op z)))
      = (-Complex.I) • S.stoneU (t - u) (S.resCLM 1 (T.op z)) from
    ContinuousLinearMap.map_smul _ _ _]
  rw [← hcomm, map_sub]
  module

/-- **The Duhamel estimate.**  If the two resolvents differ by at most `C` along
the orbit of `(A − i)χ` on the time interval between `0` and `t`, then
`‖Rₛ e^{−itA} χ − e^{−itAₛ} Rₛ χ‖ ≤ C |t|`. -/
theorem norm_res_stoneU_sub_stoneU_res_le (T S : UnboundedSelfAdjoint H) (chi : T.domain)
    (t : ℝ) {C : ℝ}
    (hC : ∀ s ∈ Set.uIcc (0 : ℝ) t,
      ‖T.resCLM 1 (T.stoneU s (T.shift 1 chi)) - S.resCLM 1 (T.stoneU s (T.shift 1 chi))‖ ≤ C) :
    ‖S.resCLM 1 (T.stoneU t (chi : H)) - S.stoneU t (S.resCLM 1 (chi : H))‖ ≤ C * |t| := by
  set g : ℝ → H := fun r => S.stoneU (t - r) (S.resCLM 1 (T.stoneU r (chi : H))) with hg
  set g' : ℝ → H := fun r => Complex.I • S.stoneU (t - r)
    (T.resCLM 1 (T.stoneU r (T.shift 1 chi)) - S.resCLM 1 (T.stoneU r (T.shift 1 chi))) with hg'
  have hderiv : ∀ r, HasDerivAt g (g' r) r := fun r => hasDerivAt_duhamel T S chi t r
  have hnorm : ∀ r ∈ Set.uIcc (0 : ℝ) t, ‖g' r‖ ≤ C := by
    intro r hr
    have h1 : ‖g' r‖
        = ‖T.resCLM 1 (T.stoneU r (T.shift 1 chi)) - S.resCLM 1 (T.stoneU r (T.shift 1 chi))‖ := by
      rw [hg']
      simp only [norm_smul, Complex.norm_I, one_mul]
      exact S.norm_stoneU_apply _ _
    rw [h1]
    exact hC r hr
  have hconv : Convex ℝ (Set.uIcc (0 : ℝ) t) := convex_uIcc 0 t
  have hmv := hconv.norm_image_sub_le_of_norm_hasDerivWithin_le
    (fun r _ => (hderiv r).hasDerivWithinAt) hnorm Set.left_mem_uIcc Set.right_mem_uIcc
  have hgt : g t = S.resCLM 1 (T.stoneU t (chi : H)) := by
    rw [hg]
    simp only [sub_self, S.stoneU_zero, ContinuousLinearMap.one_apply]
  have hg0 : g 0 = S.stoneU t (S.resCLM 1 (chi : H)) := by
    rw [hg]
    simp only [sub_zero, T.stoneU_zero, ContinuousLinearMap.one_apply]
  rw [hgt, hg0] at hmv
  simpa using hmv

/-! ## 3. Pointwise convergence upgraded on compact sets -/

omit [CompleteSpace H] in
/-- **Equi-Lipschitz pointwise convergence is uniform on compacts.**  A sequence
of uniformly bounded linear maps converging pointwise to `0` converges uniformly
to `0` on every compact set. -/
theorem tendsto_uniformly_on_isCompact_of_tendsto {D : ℕ → H →L[ℂ] H} {M : ℝ}
    (hM : ∀ n y, ‖D n y‖ ≤ M * ‖y‖) (hptw : ∀ y, Tendsto (fun n => D n y) atTop (𝓝 0))
    {K : Set H} (hK : IsCompact K) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ y ∈ K, ‖D n y‖ ≤ ε := by
  set M' : ℝ := max M 1 with hM'
  have hM'pos : 0 < M' := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hM'le : ∀ n y, ‖D n y‖ ≤ M' * ‖y‖ := by
    intro n y
    exact (hM n y).trans (by nlinarith [norm_nonneg y, le_max_left M 1])
  set δ : ℝ := ε / (2 * M') with hδ
  have hδpos : 0 < δ := by positivity
  have hMδ : M' * δ = ε / 2 := by rw [hδ]; field_simp
  have hcover : K ⊆ ⋃ z ∈ K, Metric.ball z δ := fun y hy =>
    Set.mem_biUnion hy (Metric.mem_ball_self hδpos)
  obtain ⟨t, hts, htfin, htcover⟩ := hK.elim_finite_subcover_image
    (fun z (_ : z ∈ K) => Metric.isOpen_ball (x := z) (ε := δ)) hcover
  have hfin : ∀ᶠ n in atTop, ∀ z ∈ t, ‖D n z‖ ≤ ε / 2 := by
    rw [eventually_all_finite htfin]
    intro z _
    have h := (hptw z).norm
    simp only [norm_zero] at h
    exact h.eventually_le_const (by positivity)
  filter_upwards [hfin] with n hn y hy
  obtain ⟨z, hz, hyz⟩ := by simpa using htcover hy
  have h1 : ‖D n (y - z)‖ ≤ M' * δ := by
    refine (hM'le n _).trans ?_
    have hle : ‖y - z‖ ≤ δ := le_of_lt (by simpa [dist_eq_norm] using hyz)
    nlinarith [norm_nonneg (y - z)]
  have h2 : ‖D n z‖ ≤ ε / 2 := hn z hz
  have hsplit : D n y = D n (y - z) + D n z := by rw [map_sub]; abel
  calc ‖D n y‖ ≤ ‖D n (y - z)‖ + ‖D n z‖ := by rw [hsplit]; exact norm_add_le _ _
    _ ≤ M' * δ + ε / 2 := add_le_add h1 h2
    _ = ε := by rw [hMδ]; ring

/-! ## 4. Trotter–Kato -/

variable (T : UnboundedSelfAdjoint H) (S : ℕ → UnboundedSelfAdjoint H)

/-- Strong convergence of the resolvents at the point `i` of the resolvent set. -/
def StrongResolventConvergence : Prop :=
  ∀ y : H, Tendsto (fun n => (S n).resCLM 1 y) atTop (𝓝 (T.resCLM 1 y))

/-- The resolvent difference, as a bounded operator. -/
def resDiff (n : ℕ) : H →L[ℂ] H := T.resCLM 1 - (S n).resCLM 1

theorem norm_resDiff_apply_le (n : ℕ) (y : H) : ‖resDiff T S n y‖ ≤ 2 * ‖y‖ := by
  have h1 : ‖T.resCLM 1 y‖ ≤ ‖y‖ := by
    have := T.norm_resCLM_apply_le 1 y
    simpa using this
  have h2 : ‖(S n).resCLM 1 y‖ ≤ ‖y‖ := by
    have := (S n).norm_resCLM_apply_le 1 y
    simpa using this
  have : ‖resDiff T S n y‖ ≤ ‖T.resCLM 1 y‖ + ‖(S n).resCLM 1 y‖ := by
    simpa [resDiff] using norm_sub_le (T.resCLM 1 y) ((S n).resCLM 1 y)
  linarith

theorem tendsto_resDiff (hres : StrongResolventConvergence T S) (y : H) :
    Tendsto (fun n => resDiff T S n y) atTop (𝓝 0) := by
  have h := (hres y).const_sub (T.resCLM 1 y)
  simpa [resDiff] using h

/-- The orbit of a vector on a bounded time interval is compact. -/
theorem isCompact_orbit (y : H) (T₀ : ℝ) :
    IsCompact ((fun s : ℝ => T.stoneU s y) '' Set.Icc (-T₀) T₀) :=
  (isCompact_Icc).image (T.continuous_stoneU_apply y)

/-- **The core convergence step.**  On the dense set `R(dom A)` the flows
converge, uniformly on the time interval `[−T₀, T₀]`. -/
theorem trotterKato_uniform_of_mem_range (hres : StrongResolventConvergence T S)
    (w : T.domain) {T₀ : ℝ} (hT₀ : 0 ≤ T₀) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ t : ℝ, |t| ≤ T₀ →
      ‖(S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H))‖ ≤ ε := by
  set eps : ℝ := ε / (2 + T₀) with heps
  have hepspos : 0 < eps := by
    have : (0 : ℝ) < 2 + T₀ := by linarith
    positivity
  have hK1 := isCompact_orbit T (w : H) T₀
  have hK2 := isCompact_orbit T (T.shift 1 w) T₀
  have hb1 := tendsto_uniformly_on_isCompact_of_tendsto (norm_resDiff_apply_le T S)
    (tendsto_resDiff T S hres) hK1 hepspos
  have hb2 := tendsto_uniformly_on_isCompact_of_tendsto (norm_resDiff_apply_le T S)
    (tendsto_resDiff T S hres) hK2 hepspos
  filter_upwards [hb1, hb2] with n hn1 hn2 t ht
  -- the three terms
  have hmem0 : (w : H) ∈ (fun s : ℝ => T.stoneU s (w : H)) '' Set.Icc (-T₀) T₀ := by
    refine ⟨0, ⟨by linarith, hT₀⟩, ?_⟩
    simp
  have hmemt : T.stoneU t (w : H) ∈ (fun s : ℝ => T.stoneU s (w : H)) '' Set.Icc (-T₀) T₀ :=
    ⟨t, ⟨by cases abs_le.mp ht with | intro h1 _ => linarith,
      by cases abs_le.mp ht with | intro _ h2 => linarith⟩, rfl⟩
  -- term 1
  have hterm1 : ‖(S n).stoneU t (resDiff T S n (w : H))‖ ≤ eps := by
    rw [(S n).norm_stoneU_apply]
    exact hn1 _ hmem0
  -- term 2 (Duhamel)
  have hterm2 : ‖(S n).resCLM 1 (T.stoneU t (w : H))
      - (S n).stoneU t ((S n).resCLM 1 (w : H))‖ ≤ eps * |t| := by
    refine norm_res_stoneU_sub_stoneU_res_le T (S n) w t ?_
    intro s hs
    have hsmem : T.stoneU s (T.shift 1 w) ∈
        (fun s : ℝ => T.stoneU s (T.shift 1 w)) '' Set.Icc (-T₀) T₀ := by
      have hb := abs_le.mp ht
      rcases Set.mem_uIcc.mp hs with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact ⟨s, ⟨by linarith [hb.1], by linarith [hb.2]⟩, rfl⟩
      · exact ⟨s, ⟨by linarith [hb.1], by linarith [hb.2]⟩, rfl⟩
    exact hn2 _ hsmem
  -- term 3
  have hterm3 : ‖resDiff T S n (T.stoneU t (w : H))‖ ≤ eps := hn1 _ hmemt
  -- assemble
  have hcomm : T.stoneU t (T.resCLM 1 (w : H)) = T.resCLM 1 (T.stoneU t (w : H)) :=
    T.stoneU_commute_resCLM t 1 (w : H)
  have hsplit : (S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H))
      = (S n).stoneU t (resDiff T S n (w : H))
        + ((S n).stoneU t ((S n).resCLM 1 (w : H)) - (S n).resCLM 1 (T.stoneU t (w : H)))
        - resDiff T S n (T.stoneU t (w : H)) := by
    rw [hcomm]
    simp only [resDiff, ContinuousLinearMap.sub_apply, map_sub]
    abel
  have hb1' : ‖(S n).stoneU t (resDiff T S n (w : H))
      + ((S n).stoneU t ((S n).resCLM 1 (w : H)) - (S n).resCLM 1 (T.stoneU t (w : H)))‖
      ≤ eps + eps * |t| := by
    refine le_trans (norm_add_le _ _) (add_le_add hterm1 ?_)
    rw [norm_sub_rev]
    exact hterm2
  have hfinal : eps + eps * |t| + eps ≤ ε := by
    have h1 : eps * |t| ≤ eps * T₀ := by
      exact mul_le_mul_of_nonneg_left ht (le_of_lt hepspos)
    have h2 : eps + eps * T₀ + eps = ε := by
      rw [heps]
      field_simp
      ring
    linarith
  calc ‖(S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H))‖
      ≤ ‖(S n).stoneU t (resDiff T S n (w : H))
          + ((S n).stoneU t ((S n).resCLM 1 (w : H)) - (S n).resCLM 1 (T.stoneU t (w : H)))‖
        + ‖resDiff T S n (T.stoneU t (w : H))‖ := by
        rw [hsplit]; exact norm_sub_le _ _
    _ ≤ (eps + eps * |t|) + eps := add_le_add hb1' hterm3
    _ ≤ ε := hfinal

/-- The set `R(dom A)` is dense: every vector is approximated by `(A − i)⁻¹ w`
with `w` in the domain. -/
theorem exists_res_domain_approx (v : H) {ε : ℝ} (hε : 0 < ε) :
    ∃ w : T.domain, ‖v - T.resCLM 1 (w : H)‖ < ε := by
  obtain ⟨u, hu, hdu⟩ := T.denseDomain.exists_dist_lt v (by positivity : (0:ℝ) < ε / 2)
  obtain ⟨w, hw, hdw⟩ := T.denseDomain.exists_dist_lt (T.shift 1 ⟨u, hu⟩)
    (by positivity : (0:ℝ) < ε / 2)
  refine ⟨⟨w, hw⟩, ?_⟩
  have hures : T.resCLM 1 (T.shift 1 ⟨u, hu⟩) = u := by
    have := T.res_shift (l := 1) one_ne_zero ⟨u, hu⟩
    simpa using congrArg (fun (x : T.domain) => (x : H)) this
  have h1 : ‖u - T.resCLM 1 w‖ ≤ ‖T.shift 1 (⟨u, hu⟩ : T.domain) - w‖ := by
    have := T.norm_resCLM_apply_le 1 (T.shift 1 (⟨u, hu⟩ : T.domain) - w)
    rw [map_sub, hures] at this
    simpa using this
  have h2 : ‖v - u‖ < ε / 2 := by simpa [dist_eq_norm] using hdu
  have h3 : ‖T.shift 1 (⟨u, hu⟩ : T.domain) - w‖ < ε / 2 := by simpa [dist_eq_norm] using hdw
  calc ‖v - T.resCLM 1 w‖ ≤ ‖v - u‖ + ‖u - T.resCLM 1 w‖ := by
        simpa using norm_sub_le_norm_sub_add_norm_sub v u (T.resCLM 1 w)
    _ < ε / 2 + ε / 2 := by linarith
    _ = ε := by ring

/-- **Trotter–Kato, uniformly on bounded time intervals (§12 Gap 3, the unbounded
half).**  Strong resolvent convergence of the selected generators implies
convergence of their unitary flows, uniformly for `t` in `[−T₀, T₀]`. -/
theorem trotterKato_uniform_on_interval (hres : StrongResolventConvergence T S) (v : H)
    {T₀ : ℝ} (hT₀ : 0 ≤ T₀) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ t : ℝ, |t| ≤ T₀ → ‖(S n).stoneU t v - T.stoneU t v‖ ≤ ε := by
  obtain ⟨w, hw⟩ := exists_res_domain_approx T v (by positivity : (0:ℝ) < ε / 3)
  have hcore := trotterKato_uniform_of_mem_range T S hres w hT₀
    (by positivity : (0:ℝ) < ε / 3)
  filter_upwards [hcore] with n hn t ht
  have h1 : ‖(S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H))‖ ≤ ε / 3 := by
    rw [← map_sub, (S n).norm_stoneU_apply]
    exact le_of_lt hw
  have h3 : ‖T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v‖ ≤ ε / 3 := by
    rw [← map_sub, T.norm_stoneU_apply, norm_sub_rev]
    exact le_of_lt hw
  have h2 := hn t ht
  have hsplit : (S n).stoneU t v - T.stoneU t v
      = ((S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H)))
        + ((S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H)))
        + (T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v) := by abel
  calc ‖(S n).stoneU t v - T.stoneU t v‖
      ≤ ‖((S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H)))
          + ((S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H)))‖
        + ‖T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v‖ := by
        rw [hsplit]; exact norm_add_le _ _
    _ ≤ ‖(S n).stoneU t v - (S n).stoneU t (T.resCLM 1 (w : H))‖
        + ‖(S n).stoneU t (T.resCLM 1 (w : H)) - T.stoneU t (T.resCLM 1 (w : H))‖
        + ‖T.stoneU t (T.resCLM 1 (w : H)) - T.stoneU t v‖ := by
        gcongr
        exact norm_add_le _ _
    _ ≤ ε / 3 + ε / 3 + ε / 3 := by gcongr
    _ = ε := by ring

/-- **Trotter–Kato, strong form.**  At every fixed time the approximating flows
converge strongly to the flow of the limit generator. -/
theorem trotterKato_tendsto (hres : StrongResolventConvergence T S) (v : H) (t : ℝ) :
    Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by
  rw [Metric.tendsto_atTop]
  intro ε hε
  have h := trotterKato_uniform_on_interval T S hres v (abs_nonneg t)
    (by positivity : (0:ℝ) < ε / 2)
  rw [eventually_atTop] at h
  obtain ⟨N, hN⟩ := h
  refine ⟨N, fun n hn => ?_⟩
  have := hN n hn t le_rfl
  rw [dist_eq_norm]
  linarith

/-- **Trotter–Kato in `TendstoUniformlyOn` form.** -/
theorem trotterKato_tendstoUniformlyOn (hres : StrongResolventConvergence T S) (v : H)
    {T₀ : ℝ} (hT₀ : 0 ≤ T₀) :
    TendstoUniformlyOn (fun n t => (S n).stoneU t v) (fun t => T.stoneU t v) atTop
      (Set.Icc (-T₀) T₀) := by
  rw [Metric.tendstoUniformlyOn_iff]
  intro ε hε
  have h := trotterKato_uniform_on_interval T S hres v hT₀ (by positivity : (0:ℝ) < ε / 2)
  filter_upwards [h] with n hn t ht
  have habs : |t| ≤ T₀ := abs_le.mpr ⟨ht.1, ht.2⟩
  have := hn t habs
  rw [dist_eq_norm, norm_sub_rev]
  linarith

end BookProof.ChapterSirkTrotterKato

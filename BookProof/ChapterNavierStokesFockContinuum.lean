import Mathlib
import BookProof.ChapterNavierStokesFockEsa

/-!
# The continuum limit: the second-quantized Hamiltonian on a parcel sector

`BookProof.ChapterNavierStokesFockEsa` proves essential self-adjointness of the
transformed (Lagrangian) Navier–Stokes Hamiltonian on the Fock space of a Fock
space in the occupation-number representation, where the one-parcel symbol is
*diagonal* in the chosen mode basis.  The genuinely continuum situation is the
opposite one: the one-parcel operator is multiplication by a field `w` on the
parcel domain `Ω`, so it has **continuous spectrum** and no eigenvectors at all,
and the second-quantized Hamiltonian

`ĥ = ∫_Ω w(ξ) a†(ξ) a(ξ) dξ`

acts on the `n`-parcel sector `L²(Ωⁿ)` of the Fock space as multiplication by
the total energy `E(ξ₁,…,ξₙ) = ∑ₖ w(ξₖ)`.

This module proves essential self-adjointness in that situation.

* `boundedEnergyCore` — the core of states supported where the energy is
  bounded, together with `boundedEnergyCore_dense`: it is a dense domain.
* `multOp` — multiplication by a real measurable function on that core, with
  `multOp_isSymmetricDom`.
* `multOp_hasZeroDeficiencyOn` — **the headline: multiplication by an arbitrary
  real measurable function is essentially self-adjoint on the bounded-energy
  core.**  Unlike the occupation-number picture this covers operators with
  purely continuous spectrum.  The argument tests the deficiency identity
  against the truncations of `(g ∓ i)w` itself.
* `sectorEnergy`, `sectorHamiltonian_hasZeroDeficiencyOn` — the application: on
  the `n`-parcel sector of the continuum Fock space over the infinite continuous
  domain `ℝ`, the second-quantized Hamiltonian `∫ w(ξ)a†(ξ)a(ξ)dξ` — that is,
  multiplication by `∑ₖ w(ξₖ)` — is essentially self-adjoint.
-/

open MeasureTheory

namespace BookProof.NavierStokesFlow

namespace FockContinuum

open FullEsa

variable {X : Type*} [MeasurableSpace X]

/-! ## The bounded-energy core -/

/-- The states supported (almost everywhere) where the energy `g` is bounded:
the natural core of the multiplication operator. -/
def boundedEnergyCore (μ : Measure X) (g : X → ℝ) : Submodule ℂ (Lp ℂ 2 μ) where
  carrier := {f | ∃ n : ℕ, ∀ᵐ x ∂μ, ¬ (|g x| ≤ (n : ℝ)) → (f : X → ℂ) x = 0}
  add_mem' := by
    rintro f h ⟨n, hn⟩ ⟨m, hm⟩
    refine ⟨max n m, ?_⟩
    filter_upwards [hn, hm, Lp.coeFn_add f h] with x hx hy hadd hbig
    have hn' : ¬ (|g x| ≤ (n : ℝ)) := fun hle =>
      hbig (le_trans hle (by exact_mod_cast Nat.cast_le.2 (le_max_left n m)))
    have hm' : ¬ (|g x| ≤ (m : ℝ)) := fun hle =>
      hbig (le_trans hle (by exact_mod_cast Nat.cast_le.2 (le_max_right n m)))
    rw [hadd, Pi.add_apply, hx hn', hy hm', add_zero]
  zero_mem' := by
    refine ⟨0, ?_⟩
    filter_upwards [Lp.coeFn_zero (E := ℂ) (p := 2) (μ := μ)] with x hx _
    rw [hx]; rfl
  smul_mem' := by
    rintro c f ⟨n, hn⟩
    refine ⟨n, ?_⟩
    filter_upwards [hn, Lp.coeFn_smul c f] with x hx hsmul hbig
    rw [hsmul, Pi.smul_apply, hx hbig, smul_zero]

theorem mem_boundedEnergyCore {μ : Measure X} {g : X → ℝ} {f : Lp ℂ 2 μ} :
    f ∈ boundedEnergyCore μ g ↔ ∃ n : ℕ, ∀ᵐ x ∂μ, ¬ (|g x| ≤ (n : ℝ)) → (f : X → ℂ) x = 0 :=
  Iff.rfl

/-! ### The core is dense -/

/-- Truncating a state to the region where the energy is at most `n` converges
to the state in `L²`: the tail `∫_{|g|>n} |f|²` vanishes by dominated
convergence. -/
theorem tendsto_eLpNorm_indicator_compl (μ : Measure X) {g : X → ℝ} (hg : Measurable g)
    (f : Lp ℂ 2 μ) :
    Filter.Tendsto
      (fun n : ℕ => eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator ((f : X → ℂ))) 2 μ)
      Filter.atTop (nhds 0) := by
  have hmeasS : ∀ n : ℕ, MeasurableSet ({x | |g x| ≤ (n : ℝ)}ᶜ) :=
    fun n => (measurableSet_le hg.abs measurable_const).compl
  have hrw : ∀ n : ℕ, eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) 2 μ
      = (∫⁻ x, ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ) ∂μ)
          ^ (1 / (2 : ℝ)) := by
    intro n
    rw [eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num),
      show ((2 : ENNReal).toReal) = (2 : ℝ) by norm_num]
  simp_rw [hrw]
  have hlim : Filter.Tendsto
      (fun n : ℕ => ∫⁻ x, ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ) ∂μ)
      Filter.atTop (nhds 0) := by
    have hdom : ∀ n : ℕ,
        (fun x => ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ))
          ≤ᵐ[μ] fun x => ‖(f : X → ℂ) x‖ₑ ^ (2 : ℝ) := by
      intro n
      filter_upwards with x
      by_cases h : x ∈ ({x | |g x| ≤ (n : ℝ)}ᶜ)
      · rw [Set.indicator_of_mem h]
      · rw [Set.indicator_of_notMem h]; simp
    have hbdd : ∫⁻ x, ‖(f : X → ℂ) x‖ₑ ^ (2 : ℝ) ∂μ ≠ ⊤ := by
      intro hcon
      have h := Lp.eLpNorm_ne_top f
      rw [eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num)] at h
      apply h
      rw [show ((2 : ENNReal).toReal) = (2 : ℝ) by norm_num, hcon]
      exact ENNReal.top_rpow_of_pos (by positivity)
    have hae : ∀ᵐ x ∂μ, Filter.Tendsto
        (fun n : ℕ => ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ))
        Filter.atTop (nhds 0) := by
      filter_upwards with x
      obtain ⟨N, hN⟩ := exists_nat_ge |g x|
      refine Filter.Tendsto.congr' ?_ tendsto_const_nhds (f₁ := fun _ : ℕ => (0 : ENNReal))
      filter_upwards [Filter.eventually_ge_atTop N] with n hn
      have hx : x ∈ {x | |g x| ≤ (n : ℝ)} := le_trans hN (by exact_mod_cast hn)
      rw [Set.indicator_of_notMem (by simpa using hx)]
      simp
    have hdct := tendsto_lintegral_of_dominated_convergence' (μ := μ) (f := fun _ => (0 : ENNReal))
      (fun x => ‖(f : X → ℂ) x‖ₑ ^ (2 : ℝ))
      (fun n => (((Lp.aestronglyMeasurable f).indicator (hmeasS n)).enorm).pow_const _)
      hdom hbdd hae
    simpa using hdct
  simpa using ((ENNReal.continuous_rpow_const (y := 1 / (2 : ℝ))).tendsto 0).comp hlim

/-- **The bounded-energy core is dense.**  Every square-integrable state is the
`L²`-limit of its truncations to the regions where the energy is bounded, so the
core is a genuine dense domain for the multiplication operator. -/
theorem boundedEnergyCore_dense (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    Dense ((boundedEnergyCore μ g : Submodule ℂ (Lp ℂ 2 μ)) : Set (Lp ℂ 2 μ)) := by
  have hmeasS : ∀ n : ℕ, MeasurableSet {x | |g x| ≤ (n : ℝ)} :=
    fun n => measurableSet_le hg.abs measurable_const
  intro f
  refine mem_closure_iff_seq_limit.2
    ⟨fun n => ((Lp.memLp f).indicator (hmeasS n)).toLp _, fun n => ?_, ?_⟩
  · refine ⟨n, ?_⟩
    filter_upwards [((Lp.memLp f).indicator (hmeasS n)).coeFn_toLp] with x hx hbig
    rw [hx, Set.indicator_of_notMem (by simpa using hbig)]
  · have heq : ∀ n : ℕ,
        eLpNorm ({x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)) 2 μ
          = eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator ((f : X → ℂ))) 2 μ := by
      intro n
      have hfun : {x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)
          = -({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) := by
        funext x
        by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
        · simp [Set.indicator_of_mem h,
            Set.indicator_of_notMem (show x ∉ {x | |g x| ≤ (n : ℝ)}ᶜ by simpa using h)]
        · simp [Set.indicator_of_notMem h,
            Set.indicator_of_mem (show x ∈ {x | |g x| ≤ (n : ℝ)}ᶜ from h)]
      rw [hfun, eLpNorm_neg]
    have hten : Filter.Tendsto
        (fun n : ℕ => eLpNorm ({x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)) 2 μ)
        Filter.atTop (nhds 0) := by
      simp_rw [heq]
      exact tendsto_eLpNorm_indicator_compl μ hg f
    have h := (Lp.tendsto_Lp_iff_tendsto_eLpNorm''
      (fun n : ℕ => {x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ))
      (fun n => (Lp.memLp f).indicator (hmeasS n)) (f : X → ℂ) (Lp.memLp f)).2 hten
    rwa [Lp.toLp_coeFn] at h

/-- Multiplying a bounded-energy state by the energy stays square-integrable. -/
theorem memLp_mul {μ : Measure X} {g : X → ℝ} (hg : Measurable g) {f : Lp ℂ 2 μ}
    (hf : f ∈ boundedEnergyCore μ g) :
    MemLp (fun x => (g x : ℂ) * (f : X → ℂ) x) 2 μ := by
  obtain ⟨n, hn⟩ := hf
  have hmeas : AEStronglyMeasurable (fun x => (g x : ℂ) * (f : X → ℂ) x) μ :=
    (Complex.measurable_ofReal.comp hg).aestronglyMeasurable.mul (Lp.aestronglyMeasurable f)
  have hbound : ∀ᵐ x ∂μ, ‖(g x : ℂ) * (f : X → ℂ) x‖ ≤ ((n : ℝ)) * ‖(f : X → ℂ) x‖ := by
    filter_upwards [hn] with x hx
    by_cases h : |g x| ≤ (n : ℝ)
    · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_right h (norm_nonneg _)
    · rw [hx h]; simp
  exact MemLp.of_le_mul (Lp.memLp f) hmeas hbound

theorem mul_mem_boundedEnergyCore {μ : Measure X} {g : X → ℝ} (hg : Measurable g)
    {f : Lp ℂ 2 μ} (hf : f ∈ boundedEnergyCore μ g) :
    (memLp_mul hg hf).toLp _ ∈ boundedEnergyCore μ g := by
  obtain ⟨n, hn⟩ := hf
  refine ⟨n, ?_⟩
  filter_upwards [hn,
    (memLp_mul hg (⟨n, hn⟩ : f ∈ boundedEnergyCore μ g)).coeFn_toLp] with x hx hcoe hbig
  rw [hcoe, hx hbig, mul_zero]

/-- **Multiplication by a real measurable function** on the bounded-energy core:
the second-quantized Hamiltonian in the configuration representation. -/
noncomputable def multOp (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    boundedEnergyCore μ g →ₗ[ℂ] boundedEnergyCore μ g where
  toFun f := ⟨(memLp_mul hg f.2).toLp _, mul_mem_boundedEnergyCore hg f.2⟩
  map_add' f h := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_add]
    filter_upwards [(memLp_mul hg (show ((f : Lp ℂ 2 μ) + (h : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g
        from (f + h).2)).coeFn_toLp,
      (memLp_mul hg f.2).coeFn_toLp, (memLp_mul hg h.2).coeFn_toLp,
      Lp.coeFn_add ((f : Lp ℂ 2 μ)) ((h : Lp ℂ 2 μ)),
      Lp.coeFn_add ((memLp_mul hg f.2).toLp _) ((memLp_mul hg h.2).toLp _)] with x h1 h2 h3 h4 h5
    rw [h1, h5]
    simp only [Pi.add_apply]
    rw [h2, h3, h4]
    simp only [Pi.add_apply]
    ring
  map_smul' c f := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_smul, RingHom.id_apply]
    filter_upwards [(memLp_mul hg (show (c • (f : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g
        from (c • f).2)).coeFn_toLp,
      (memLp_mul hg f.2).coeFn_toLp, Lp.coeFn_smul c ((f : Lp ℂ 2 μ)),
      Lp.coeFn_smul c ((memLp_mul hg f.2).toLp _)] with x h1 h2 h3 h4
    rw [h1, h4]
    simp only [Pi.smul_apply, smul_eq_mul]
    rw [h2, h3]
    simp only [Pi.smul_apply, smul_eq_mul]
    ring

theorem multOp_coeFn (μ : Measure X) {g : X → ℝ} (hg : Measurable g)
    (f : boundedEnergyCore μ g) :
    (((multOp μ hg f : boundedEnergyCore μ g) : Lp ℂ 2 μ) : X → ℂ)
      =ᵐ[μ] fun x => (g x : ℂ) * ((f : Lp ℂ 2 μ) : X → ℂ) x :=
  (memLp_mul hg f.2).coeFn_toLp

/-- The multiplication operator is symmetric on the core. -/
theorem multOp_isSymmetricDom (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    IsSymmetricDom (multOp μ hg) := by
  intro x y
  rw [L2.inner_def, L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [multOp_coeFn μ hg x, multOp_coeFn μ hg y] with a hx hy
  simp only [RCLike.inner_apply, hx, hy, map_mul, Complex.conj_ofReal]
  ring

/-- Complex conjugation preserves square-integrability. -/
theorem memLp_conj {μ : Measure X} {F : X → ℂ} (h : MemLp F 2 μ) :
    MemLp (fun x => (starRingEnd ℂ) (F x)) 2 μ := by
  refine ⟨Complex.continuous_conj.comp_aestronglyMeasurable h.1, ?_⟩
  have heq : eLpNorm (fun x => (starRingEnd ℂ) (F x)) 2 μ = eLpNorm F 2 μ := by
    refine eLpNorm_congr_norm_ae ?_
    filter_upwards with x
    simp
  rw [heq]
  exact h.2

/-! ## Essential self-adjointness -/

/-- **Multiplication by a real measurable function is essentially self-adjoint on
the bounded-energy core.**  This is the continuum counterpart of the
occupation-number statement: the operator here has *no* eigenvectors in general
— its spectrum is the essential range of `g`, typically an interval — and it is
unbounded whenever `g` is. -/
theorem multOp_hasZeroDeficiencyOn (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    HasZeroDeficiencyOn (boundedEnergyCore μ g) (multOp μ hg) := by
  have key : ∀ c : ℂ, c.im ≠ 0 → ∀ w : Lp ℂ 2 μ,
      (∀ v : boundedEnergyCore μ g,
        (inner ℂ ((multOp μ hg v : boundedEnergyCore μ g) : Lp ℂ 2 μ) w : ℂ)
          = inner ℂ ((v : boundedEnergyCore μ g) : Lp ℂ 2 μ) (c • w)) → w = 0 := by
    intro c hc w hw
    set W : X → ℂ := fun x => ((g x : ℂ) - c) * ((w : X → ℂ) x) with hW
    have hmeasW : AEStronglyMeasurable W μ :=
      ((Complex.measurable_ofReal.comp hg).aestronglyMeasurable.sub
        aestronglyMeasurable_const).mul (Lp.aestronglyMeasurable w)
    have hzero : ∀ n : ℕ, ∀ᵐ x ∂μ, |g x| ≤ (n : ℝ) → W x = 0 := by
      intro n
      have hmeasS : MeasurableSet {x | |g x| ≤ (n : ℝ)} :=
        measurableSet_le hg.abs measurable_const
      set u : X → ℂ := Set.indicator {x | |g x| ≤ (n : ℝ)} W with hu
      have hmeasu : AEStronglyMeasurable u μ := hmeasW.indicator hmeasS
      have hbound : ∀ᵐ x ∂μ, ‖u x‖ ≤ ((n : ℝ) + ‖c‖) * ‖(w : X → ℂ) x‖ := by
        filter_upwards with x
        by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
        · have hgc : ‖((g x : ℂ) - c)‖ ≤ (n : ℝ) + ‖c‖ := by
            refine le_trans (norm_sub_le _ _) ?_
            have h1 : ‖((g x : ℂ))‖ ≤ (n : ℝ) := by
              rw [Complex.norm_real, Real.norm_eq_abs]; exact h
            linarith
          rw [hu, Set.indicator_of_mem h, hW, norm_mul]
          exact mul_le_mul_of_nonneg_right hgc (norm_nonneg _)
        · rw [hu, Set.indicator_of_notMem h, norm_zero]
          positivity
      have humem : MemLp u 2 μ := MemLp.of_le_mul (Lp.memLp w) hmeasu hbound
      have hucore : humem.toLp u ∈ boundedEnergyCore μ g := by
        refine ⟨n, ?_⟩
        filter_upwards [humem.coeFn_toLp] with x hx hbig
        rw [hx, hu, Set.indicator_of_notMem (by simpa using hbig)]
      have hid := hw ⟨humem.toLp u, hucore⟩
      have hleft : (inner ℂ ((multOp μ hg ⟨humem.toLp u, hucore⟩ : boundedEnergyCore μ g) :
          Lp ℂ 2 μ) w : ℂ)
          = ∫ x, (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x ∂μ := by
        rw [L2.inner_def]
        refine integral_congr_ae ?_
        filter_upwards [multOp_coeFn μ hg ⟨humem.toLp u, hucore⟩, humem.coeFn_toLp] with x h1 h2
        simp only [RCLike.inner_apply, h1, h2]
        ring
      have hright : (inner ℂ ((⟨humem.toLp u, hucore⟩ : boundedEnergyCore μ g) : Lp ℂ 2 μ)
          (c • w) : ℂ) = ∫ x, (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x) ∂μ := by
        rw [L2.inner_def]
        refine integral_congr_ae ?_
        filter_upwards [humem.coeFn_toLp, Lp.coeFn_smul c w] with x h1 h2
        simp only [RCLike.inner_apply, h1, h2, Pi.smul_apply, smul_eq_mul]
        ring
      rw [hleft, hright] at hid
      have hcombine : ∫ x, ‖u x‖ ^ 2 ∂μ = 0 := by
        have hintegrand : ∀ x, (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x
            - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)
            = ((‖u x‖ ^ 2 : ℝ) : ℂ) := by
          intro x
          by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
          · have hux : u x = ((g x : ℂ) - c) * ((w : X → ℂ) x) := by
              rw [hu, Set.indicator_of_mem h]
            have hconj : (starRingEnd ℂ) (u x) * u x = ((‖u x‖ ^ 2 : ℝ) : ℂ) := by
              have hmc := Complex.mul_conj' (u x)
              push_cast
              linear_combination hmc
            calc (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x
                  - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)
                = (starRingEnd ℂ) (u x) * (((g x : ℂ) - c) * (w : X → ℂ) x) := by
                  simp only [map_mul, Complex.conj_ofReal]
                  ring
              _ = (starRingEnd ℂ) (u x) * u x := by rw [hux]
              _ = ((‖u x‖ ^ 2 : ℝ) : ℂ) := hconj
          · rw [hu, Set.indicator_of_notMem h]
            simp
        have hzeroint : ∫ x, (((‖u x‖ ^ 2 : ℝ)) : ℂ) ∂μ = 0 := by
          have hint1 : Integrable
              (fun x => (starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x) μ := by
            have h1 : MemLp (fun x => (g x : ℂ) * u x) 2 μ := by
              have hb : ∀ᵐ x ∂μ, ‖(g x : ℂ) * u x‖ ≤ (n : ℝ) * ‖u x‖ := by
                filter_upwards with x
                by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
                · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
                  exact mul_le_mul_of_nonneg_right h (norm_nonneg _)
                · rw [hu, Set.indicator_of_notMem h]
                  simp
              exact MemLp.of_le_mul humem
                ((Complex.measurable_ofReal.comp hg).aestronglyMeasurable.mul hmeasu) hb
            simpa using MemLp.integrable_mul (memLp_conj h1) (Lp.memLp w)
          have hint2 : Integrable
              (fun x => (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)) μ := by
            simpa using MemLp.integrable_mul (memLp_conj humem) ((Lp.memLp w).const_mul c)
          have hsub : ∫ x, ((starRingEnd ℂ) ((g x : ℂ) * u x) * (w : X → ℂ) x
              - (starRingEnd ℂ) (u x) * (c * (w : X → ℂ) x)) ∂μ = 0 := by
            rw [integral_sub hint1 hint2, ← hid, sub_self]
          rw [← hsub]
          exact integral_congr_ae (Filter.Eventually.of_forall fun x => (hintegrand x).symm)
        have hre := congrArg Complex.re hzeroint
        rw [integral_complex_ofReal] at hre
        simpa using hre
      have hnn : 0 ≤ fun x => ‖u x‖ ^ 2 := fun x => by positivity
      have hintu : Integrable (fun x => ‖u x‖ ^ 2) μ := by
        have := humem.integrable_norm_rpow (by norm_num) (by norm_num)
        simpa [Real.rpow_natCast] using this
      have hae := (integral_eq_zero_iff_of_nonneg hnn hintu).1 hcombine
      filter_upwards [hae] with x hx hbig
      have hu0 : u x = 0 := by
        have hnorm : ‖u x‖ ^ 2 = 0 := hx
        simpa [pow_eq_zero_iff] using hnorm
      rw [← hu0, hu, Set.indicator_of_mem (show x ∈ {x | |g x| ≤ (n : ℝ)} from hbig)]
    have hWzero : ∀ᵐ x ∂μ, W x = 0 := by
      have hall : ∀ᵐ x ∂μ, ∀ n : ℕ, |g x| ≤ (n : ℝ) → W x = 0 := ae_all_iff.2 hzero
      filter_upwards [hall] with x hx
      obtain ⟨n, hn⟩ := exists_nat_ge |g x|
      exact hx n hn
    refine Lp.ext ?_
    filter_upwards [hWzero, Lp.coeFn_zero (E := ℂ) (p := 2) (μ := μ)] with x hx hz
    rw [hz]
    have hne : ((g x : ℂ) - c) ≠ 0 := by
      intro h
      have him := congrArg Complex.im h
      simp only [Complex.sub_im, Complex.ofReal_im, zero_sub, Complex.zero_im,
        neg_eq_zero] at him
      exact hc him
    exact (mul_eq_zero.1 hx).resolve_left hne
  refine ⟨fun w hw => key Complex.I (by simp) w ?_, fun w hw => key (-Complex.I) (by simp) w ?_⟩
  · intro v; exact hw v
  · intro v; rw [neg_smul]; exact hw v

/-! ## The `n`-parcel sector of the continuum Fock space -/

section Sector

/-- The total energy of an `n`-parcel configuration `(ξ₁,…,ξₙ)` of the continuum
Fock space, for the one-parcel field `w` on the parcel domain `ℝ`:
`E(ξ) = ∑ₖ w(ξₖ)`.  This is how the second-quantized Hamiltonian
`∫ w(ξ) a†(ξ)a(ξ) dξ` acts on the `n`-parcel sector. -/
noncomputable def sectorEnergy (w : ℝ → ℝ) (n : ℕ) : (Fin n → ℝ) → ℝ :=
  fun ξ => ∑ k : Fin n, w (ξ k)

theorem sectorEnergy_measurable {w : ℝ → ℝ} (hw : Measurable w) (n : ℕ) :
    Measurable (sectorEnergy w n) :=
  Finset.univ.measurable_sum fun k _ => hw.comp (measurable_pi_apply k)

/-- **The second-quantized Hamiltonian is essentially self-adjoint on each parcel
sector of the continuum Fock space.**  On the `n`-parcel sector `L²(ℝⁿ)` the
operator `∫_ℝ w(ξ) a†(ξ) a(ξ) dξ` is multiplication by the total energy
`∑ₖ w(ξₖ)`, an operator with (in general) purely continuous spectrum and no
eigenvectors; it has vanishing adjoint deficiency on the bounded-energy core. -/
theorem sectorHamiltonian_hasZeroDeficiencyOn {w : ℝ → ℝ} (hw : Measurable w) (n : ℕ) :
    HasZeroDeficiencyOn
      (boundedEnergyCore (volume : Measure (Fin n → ℝ)) (sectorEnergy w n))
      (multOp (volume : Measure (Fin n → ℝ)) (sectorEnergy_measurable hw n)) :=
  multOp_hasZeroDeficiencyOn _ _

/-- The same statement for the one-parcel sector `L²(ℝ)`, where the operator is
multiplication by the field `w` itself. -/
theorem oneParcelHamiltonian_hasZeroDeficiencyOn {w : ℝ → ℝ} (hw : Measurable w) :
    HasZeroDeficiencyOn (boundedEnergyCore (volume : Measure ℝ) w) (multOp volume hw) :=
  multOp_hasZeroDeficiencyOn _ _

end Sector

end FockContinuum

end BookProof.NavierStokesFlow

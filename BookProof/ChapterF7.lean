import Mathlib

/-!
# Chapter F7 — Quantum Flow Matching: the concrete `x̂` / `p̂` model (roadmap N14, §4)

This file supplies the concrete function-space realization underlying the
algebraic Hermiticity cores of `ChapterF5.lean` (deliverables **F2.1** and
**F2.2** of the *Quantum Flow Matching* package; source `RiemannProof/QFM.tex`
§4, eqs. (4.2)–(4.6); reference implementation `../unfer/qfm/`).  It follows
§0 S7 of the roadmap (the Mehler/Kopperman generative flow).

The state space is the Schwartz space `𝓢(ℝ, ℂ)` with the (sesquilinear) `L²`
pairing `⟪f, g⟫ = ∫ conj (f x) · g x`.  On this dense domain the two elementary
observables of eq. (4.2) are:

* **position** `(x̂ Ψ)(x) = x · Ψ(x)` — multiplication by the real coordinate;
* **momentum** `(p̂ Ψ)(x) = −i Ψ′(x)` — the derivative operator.

## Deliverables

* `l2pair` — the `L²` pairing, together with its (conjugate-)bilinearity
  (`l2pair_add_left/right`, `l2pair_sub_left/right`, `l2pair_smul_left/right`)
  and the integrability helper `l2pair_integrable`.
* `IsL2Symmetric` — symmetry of an operator w.r.t. `l2pair`.
* **position is symmetric** (`position_l2Symmetric`), and more generally
  multiplication by any real function of temperate growth — the concrete
  velocity/potential operator `v(x̂)` — is symmetric (`mulOp_l2Symmetric`).
* **momentum is symmetric** (`momentum_l2Symmetric`), the concrete
  integration-by-parts fact `schwartz_integration_by_parts` (`∫ f′ g = −∫ f g′`
  for Schwartz `f, g`, boundary terms vanishing).
* **F2.1 concretely** (§4 eq. 4.2): the symmetrized product of two symmetric
  operators is symmetric (`anticomm_l2Symmetric`), hence the continuity
  Hamiltonian `H = ½(p̂ v(x̂) + v(x̂) p̂)` is Hermitian
  (`continuityHamiltonian_l2Symmetric`).
* **F2.2 concretely** (§4 eqs. 4.4–4.6): `i·[K, V]` is symmetric when `K, V`
  are (`i_comm_l2Symmetric`); with `K = ½ p̂·p̂` (`kinetic_l2Symmetric`) this is
  the conservative continuity Hamiltonian `H^c = i[K, V(x̂)]`
  (`conservativeHamiltonian_l2Symmetric`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.  Cites `../unfer` crate
`qfm/src/potential.rs` (the Hermitian continuity generator).
-/

open SchwartzMap MeasureTheory Complex
open scoped BigOperators

namespace BookProof.ChapterF7

noncomputable section

/-! ## The `L²` pairing -/

/-- The sesquilinear `L²` pairing on Schwartz space (conjugate-linear in the
first slot): `⟪f, g⟫ = ∫ conj (f x) · g x`. -/
def l2pair (f g : 𝓢(ℝ, ℂ)) : ℂ := ∫ x, (starRingEnd ℂ) (f x) * g x

/-- The `L²` integrand `conj (f x) · g x` is integrable: `conj ∘ f` is bounded
(a Schwartz function is bounded) and `g` is integrable. -/
theorem l2pair_integrable (f g : 𝓢(ℝ, ℂ)) :
    Integrable (fun x => (starRingEnd ℂ) (f x) * g x) volume := by
  obtain ⟨C, _, hC⟩ := f.decay 0 0
  refine (g.integrable (μ := volume)).bdd_mul (c := C)
    ((Complex.continuous_conj.comp f.continuous).aestronglyMeasurable) ?_
  exact Filter.Eventually.of_forall (fun x => by simpa using hC x)

theorem l2pair_add_left (f₁ f₂ g : 𝓢(ℝ, ℂ)) :
    l2pair (f₁ + f₂) g = l2pair f₁ g + l2pair f₂ g := by
  unfold l2pair
  rw [← integral_add (l2pair_integrable f₁ g) (l2pair_integrable f₂ g)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.add_apply, map_add]
  ring

theorem l2pair_add_right (f g₁ g₂ : 𝓢(ℝ, ℂ)) :
    l2pair f (g₁ + g₂) = l2pair f g₁ + l2pair f g₂ := by
  unfold l2pair
  rw [← integral_add (l2pair_integrable f g₁) (l2pair_integrable f g₂)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.add_apply]
  ring

theorem l2pair_sub_left (f₁ f₂ g : 𝓢(ℝ, ℂ)) :
    l2pair (f₁ - f₂) g = l2pair f₁ g - l2pair f₂ g := by
  unfold l2pair
  rw [← integral_sub (l2pair_integrable f₁ g) (l2pair_integrable f₂ g)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.sub_apply, map_sub]
  ring

theorem l2pair_sub_right (f g₁ g₂ : 𝓢(ℝ, ℂ)) :
    l2pair f (g₁ - g₂) = l2pair f g₁ - l2pair f g₂ := by
  unfold l2pair
  rw [← integral_sub (l2pair_integrable f g₁) (l2pair_integrable f g₂)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.sub_apply]
  ring

theorem l2pair_smul_left (c : ℂ) (f g : 𝓢(ℝ, ℂ)) :
    l2pair (c • f) g = (starRingEnd ℂ) c * l2pair f g := by
  unfold l2pair
  rw [← integral_const_mul]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.smul_apply, smul_eq_mul, map_mul]
  ring

theorem l2pair_smul_right (c : ℂ) (f g : 𝓢(ℝ, ℂ)) :
    l2pair f (c • g) = c * l2pair f g := by
  unfold l2pair
  rw [← integral_const_mul]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [SchwartzMap.smul_apply, smul_eq_mul]
  ring

/-- An operator on Schwartz space is **`L²`-symmetric** (Hermitian on the dense
Schwartz domain) if it moves across the `L²` pairing. -/
def IsL2Symmetric (T : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ)) : Prop :=
  ∀ f g, l2pair (T f) g = l2pair f (T g)

/-! ## Position and, more generally, real multiplication operators -/

/-- Multiplication by a real function `v` of temperate growth — the concrete
velocity/potential operator `v(x̂)`, `(v(x̂) Ψ)(x) = v(x) · Ψ(x)`. -/
def mulOp (v : ℝ → ℝ) (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  SchwartzMap.bilinLeftCLM (ContinuousLinearMap.mul ℂ ℂ) hv

@[simp] theorem mulOp_apply (v : ℝ → ℝ)
    (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    (mulOp v hv f) x = f x * (v x : ℂ) := by
  simp [mulOp, SchwartzMap.bilinLeftCLM_apply]

/-- **Concrete F2.1 building block.** Multiplication by a real function is
`L²`-symmetric: `⟪v(x̂) f, g⟫ = ⟪f, v(x̂) g⟫`, because `conj (v x) = v x`. -/
theorem mulOp_l2Symmetric (v : ℝ → ℝ)
    (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    IsL2Symmetric (mulOp v hv) := by
  intro f g
  unfold l2pair
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [mulOp_apply, map_mul, Complex.conj_ofReal]
  ring

/-- The position operator `(x̂ Ψ)(x) = x · Ψ(x)`. -/
def position : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  mulOp (fun x => x) Function.Complex.hasTemperateGrowth_ofReal

/-- **Position is `L²`-symmetric** (the special case `v = id` of
`mulOp_l2Symmetric`). -/
theorem position_l2Symmetric : IsL2Symmetric position :=
  mulOp_l2Symmetric _ _

/-! ## Momentum and integration by parts -/

/-- **Integration by parts for Schwartz functions** (boundary terms vanish):
`∫ (conj f)′ · g = −∫ (conj f) · g′`, written with the pointwise derivatives.
This is the analytic heart of momentum symmetry. -/
theorem schwartz_integration_by_parts (f g : 𝓢(ℝ, ℂ)) :
    (∫ x, (starRingEnd ℂ) (deriv (f : ℝ → ℂ) x) * g x)
      = - ∫ x, (starRingEnd ℂ) (f x) * deriv (g : ℝ → ℂ) x := by
  have hcdf : Continuous (fun x => (starRingEnd ℂ) (deriv (f : ℝ → ℂ) x)) := by
    have h : (fun x => (starRingEnd ℂ) (deriv (f : ℝ → ℂ) x))
        = fun x => (starRingEnd ℂ) ((SchwartzMap.derivCLM ℝ ℂ f) x) := by
      funext x; rw [SchwartzMap.derivCLM_apply]
    rw [h]; exact Complex.continuous_conj.comp (SchwartzMap.derivCLM ℝ ℂ f).continuous
  have hdu : ∀ x, HasDerivAt (fun t => (starRingEnd ℂ) (f t))
      ((starRingEnd ℂ) (deriv (f : ℝ → ℂ) x)) x := by
    intro x
    simpa using (f.differentiableAt.hasDerivAt (x := x)).star
  have hdv : ∀ x, HasDerivAt (g : ℝ → ℂ) (deriv (g : ℝ → ℂ) x) x :=
    fun x => g.differentiableAt.hasDerivAt
  have h1 : Integrable (fun x => (starRingEnd ℂ) (deriv (f : ℝ → ℂ) x) * g x) volume := by
    obtain ⟨C, _, hC⟩ := (SchwartzMap.derivCLM ℝ ℂ f).decay 0 0
    refine (g.integrable (μ := volume)).bdd_mul (c := C) hcdf.aestronglyMeasurable ?_
    refine Filter.Eventually.of_forall (fun x => ?_)
    have hh : ‖(starRingEnd ℂ) (deriv (f : ℝ → ℂ) x)‖ = ‖(SchwartzMap.derivCLM ℝ ℂ f) x‖ := by
      rw [SchwartzMap.derivCLM_apply]; simp
    rw [hh]; simpa using hC x
  have h2 : Integrable (fun x => (starRingEnd ℂ) (f x) * deriv (g : ℝ → ℂ) x) volume := by
    obtain ⟨C, _, hC⟩ := f.decay 0 0
    have hig : Integrable (fun x => deriv (g : ℝ → ℂ) x) volume := by
      refine (SchwartzMap.derivCLM ℝ ℂ g).integrable.congr
        (Filter.Eventually.of_forall fun x => ?_)
      rw [SchwartzMap.derivCLM_apply]
    refine hig.bdd_mul (c := C)
      (Complex.continuous_conj.comp f.continuous).aestronglyMeasurable ?_
    exact Filter.Eventually.of_forall (fun x => by simpa using hC x)
  have hbot : Filter.Tendsto ((fun t => (starRingEnd ℂ) (f t)) * (g : ℝ → ℂ))
      Filter.atBot (nhds 0) := by
    have huc : Filter.Tendsto (fun t => (starRingEnd ℂ) (f t)) Filter.atBot (nhds 0) := by
      have := (Complex.continuous_conj.tendsto (0 : ℂ)).comp
        (f.tendsto_cocompact.mono_left atBot_le_cocompact)
      simpa [Function.comp] using this
    have hvc : Filter.Tendsto (g : ℝ → ℂ) Filter.atBot (nhds 0) :=
      g.tendsto_cocompact.mono_left atBot_le_cocompact
    simpa using huc.mul hvc
  have htop : Filter.Tendsto ((fun t => (starRingEnd ℂ) (f t)) * (g : ℝ → ℂ))
      Filter.atTop (nhds 0) := by
    have huc : Filter.Tendsto (fun t => (starRingEnd ℂ) (f t)) Filter.atTop (nhds 0) := by
      have := (Complex.continuous_conj.tendsto (0 : ℂ)).comp
        (f.tendsto_cocompact.mono_left atTop_le_cocompact)
      simpa [Function.comp] using this
    have hvc : Filter.Tendsto (g : ℝ → ℂ) Filter.atTop (nhds 0) :=
      g.tendsto_cocompact.mono_left atTop_le_cocompact
    simpa using huc.mul hvc
  have key := integral_deriv_mul_eq_sub hdu hdv (h1.add h2) hbot htop
  simp only [sub_self] at key
  rw [integral_add h1 h2] at key
  exact eq_neg_of_add_eq_zero_left key

/-- The momentum operator `(p̂ Ψ)(x) = −i Ψ′(x)`. -/
def momentum : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  (-Complex.I) • SchwartzMap.derivCLM ℂ ℂ

@[simp] theorem momentum_apply (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    (momentum f) x = -Complex.I * deriv (f : ℝ → ℂ) x := by
  simp [momentum, SchwartzMap.derivCLM_apply]

/-- **Momentum is `L²`-symmetric.**  With `⟪p̂ f, g⟫ = i ∫ conj(f′) g` and
`⟪f, p̂ g⟫ = −i ∫ conj(f) g′`, integration by parts (`∫ conj(f′) g =
−∫ conj(f) g′`) makes the two equal. -/
theorem momentum_l2Symmetric : IsL2Symmetric momentum := by
  intro f g
  have hL : l2pair (momentum f) g
      = Complex.I * ∫ x, (starRingEnd ℂ) (deriv (f : ℝ → ℂ) x) * g x := by
    unfold l2pair
    rw [← integral_const_mul]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [momentum_apply, map_mul, map_neg, Complex.conj_I]
    ring
  have hR : l2pair f (momentum g)
      = (-Complex.I) * ∫ x, (starRingEnd ℂ) (f x) * deriv (g : ℝ → ℂ) x := by
    unfold l2pair
    rw [← integral_const_mul]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp only [momentum_apply]
    ring
  rw [hL, hR, schwartz_integration_by_parts]
  ring

/-! ## F2.1 and F2.2 concretely -/

/-- **F2.1 (concrete, §4 eq. 4.2).**  The symmetrized product (anticommutator)
of two `L²`-symmetric operators is `L²`-symmetric — no commutation needed.  This
is the structural reason the continuity Hamiltonian `H = ½(p̂ v + v p̂)` is
Hermitian. -/
theorem anticomm_l2Symmetric {K V : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ)}
    (hK : IsL2Symmetric K) (hV : IsL2Symmetric V) :
    IsL2Symmetric (K.comp V + V.comp K) := by
  intro f g
  simp only [ContinuousLinearMap.add_apply, ContinuousLinearMap.comp_apply]
  rw [l2pair_add_left, l2pair_add_right, hK, hV, hV, hK]
  ring

/-- A real (self-conjugate) scalar multiple of an `L²`-symmetric operator is
`L²`-symmetric. -/
theorem smul_l2Symmetric {c : ℂ} (hc : (starRingEnd ℂ) c = c)
    {T : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ)} (hT : IsL2Symmetric T) :
    IsL2Symmetric (c • T) := by
  intro f g
  simp only [ContinuousLinearMap.smul_apply]
  rw [l2pair_smul_left, l2pair_smul_right, hc, hT]

/-- **Continuity Hamiltonian Hermiticity (F2.1, §4 eq. 4.2).**  For a real
velocity field `v` of temperate growth, the symmetrized continuity Hamiltonian
`H = ½(p̂ v(x̂) + v(x̂) p̂)` is `L²`-symmetric (Hermitian on the Schwartz
domain). -/
theorem continuityHamiltonian_l2Symmetric (v : ℝ → ℝ)
    (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    IsL2Symmetric
      (((1 : ℂ) / 2) • (momentum.comp (mulOp v hv) + (mulOp v hv).comp momentum)) := by
  refine smul_l2Symmetric (by simp only [map_div₀, map_one, map_ofNat])
    (anticomm_l2Symmetric momentum_l2Symmetric (mulOp_l2Symmetric v hv))

/-- **F2.2 (concrete, §4 eqs. 4.4–4.6).**  `i·[K, V] = i·(K V − V K)` is
`L²`-symmetric whenever `K` and `V` are: the commutator of symmetric operators
is skew-symmetric, and the factor `i` restores symmetry. -/
theorem i_comm_l2Symmetric {K V : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ)}
    (hK : IsL2Symmetric K) (hV : IsL2Symmetric V) :
    IsL2Symmetric (Complex.I • (K.comp V - V.comp K)) := by
  intro f g
  simp only [ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    ContinuousLinearMap.comp_apply]
  rw [l2pair_smul_left, l2pair_smul_right, Complex.conj_I,
    l2pair_sub_left, l2pair_sub_right, hK, hV, hV, hK]
  ring

/-- The kinetic operator `K = ½ p̂·p̂`, `(K Ψ)(x) = −½ Ψ″(x)`. -/
def kinetic : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  ((1 : ℂ) / 2) • momentum.comp momentum

/-- The kinetic operator is `L²`-symmetric: a self-composition of a symmetric
operator is symmetric, and the real factor `½` preserves symmetry. -/
theorem kinetic_l2Symmetric : IsL2Symmetric kinetic := by
  refine smul_l2Symmetric (by simp only [map_div₀, map_one, map_ofNat]) ?_
  intro f g
  simp only [ContinuousLinearMap.comp_apply]
  rw [momentum_l2Symmetric, momentum_l2Symmetric]

/-- **Conservative continuity Hamiltonian Hermiticity (F2.2, §4 eq. 4.4).**  For
a real potential `V` of temperate growth, the conservative continuity
Hamiltonian `H^c = i[K, V(x̂)]` with `K = ½ p̂·p̂` is `L²`-symmetric. -/
theorem conservativeHamiltonian_l2Symmetric (V : ℝ → ℝ)
    (hV : Function.HasTemperateGrowth (fun x => (V x : ℂ))) :
    IsL2Symmetric (Complex.I • (kinetic.comp (mulOp V hV) - (mulOp V hV).comp kinetic)) :=
  i_comm_l2Symmetric kinetic_l2Symmetric (mulOp_l2Symmetric V hV)

end

end BookProof.ChapterF7

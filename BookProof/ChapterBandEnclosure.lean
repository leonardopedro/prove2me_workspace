import Mathlib
import BookProof.ChapterFockOneParticleGap
import BookProof.ChapterFriedrichsFormGap
import BookProof.ChapterH8

/-!
# Chapter BandEnclosure — the band-enclosure hypothesis, derived

`CONSOLIDATED_PLAN.md` (top work package, "Hashimoto observable to the real-Hamiltonian
gap") left exactly one hypothesis of `BookProof.FockOneParticleGap` underived: the
**band enclosure**

  `∀ m, lam ∈ Set.Icc (lo m) (hi m)`,

i.e. that every finite certificate brackets the one-particle spectral edge `lam` of the
*infinite* selected operator.  In `ChapterFockOneParticleGap` that was an assumption.
This chapter derives it from material that is already proved in the project:

* **band nesting** — the order-`m+1` band sits inside the order-`m` band
  (`ChapterH8.sirk_band_contained`, `sirk_band_contained_le`; abstracted here as
  `NestedBands`);
* **exponential shrinking** — the band widths decay like `e^{−hm}` and hence vanish
  (`ChapterH6.sirk_error_decay_exponential`), so the nested bands collapse to one point;
* **Hashimoto selects the Friedrichs extension, and its Ritz values converge to the edge
  of the selected operator** — `HermiteGalerkin.finiteModeRestrict_selects_operator` and
  `ChapterSirkRitzSpectrum.ritzInf_tendsto_sInf_spectrum`.

The logical skeleton is `band_enclosure_of_nested`: if the order-`m` *approximant* lies in
the order-`m` band, the bands nest, and the approximants converge to `lam`, then `lam` lies
in **every** band — because for `n ≥ m` the approximant `a n` already lies in the order-`m`
band, which is closed.  Feeding the Hashimoto/Galerkin Ritz values in as the approximants
and the Ritz convergence theorem in as the convergence, the enclosed point is
`sInf (spectrum ℝ A)`, the spectral edge of the operator the algorithm selects.

## Deliverables

* `NestedBands`, `nestedBands_le` — nesting of the certified intervals, iterated;
* `band_enclosure_of_nested` — **the band-enclosure hypothesis, derived** from nesting and
  convergence of the approximants;
* `band_limit_unique`, `band_enclosure_endpoints_tendsto` — with vanishing widths the
  nested bands determine a *unique* limiting edge and their endpoints converge to it;
* `sirk_nestedBands`, `sirk_band_widths_tendsto_zero`, `sirk_band_enclosure` — the
  instance carried by the already-proved SIRK band theorems (nesting from
  `ChapterH8.sirk_band_contained`, exponential collapse from
  `ChapterH6.sirk_error_decay_exponential`);
* `ritz_band_enclosure_of_nested` — **the enclosure for the selected operator**: nested
  certified bands that contain the Hashimoto/Galerkin Ritz values enclose
  `sInf (spectrum ℝ A)` of the operator the algorithm selects;
* `fock_mass_gap_of_nested_ritz_bands` — the composition with the free `dΓ` lift of
  `ChapterFockOneParticleGap`: **no enclosure hypothesis is assumed any more** in the
  bounded selected-operator regime;
* `shiftInvert_band_enclosure`, `shiftInvert_widths_tendsto_zero` — the transport of a
  band enclosure through the Hashimoto shift-invert `lam = nu⁻¹ − γ`, for the unbounded
  (resolvent) route.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

open Filter Topology

namespace BookProof.BandEnclosure

open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8

/-! ## 1. Nested bands -/

/-- The certified intervals **nest**: the order-`m+1` band is contained in the order-`m`
band.  This is the abstract form of `ChapterH8.sirk_band_contained`. -/
def NestedBands (lo hi : ℕ → ℝ) : Prop :=
  ∀ m, Set.Icc (lo (m + 1)) (hi (m + 1)) ⊆ Set.Icc (lo m) (hi m)

/-- Nesting iterated: for `m ≤ n` the order-`n` band sits inside the order-`m` band. -/
theorem nestedBands_le {lo hi : ℕ → ℝ} (h : NestedBands lo hi) {m n : ℕ} (hmn : m ≤ n) :
    Set.Icc (lo n) (hi n) ⊆ Set.Icc (lo m) (hi m) := by
  induction n, hmn using Nat.le_induction with
  | base => exact subset_rfl
  | succ n _ ih => exact (h n).trans ih

/-! ## 2. The band-enclosure hypothesis, derived -/

/-- **The band-enclosure theorem.**  Let the certified bands nest, let the order-`m`
approximant `a m` lie in the order-`m` band (which is what a finite certificate asserts),
and let the approximants converge to `lam` (which is what the Hashimoto/Friedrichs
selection plus Ritz convergence provide).  Then `lam` — the edge of the *infinite* selected
operator — lies in **every** certified band.

This is the hypothesis `hband` of `FockOneParticleGap.fock_mass_gap_of_certified_bands`,
now a conclusion. -/
theorem band_enclosure_of_nested {lo hi a : ℕ → ℝ} {lam : ℝ}
    (hnest : NestedBands lo hi) (hmem : ∀ m, a m ∈ Set.Icc (lo m) (hi m))
    (hconv : Tendsto a atTop (𝓝 lam)) :
    ∀ m, lam ∈ Set.Icc (lo m) (hi m) := by
  intro m
  have hev : ∀ᶠ n in atTop, a n ∈ Set.Icc (lo m) (hi m) := by
    filter_upwards [eventually_ge_atTop m] with n hn
    exact nestedBands_le hnest hn (hmem n)
  exact ⟨ge_of_tendsto hconv (hev.mono fun _ hn => hn.1),
    le_of_tendsto hconv (hev.mono fun _ hn => hn.2)⟩

/-- **The nested bands determine a unique point** once their widths vanish: two numbers
enclosed by all of them are equal.  (Exponentially shrinking widths, as in
`ChapterH6.sirk_error_decay_exponential`, are the intended source of `hwidth`.) -/
theorem band_limit_unique {lo hi : ℕ → ℝ} {lam lam' : ℝ}
    (h : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) (h' : ∀ m, lam' ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    lam = lam' := by
  have habs : ∀ m, |lam - lam'| ≤ hi m - lo m := by
    intro m
    rw [abs_sub_le_iff]
    exact ⟨by linarith [(h m).2, (h' m).1], by linarith [(h' m).2, (h m).1]⟩
  have hle : |lam - lam'| ≤ 0 :=
    ge_of_tendsto hwidth (Filter.Eventually.of_forall habs)
  have : lam - lam' = 0 := by
    have := abs_nonneg (lam - lam')
    have h0 : |lam - lam'| = 0 := le_antisymm hle this
    exact abs_eq_zero.mp h0
  linarith

/-- **The full nested-band conclusion, with the enclosure derived.**  Nesting, a certificate
at every order, convergence of the approximants and vanishing widths give: the edge `lam`
of the infinite selected operator lies in every band, it is the unique such point, and the
certified endpoints converge to it. -/
theorem band_enclosure_endpoints_tendsto {lo hi a : ℕ → ℝ} {lam : ℝ}
    (hnest : NestedBands lo hi) (hmem : ∀ m, a m ∈ Set.Icc (lo m) (hi m))
    (hconv : Tendsto a atTop (𝓝 lam))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    (∀ m, lam ∈ Set.Icc (lo m) (hi m)) ∧
      (∀ lam', (∀ m, lam' ∈ Set.Icc (lo m) (hi m)) → lam' = lam) ∧
      Tendsto lo atTop (𝓝 lam) ∧ Tendsto hi atTop (𝓝 lam) := by
  have hband := band_enclosure_of_nested hnest hmem hconv
  exact ⟨hband, fun lam' h' => band_limit_unique h' hband hwidth,
    (band_endpoints_tendsto hband hwidth).1, (band_endpoints_tendsto hband hwidth).2⟩

/-! ## 3. The SIRK bands are an instance: nesting and exponential collapse -/

/-- The already-proved SIRK error bands `[0, sirkBound m]` are nested
(`ChapterH8.sirk_band_contained`). -/
theorem sirk_nestedBands (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    NestedBands (fun _ => (0 : ℝ)) (fun m => sirkBound C Dmin h nv m) :=
  fun m => sirk_band_contained C Dmin h nv hC hD hnv hh m

/-- Their widths shrink exponentially and therefore vanish
(`ChapterH6.sirk_error_decay_exponential`). -/
theorem sirk_band_widths_tendsto_zero (C Dmin h nv : ℝ) (hh : 0 < h) :
    Tendsto (fun m => sirkBound C Dmin h nv m - 0) atTop (𝓝 0) := by
  simpa using sirk_error_decay_exponential C Dmin h nv hh

/-- **The enclosure for the SIRK bands.**  If the order-`m` approximant lies in the
order-`m` SIRK band and the approximants converge to `lam`, then `lam` lies in every SIRK
band, is the only such number, and the band endpoints converge to it.  Nesting comes from
`ChapterH8.sirk_band_contained`, collapse from the exponential decay of the bound. -/
theorem sirk_band_enclosure (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 < h)
    {a : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, a m ∈ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m))
    (hconv : Tendsto a atTop (𝓝 lam)) :
    (∀ m, lam ∈ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m)) ∧
      (∀ lam', (∀ m, lam' ∈ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m)) → lam' = lam) ∧
      Tendsto (fun m => sirkBound C Dmin h nv m) atTop (𝓝 lam) := by
  obtain ⟨h1, h2, -, h4⟩ :=
    band_enclosure_endpoints_tendsto (sirk_nestedBands C Dmin h nv hC hD hnv hh.le) hmem hconv
      (sirk_band_widths_tendsto_zero C Dmin h nv hh)
  exact ⟨h1, h2, h4⟩

/-! ## 4. The enclosure for the operator the Hashimoto algorithm selects -/

section Selected

open BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit BookProof.ChapterSirkRitzSpectrum

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The band-enclosure hypothesis for the selected operator.**  Let `A` be a bounded
positive self-adjoint one-particle operator and `b` a complete orthonormal (Hermite /
occupation-number) basis.  Then:

* the Galerkin/Hashimoto algorithm applied to the matrix of `A` in `b` **selects** `A`
  itself as the positive self-adjoint (Friedrichs) extension
  (`HermiteGalerkin.finiteModeRestrict_selects_operator`);
* its order-`m` Ritz values converge to `sInf (spectrum ℝ A)`
  (`ChapterSirkRitzSpectrum.ritzInf_tendsto_sInf_spectrum`);

so, if the certified bands nest and the order-`m` Ritz value lies in the order-`m` band,
**every** certified band encloses the spectral edge of the selected operator.  This is the
enclosure that `ChapterFockOneParticleGap` had to assume. -/
theorem ritz_band_enclosure_of_nested [Nontrivial F] (A : F →L[ℂ] F) (hsa : IsSelfAdjoint A)
    (hpos : ∀ u : F, 0 ≤ (inner ℂ u (A u) : ℂ).re) (b : HilbertBasis ℕ ℂ F)
    {lo hi : ℕ → ℝ} (hnest : NestedBands lo hi)
    (hritz : ∀ m, ritzInf (finiteModeRestrict A b) (galerkinSpan b (m + 1)) ∈
      Set.Icc (lo m) (hi m)) :
    IsPositiveSelfAdjointExtension (finiteModeRestrict A b) (topRestrict A) ∧
      ∀ m, sInf (spectrum ℝ A) ∈ Set.Icc (lo m) (hi m) :=
  ⟨(finiteModeRestrict_selects_operator A hsa hpos b).1,
    band_enclosure_of_nested hnest hritz (ritzInf_tendsto_sInf_spectrum A hsa hpos b)⟩

/-- **The composition, with no enclosure hypothesis left.**  For a bounded positive
self-adjoint one-particle operator `A` that the Hashimoto/Galerkin algorithm selects, with
a Hilbert basis `b` of eigenvectors with eigenvalues `e`:

* nested certified bands containing the order-`m` Ritz values,
* vanishing band widths, and
* one band with lower end `≥ μ ≥ 0`

give the Fock mass gap of the free second quantization `dΓ(h₊)`: the certified endpoints
converge to the spectral edge of the selected operator, that edge is `≥ μ`, the vacuum has
energy `0`, and every vacuum-orthogonal finite-particle state has energy at least `μ‖·‖²`.

Compared with `FockOneParticleGap.fock_mass_gap_of_certified_bands_operator` the band
enclosure is *derived* here, from band nesting plus Ritz convergence to the selected
operator, rather than assumed. -/
theorem fock_mass_gap_of_nested_ritz_bands [Nontrivial F] (A : F →L[ℂ] F)
    (hsa : IsSelfAdjoint A) (hpos : ∀ u : F, 0 ≤ (inner ℂ u (A u) : ℂ).re)
    (b : HilbertBasis ℕ ℂ F) {e : ℕ → ℝ}
    (heig : ∀ k, A (b k) = ((e k : ℝ) : ℂ) • b k)
    {lo hi : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (hnest : NestedBands lo hi)
    (hritz : ∀ m, ritzInf (finiteModeRestrict A b) (galerkinSpan b (m + 1)) ∈
      Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) :
    IsPositiveSelfAdjointExtension (finiteModeRestrict A b) (topRestrict A) ∧
      Tendsto lo atTop (𝓝 (sInf (spectrum ℝ A))) ∧ mu ≤ sInf (spectrum ℝ A) ∧
      dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by
  obtain ⟨hsel, hband⟩ := ritz_band_enclosure_of_nested A hsa hpos b hnest hritz
  exact ⟨hsel, fock_mass_gap_of_certified_bands_operator hsa heig hmu hband hwidth hlo⟩

end Selected

/-! ## 4b. The unbounded route: the certified gap of the Friedrichs extension

The section above needs the selected operator to be bounded, because it uses the
*spectral* edge `sInf (spectrum ℝ A)`.  For the genuinely unbounded Hamiltonian the same
chain works with the **energy form** in place of the spectrum, and nothing has to be
assumed:

* the Hashimoto/Galerkin Ritz values converge to the bottom `ritzInf H (finiteModeDomain b)`
  of the form on the core (`HermiteGalerkin.ritzInf_tendsto_domainInf`, no boundedness);
* hence nested certified bands enclose that bottom (`band_enclosure_of_nested`);
* a band with lower end `≥ μ` therefore gives the core bound `⟪x, H x⟫ ≥ μ‖x‖²`; and
* the Friedrichs extension — the operator the Hashimoto shift-invert selects
  (`FriedrichsExtension.friedrichs_hashimoto_selects`) — inherits it
  (`FriedrichsFormGap.friedrichs_extension_form_gap`). -/

section Unbounded

open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert BookProof.FriedrichsExtension
open BookProof.FriedrichsFormGap

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

omit [CompleteSpace F] in
/-- The energy form is homogeneous of degree two under real scaling. -/
theorem quadForm_real_smul {D : Submodule ℂ F} (H : D →ₗ[ℂ] F) (c : ℝ) (x : D) :
    quadForm H ((c : ℂ) • x) = c ^ 2 * quadForm H x := by
  have h : (inner ℂ (((c : ℂ) • x : D) : F) (H ((c : ℂ) • x)) : ℂ)
      = ((c ^ 2 : ℝ) : ℂ) * inner ℂ (x : F) (H x) := by
    rw [map_smul, Submodule.coe_smul, inner_smul_left, inner_smul_right, Complex.conj_ofReal]
    push_cast
    ring
  rw [quadForm, quadForm, h, Complex.re_ofReal_mul]

omit [CompleteSpace F] in
/-- **The Ritz bottom is a form lower bound.**  If `μ` is at most the Ritz infimum over the
domain, then `μ‖x‖² ≤ ⟪x, H x⟫` for every domain vector — the hypothesis the Friedrichs
transfer consumes. -/
theorem quadForm_ge_of_le_ritzInf {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) {mu : ℝ} (hmu : mu ≤ ritzInf H D) (x : D) :
    mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x := by
  rcases eq_or_ne ((x : F)) 0 with hx | hx
  · have hx0 : x = 0 := Subtype.ext hx
    simp [hx0, quadForm]
  · have hnpos : 0 < ‖(x : F)‖ := norm_pos_iff.mpr hx
    set c : ℝ := ‖(x : F)‖⁻¹ with hc
    have hcpos : 0 < c := inv_pos.mpr hnpos
    have hunit : ‖(((c : ℂ) • x : D) : F)‖ = 1 := by
      rw [Submodule.coe_smul, norm_smul]
      simp [hc, hnpos.ne']
    have hmem : quadForm H ((c : ℂ) • x) ∈ ritzSet H D :=
      ⟨(c : ℂ) • x, ((c : ℂ) • x : D).2, hunit, rfl⟩
    have hle : ritzInf H D ≤ quadForm H ((c : ℂ) • x) :=
      csInf_le (ritzSet_bddBelow H hpos D) hmem
    rw [quadForm_real_smul] at hle
    have hsq : c ^ 2 * ‖(x : F)‖ ^ 2 = 1 := by
      rw [hc, inv_pow, inv_mul_cancel₀ (pow_ne_zero 2 hnpos.ne')]
    have h2 := mul_le_mul_of_nonneg_right (hmu.trans hle) (sq_nonneg ‖(x : F)‖)
    have h3 : c ^ 2 * quadForm H x * ‖(x : F)‖ ^ 2
        = (c ^ 2 * ‖(x : F)‖ ^ 2) * quadForm H x := by ring
    rw [h3, hsq, one_mul] at h2
    exact h2

/-- **The unbounded composition: a certified band gives a gap of the *infinite* selected
operator.**  For a positive symmetric Hamiltonian `H` on the finite-mode (Hermite) core of a
complete orthonormal basis — with **no boundedness hypothesis** — suppose the certified
bands nest and the order-`m` Hashimoto/Galerkin Ritz value lies in the order-`m` band, and
suppose one band has lower end `≥ μ`.  Then:

* every certified band encloses the form bottom `Δ₁ = ritzInf H (finiteModeDomain b)` of the
  core (derived, not assumed);
* `μ ≤ Δ₁`; and
* the Friedrichs extension `A` — which exists, is a positive self-adjoint extension of `H`,
  and is the operator selected by the Hashimoto shift-invert `S` at `γ = 1` — satisfies
  `⟪y, A y⟫ ≥ μ‖y‖²` on its whole domain.

This is the band-enclosure obligation of `ChapterFockOneParticleGap`, discharged for the
unbounded selected operator. -/
theorem friedrichs_form_gap_of_nested_ritz_bands (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn (finiteModeDomain b) H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x)
    {lo hi : ℕ → ℝ} {mu : ℝ} (hnest : NestedBands lo hi)
    (hritz : ∀ m, ritzInf H (galerkinSpan b (m + 1)) ∈ Set.Icc (lo m) (hi m))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) :
    (∀ m, ritzInf H (finiteModeDomain b) ∈ Set.Icc (lo m) (hi m)) ∧
      mu ≤ ritzInf H (finiteModeDomain b) ∧
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (S : F →L[ℂ] F),
        IsPositiveSelfAdjointExtension H A ∧ IsShiftInvert A 1 S ∧ IsSelfAdjoint S ∧
          ∀ y : Dom, mu * ‖(y : F)‖ ^ 2 ≤ quadForm A y := by
  have hband := band_enclosure_of_nested hnest hritz (ritzInf_tendsto_domainInf b H hpos)
  have hmu : mu ≤ ritzInf H (finiteModeDomain b) := le_of_band hband hlo
  refine ⟨hband, hmu, ?_⟩
  exact friedrichs_extension_form_gap ⟨finiteModeDomain b, H, hsym, hpos⟩
    (finiteModeDomain_dense b) (quadForm_ge_of_le_ritzInf H hpos hmu)

end Unbounded

/-! ## 5. Transport through the Hashimoto shift-invert

The unbounded route certifies the bounded resolvent `R = (h₊ + γ)⁻¹`
(`ChapterFriedrichsExtension.friedrichs_hashimoto_selects`), whose relevant spectral value
`nu` is related to the one-particle edge by `lam = nu⁻¹ − γ`.  A band enclosure for `nu`
transports to a band enclosure for `lam` through that (antitone) map, and the transported
widths still vanish. -/

/-- A band enclosure for the resolvent value `nu` transports to a band enclosure for the
one-particle edge `lam = nu⁻¹ − γ`, with the endpoints exchanged. -/
theorem shiftInvert_band_enclosure {lo hi : ℕ → ℝ} {nu lam gam : ℝ}
    (hlopos : ∀ m, 0 < lo m) (hband : ∀ m, nu ∈ Set.Icc (lo m) (hi m))
    (hmap : lam = nu⁻¹ - gam) :
    ∀ m, lam ∈ Set.Icc ((hi m)⁻¹ - gam) ((lo m)⁻¹ - gam) := by
  intro m
  obtain ⟨h1, h2⟩ := hband m
  have hnu : 0 < nu := lt_of_lt_of_le (hlopos m) h1
  subst hmap
  constructor
  · gcongr
  · gcongr
    exact hlopos m

/-- The transported band widths vanish: if the certified endpoints converge to a positive
resolvent value `nu`, then the widths of the shift-inverted bands tend to `0`. -/
theorem shiftInvert_widths_tendsto_zero {lo hi : ℕ → ℝ} {nu gam : ℝ} (hnu : nu ≠ 0)
    (hlo : Tendsto lo atTop (𝓝 nu)) (hhi : Tendsto hi atTop (𝓝 nu)) :
    Tendsto (fun m => ((lo m)⁻¹ - gam) - ((hi m)⁻¹ - gam)) atTop (𝓝 0) := by
  have h1 : Tendsto (fun m => (lo m)⁻¹) atTop (𝓝 nu⁻¹) := hlo.inv₀ hnu
  have h2 : Tendsto (fun m => (hi m)⁻¹) atTop (𝓝 nu⁻¹) := hhi.inv₀ hnu
  have := (h1.sub_const gam).sub (h2.sub_const gam)
  simpa using this

end BookProof.BandEnclosure

end

import Mathlib
import BookProof.ChapterBandEnclosure

/-!
# Chapter RitzCertificate — the per-order finite certificate, derived

`CONSOLIDATED_PLAN.md` (top work package, status update 2026-08-28) leaves exactly two
inputs on the route from the finite Hashimoto/SIRK computation to a gap of the infinite
selected operator:

1. **the finite certificate at each order** — that the order-`m` Ritz value lies in the
   order-`m` emitted band, and that the emitted bands *nest*; and
2. the free/diagonal (number-preserving) hypothesis in the `dΓ` lift.

This chapter closes item 1.  Nothing here is assumed about the emitter: both halves are
*constructed and proved*.

* **the band, from the computation** — the order-`m` Ritz vector `x m` produces a
  two-sided enclosure of the spectral edge by itself.  Its Rayleigh quotient
  `θ = ⟪x, A x⟫` is an upper bound for `sInf (spectrum ℝ A)` (Rayleigh–Ritz), and its
  residual `ε = ‖A x − θ x‖` gives the matching **lower** bound through *Temple's
  inequality*

  `sInf (spectrum ℝ A) ≥ θ − ε² / (β − θ)`,

  valid whenever the rest of the spectrum lies above a known `β > θ`.  Both endpoints are
  computable from the finite Krylov/Galerkin data, so `[θ − ε²/(β−θ), θ]` is exactly an
  *emitted* band, and it encloses the edge of the infinite operator by a theorem, not by
  assumption (`temple_lower_bound`, `temple_band_mem`).

* **nesting, for free** — an arbitrary family of enclosing bands is turned into a *nested*
  family by running intersection, `runLo = max_{k ≤ m} lo k`, `runHi = min_{k ≤ m} hi k`.
  The running family is nested by construction (`runBands_nested`), still encloses
  everything the original family enclosed (`mem_runBand`), and its widths are no larger
  (`runBand_width_le`), so they still vanish (`runBand_widths_tendsto_zero`).

Composing the two with the free outer-enclosure/`dΓ` lift of
`ChapterFockOneParticleGap` gives the full-theory statement: the Ritz data first
certify the inner one-particle edge, then the creation-left/annihilation-right
outer Hamiltonian inherits the exact vacuum and non-vacuum gap. The finite
certificate alone does not establish a standalone inner Hamiltonian ground state.
`fock_mass_gap_of_temple_certificates`: from finite Rayleigh/residual data alone — no band
hypothesis of any kind — a Fock mass gap for the free second quantization of the selected
bounded operator.

## Honest boundary

Temple's inequality needs the *spectral separation* input `hsep`: the spectrum of `A` below
`β` consists of the edge alone.  That is the standard (and unavoidable) side condition of
every rigorous two-sided eigenvalue enclosure — a residual bound alone can never separate a
cluster.  It is stated explicitly in every theorem and never derived.  As everywhere in this
development, `1.932` remains a certified truncated number and no mass gap of the physical
Yang–Mills Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

open Filter Topology

namespace BookProof.RitzCertificate

open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterSirkRitzSpectrum BookProof.BandEnclosure

section Temple

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- The **Rayleigh quotient** of a vector: the energy `⟪x, A x⟫` (real for self-adjoint
`A`).  For a unit vector this is the order-`m` Ritz value the algorithm emits. -/
def rayleigh (A : F →L[ℂ] F) (x : F) : ℝ := (inner ℂ x (A x) : ℂ).re

/-- The **residual** of a vector: `‖A x − θ x‖` with `θ` its Rayleigh quotient.  This is the
second number the finite computation emits, and it is what drives the width of the
certified band. -/
def resid (A : F →L[ℂ] F) (x : F) : ℝ := ‖A x - ((rayleigh A x : ℝ) : ℂ) • x‖

omit [CompleteSpace F] in
/-- Pythagoras for the residual decomposition: for a unit vector,
`‖A x‖² = ε² + θ²`. -/
theorem norm_apply_sq (A : F →L[ℂ] F) (x : F) (hx : ‖x‖ = 1) :
    ‖A x‖ ^ 2 = resid A x ^ 2 + rayleigh A x ^ 2 := by
  have hsym : (inner ℂ (A x) x : ℂ).re = (inner ℂ x (A x) : ℂ).re := by
    rw [← inner_conj_symm (𝕜 := ℂ) x (A x), Complex.conj_re]
  have h := @norm_sub_sq ℂ F _ _ _ (A x) (((rayleigh A x : ℝ) : ℂ) • x)
  rw [resid, h, inner_smul_right, norm_smul]
  simp only [rayleigh, RCLike.mul_re, RCLike.re_to_complex, Complex.ofReal_re,
    RCLike.im_to_complex, Complex.ofReal_im, zero_mul, sub_zero, Complex.norm_real,
    Real.norm_eq_abs, hx, mul_one, sq_abs]
  rw [hsym]
  ring

/-- The operator `A − c` is self-adjoint for real `c`. -/
theorem isSelfAdjoint_sub_const {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (c : ℝ) :
    IsSelfAdjoint (A - (c : ℝ) • (1 : F →L[ℂ] F)) := by
  simp [IsSelfAdjoint, star_sub, hA.star_eq]

/-- The **quadratic form of the Temple factor**:
`⟪x, (A − l)(A − β) x⟫ = ‖A x‖² − (l + β)⟪x, A x⟫ + lβ‖x‖²`. -/
theorem re_inner_factor {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) (l b : ℝ) (x : F) :
    (inner ℂ x ((((A - (l : ℝ) • (1 : F →L[ℂ] F)) *
        (A - (b : ℝ) • (1 : F →L[ℂ] F))) x)) : ℂ).re
      = ‖A x‖ ^ 2 - (l + b) * rayleigh A x + l * b * ‖x‖ ^ 2 := by
  have hsym : (inner ℂ (A x) x : ℂ).re = (inner ℂ x (A x) : ℂ).re := by
    rw [← inner_conj_symm (𝕜 := ℂ) x (A x), Complex.conj_re]
  have hPx : (A - (l : ℝ) • (1 : F →L[ℂ] F)) x = A x - (l : ℂ) • x := by simp
  have hQx : (A - (b : ℝ) • (1 : F →L[ℂ] F)) x = A x - (b : ℂ) • x := by simp
  have hmove : (inner ℂ x ((((A - (l : ℝ) • (1 : F →L[ℂ] F)) *
        (A - (b : ℝ) • (1 : F →L[ℂ] F))) x)) : ℂ)
      = inner ℂ ((A - (l : ℝ) • (1 : F →L[ℂ] F)) x)
          ((A - (b : ℝ) • (1 : F →L[ℂ] F)) x) := by
    rw [ContinuousLinearMap.mul_apply, ← ContinuousLinearMap.adjoint_inner_left,
      (isSelfAdjoint_sub_const hA l).adjoint_eq]
  rw [hmove, hPx, hQx, rayleigh]
  simp [inner_self_eq_norm_sq_to_K, Complex.sub_re, Complex.mul_re, hsym,
    ← Complex.ofReal_pow]
  ring_nf

/-- **The Temple factor is a positive operator.**  If every spectral value `t` of the
self-adjoint operator `A` satisfies `(t − l)(t − β) ≥ 0` — which is the case when the
spectrum lies in `{l} ∪ [β, ∞)` with `l ≤ β` — then `(A − l)(A − β) ≥ 0`.  Proved by the
continuous functional calculus. -/
theorem factor_nonneg {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ}
    (hspec : ∀ t ∈ spectrum ℝ A, 0 ≤ (t - l) * (t - b)) :
    0 ≤ (A - (l : ℝ) • (1 : F →L[ℂ] F)) * (A - (b : ℝ) • (1 : F →L[ℂ] F)) := by
  have h1 : cfc (fun t : ℝ => (t - l) * (t - b)) A
      = (A - (l : ℝ) • (1 : F →L[ℂ] F)) * (A - (b : ℝ) • (1 : F →L[ℂ] F)) := by
    rw [cfc_mul _ _ A, cfc_sub _ _ A, cfc_sub _ _ A, cfc_id' ℝ A, cfc_const l A, cfc_const b A,
      Algebra.algebraMap_eq_smul_one, Algebra.algebraMap_eq_smul_one]
  rw [← h1]
  exact cfc_nonneg hspec

/-- The spectral separation hypothesis of a two-sided enclosure: apart from the edge `l`,
the spectrum of `A` lies above `β`. -/
def SpectralSeparation (A : F →L[ℂ] F) (l b : ℝ) : Prop :=
  l ≤ b ∧ ∀ t ∈ spectrum ℝ A, t = l ∨ b ≤ t

theorem factor_nonneg_of_separation {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ}
    (hsep : SpectralSeparation A l b) :
    0 ≤ (A - (l : ℝ) • (1 : F →L[ℂ] F)) * (A - (b : ℝ) • (1 : F →L[ℂ] F)) := by
  refine factor_nonneg hA ?_
  intro t ht
  rcases hsep.2 t ht with h | h
  · simp [h]
  · have h1 : 0 ≤ t - l := by linarith [hsep.1]
    have h2 : 0 ≤ t - b := by linarith
    positivity

/-- **Temple's inequality.**  Let `A` be bounded self-adjoint, let `x` be a unit vector with
Rayleigh quotient `θ` and residual `ε`, and suppose the spectrum of `A` lies in
`{l} ∪ [β, ∞)` with `θ < β`.  Then

`l ≥ θ − ε² / (β − θ)`.

Both `θ` and `ε` are outputs of the finite computation, so this is a *computable* rigorous
lower bound for the spectral edge. -/
theorem temple_lower_bound {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {l b : ℝ} {x : F}
    (hsep : SpectralSeparation A l b) (hx : ‖x‖ = 1) (hlt : rayleigh A x < b) :
    rayleigh A x - resid A x ^ 2 / (b - rayleigh A x) ≤ l := by
  set th := rayleigh A x with hth
  set eps := resid A x with heps
  have hpos := factor_nonneg_of_separation hA hsep
  have hquad0 := ((ContinuousLinearMap.nonneg_iff_isPositive _).mp hpos).inner_nonneg_right x
  have hquad : 0 ≤ (inner ℂ x ((((A - (l : ℝ) • (1 : F →L[ℂ] F)) *
      (A - (b : ℝ) • (1 : F →L[ℂ] F))) x)) : ℂ).re := by
    simpa only [Complex.zero_re] using (Complex.le_def.mp hquad0).1
  rw [re_inner_factor hA l b x, norm_apply_sq A x hx, hx] at hquad
  have hkey : (th - l) * (b - th) ≤ eps ^ 2 := by nlinarith [hquad]
  have hbth : 0 < b - th := by linarith
  have hdiv : th - l ≤ eps ^ 2 / (b - th) := (le_div_iff₀ hbth).mpr hkey
  linarith

end Temple

section TempleBand

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- Rayleigh–Ritz: the Rayleigh quotient of a unit vector is an upper bound for the bottom
of the spectrum. -/
theorem sInf_spectrum_le_rayleigh [Nontrivial F] (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    {x : F} (hx : ‖x‖ = 1) : sInf (spectrum ℝ A) ≤ rayleigh A x := by
  have h := rayleighInf_mul_normSq_le A x
  rw [hx] at h
  rw [sInf_spectrum_eq_rayleighInf A hA, rayleigh]
  simpa using h

/-- **The emitted Temple band encloses the spectral edge.**  The interval
`[θ − ε²/(β−θ), θ]`, both of whose endpoints are computed from the finite Ritz vector `x`,
contains `sInf (spectrum ℝ A)` — the edge of the *infinite* operator. -/
theorem temple_band_mem [Nontrivial F] {A : F →L[ℂ] F} (hA : IsSelfAdjoint A) {b : ℝ} {x : F}
    (hsep : SpectralSeparation A (sInf (spectrum ℝ A)) b) (hx : ‖x‖ = 1)
    (hlt : rayleigh A x < b) :
    sInf (spectrum ℝ A) ∈
      Set.Icc (rayleigh A x - resid A x ^ 2 / (b - rayleigh A x)) (rayleigh A x) :=
  ⟨temple_lower_bound hA hsep hx hlt, sInf_spectrum_le_rayleigh A hA hx⟩

omit [CompleteSpace F] in
/-- The width of the emitted Temple band is `ε²/(β−θ)`, so it vanishes as soon as the
residuals do, provided the Rayleigh quotients stay a fixed distance below `β`. -/
theorem temple_width_tendsto_zero {A : F →L[ℂ] F} {b delta : ℝ} {x : ℕ → F}
    (hdelta : 0 < delta) (hle : ∀ m, rayleigh A (x m) ≤ b - delta)
    (hres : Tendsto (fun m => resid A (x m)) atTop (𝓝 0)) :
    Tendsto (fun m => rayleigh A (x m) -
      (rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))) atTop (𝓝 0) := by
  have hsq : Tendsto (fun m => resid A (x m) ^ 2) atTop (𝓝 0) := by
    simpa using hres.pow 2
  have hsqueeze : ∀ m, |rayleigh A (x m) -
      (rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))|
        ≤ resid A (x m) ^ 2 / delta := by
    intro m
    have hb : delta ≤ b - rayleigh A (x m) := by linarith [hle m]
    have hnn : 0 ≤ resid A (x m) ^ 2 := sq_nonneg _
    have : resid A (x m) ^ 2 / (b - rayleigh A (x m)) ≤ resid A (x m) ^ 2 / delta :=
      div_le_div_of_nonneg_left hnn hdelta hb
    have hpos : 0 ≤ resid A (x m) ^ 2 / (b - rayleigh A (x m)) :=
      div_nonneg hnn (by linarith)
    rw [abs_of_nonneg (by linarith)]
    linarith
  have hbound : Tendsto (fun m => resid A (x m) ^ 2 / delta) atTop (𝓝 0) := by
    simpa using hsq.div_const delta
  exact squeeze_zero_norm hsqueeze hbound

end TempleBand

/-! ## 2. Nesting for free: the running intersection of the emitted bands -/

section RunningBands

/-- The running maximum of the emitted lower endpoints. -/
def runLo (lo : ℕ → ℝ) (m : ℕ) : ℝ :=
  (Finset.range (m + 1)).sup' (Finset.nonempty_range_add_one) lo

/-- The running minimum of the emitted upper endpoints. -/
def runHi (hi : ℕ → ℝ) (m : ℕ) : ℝ :=
  (Finset.range (m + 1)).inf' (Finset.nonempty_range_add_one) hi

theorem le_runLo (lo : ℕ → ℝ) (m : ℕ) : lo m ≤ runLo lo m :=
  Finset.le_sup' lo (Finset.self_mem_range_succ m)

theorem runHi_le (hi : ℕ → ℝ) (m : ℕ) : runHi hi m ≤ hi m :=
  Finset.inf'_le hi (Finset.self_mem_range_succ m)

theorem runLo_mono (lo : ℕ → ℝ) {m n : ℕ} (hmn : m ≤ n) : runLo lo m ≤ runLo lo n :=
  Finset.sup'_mono lo
    (Finset.range_subset.mpr fun k hk => Finset.mem_range.mpr (by omega)) _

theorem runHi_antitone (hi : ℕ → ℝ) {m n : ℕ} (hmn : m ≤ n) : runHi hi n ≤ runHi hi m :=
  Finset.inf'_mono hi
    (Finset.range_subset.mpr fun k hk => Finset.mem_range.mpr (by omega)) _

/-- **Nesting, for free.**  The running intersection of *any* family of emitted bands is a
nested family.  This discharges the `NestedBands` input of `ChapterBandEnclosure` without
any hypothesis on the emitter. -/
theorem runBands_nested (lo hi : ℕ → ℝ) : NestedBands (runLo lo) (runHi hi) := fun m =>
  Set.Icc_subset_Icc (runLo_mono lo (Nat.le_succ m)) (runHi_antitone hi (Nat.le_succ m))

/-- The running bands enclose everything the original bands enclosed. -/
theorem mem_runBand {lo hi : ℕ → ℝ} {lam : ℝ} (h : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) (m : ℕ) :
    lam ∈ Set.Icc (runLo lo m) (runHi hi m) := by
  constructor
  · exact Finset.sup'_le _ lo fun k _ => (h k).1
  · exact Finset.le_inf' _ hi fun k _ => (h k).2

/-- The running bands are no wider than the original ones. -/
theorem runBand_width_le (lo hi : ℕ → ℝ) (m : ℕ) :
    runHi hi m - runLo lo m ≤ hi m - lo m := by
  have h1 := le_runLo lo m
  have h2 := runHi_le hi m
  linarith

/-- Hence if the emitted widths vanish so do the running widths. -/
theorem runBand_widths_tendsto_zero {lo hi : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    Tendsto (fun m => runHi hi m - runLo lo m) atTop (𝓝 0) := by
  refine squeeze_zero_norm (fun m => ?_) hwidth
  have hlam := mem_runBand hmem m
  have hnn : 0 ≤ runHi hi m - runLo lo m := by
    have := hlam.1; have := hlam.2; linarith
  rw [Real.norm_eq_abs, abs_of_nonneg hnn]
  exact runBand_width_le lo hi m

/-- **The finite certificate, assembled.**  From an arbitrary family of emitted bands that
enclose `lam` with vanishing widths, the running intersection is a *nested* family that
still encloses `lam` with vanishing widths — exactly the input
`ChapterBandEnclosure.band_enclosure_endpoints_tendsto` and
`ChapterFockOneParticleGap.fock_mass_gap_of_certified_bands` consume. -/
theorem nested_certificate_of_bands {lo hi : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    NestedBands (runLo lo) (runHi hi) ∧ (∀ m, lam ∈ Set.Icc (runLo lo m) (runHi hi m)) ∧
      Tendsto (fun m => runHi hi m - runLo lo m) atTop (𝓝 0) :=
  ⟨runBands_nested lo hi, mem_runBand hmem, runBand_widths_tendsto_zero hmem hwidth⟩

end RunningBands

/-! ## 3. The composition: finite Rayleigh/residual data ⟹ Fock mass gap -/

section Composition

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The certified bands of the Temple emitter are nested and enclose the edge.**  For a
bounded self-adjoint `A` whose spectrum is separated (`hsep`) and a sequence of finite Ritz
vectors `x m` whose Rayleigh quotients stay below `β − δ` and whose residuals vanish, the
running Temple bands

`[runLo m, runHi m]`, `lo m = θ m − ε m²/(β − θ m)`, `hi m = θ m`,

nest, enclose `sInf (spectrum ℝ A)` and collapse onto it. -/
theorem temple_nested_certificate [Nontrivial F] {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b delta : ℝ} {x : ℕ → F} (hsep : SpectralSeparation A (sInf (spectrum ℝ A)) b)
    (hdelta : 0 < delta) (hx : ∀ m, ‖x m‖ = 1) (hle : ∀ m, rayleigh A (x m) ≤ b - delta)
    (hres : Tendsto (fun m => resid A (x m)) atTop (𝓝 0)) :
    NestedBands (runLo fun m => rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))
        (runHi fun m => rayleigh A (x m)) ∧
      (∀ m, sInf (spectrum ℝ A) ∈
        Set.Icc (runLo (fun m => rayleigh A (x m) -
            resid A (x m) ^ 2 / (b - rayleigh A (x m))) m)
          (runHi (fun m => rayleigh A (x m)) m)) ∧
      Tendsto (fun m => runHi (fun m => rayleigh A (x m)) m -
        runLo (fun m => rayleigh A (x m) -
          resid A (x m) ^ 2 / (b - rayleigh A (x m))) m) atTop (𝓝 0) := by
  have hlt : ∀ m, rayleigh A (x m) < b := fun m => by linarith [hle m]
  have hmem : ∀ m, sInf (spectrum ℝ A) ∈
      Set.Icc (rayleigh A (x m) - resid A (x m) ^ 2 / (b - rayleigh A (x m)))
        (rayleigh A (x m)) := fun m => temple_band_mem hA hsep (hx m) (hlt m)
  exact nested_certificate_of_bands hmem
    (temple_width_tendsto_zero hdelta hle hres)

/-- **The end-to-end theorem of this chapter.**  Finite Rayleigh/residual data alone — no
band hypothesis, no nesting hypothesis — give a Fock mass gap for the free second
quantization of the operator the algorithm selects:

* `hsep` — the spectral separation input of any rigorous two-sided enclosure;
* `hx`, `hle`, `hres` — the finite computation: unit Ritz vectors whose Rayleigh quotients
  stay below `β − δ` and whose residuals vanish;
* `hlo` — one emitted Temple band with lower end `≥ μ`.

Conclusion: the emitted lower endpoints converge to `sInf (spectrum ℝ A)`, that edge is
`≥ μ`, the Fock vacuum has energy `0`, and every vacuum-orthogonal finite-particle state has
energy at least `μ‖·‖²`. -/
theorem fock_mass_gap_of_temple_certificates [Nontrivial F] {A : F →L[ℂ] F}
    (hA : IsSelfAdjoint A) {bas : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (bas k) = ((e k : ℝ) : ℂ) • bas k)
    {b delta mu : ℝ} {x : ℕ → F} (hsep : SpectralSeparation A (sInf (spectrum ℝ A)) b)
    (hdelta : 0 < delta) (hmu : 0 ≤ mu) (hx : ∀ m, ‖x m‖ = 1)
    (hle : ∀ m, rayleigh A (x m) ≤ b - delta)
    (hres : Tendsto (fun m => resid A (x m)) atTop (𝓝 0))
    {m₀ : ℕ} (hlo : mu ≤ rayleigh A (x m₀) -
      resid A (x m₀) ^ 2 / (b - rayleigh A (x m₀))) :
    Tendsto (runLo fun m => rayleigh A (x m) -
        resid A (x m) ^ 2 / (b - rayleigh A (x m))) atTop (𝓝 (sInf (spectrum ℝ A))) ∧
      mu ≤ sInf (spectrum ℝ A) ∧ dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by
  obtain ⟨-, hmem, hwidth⟩ := temple_nested_certificate hA hsep hdelta hx hle hres
  exact fock_mass_gap_of_certified_bands_operator hA heig hmu hmem hwidth
    (m₀ := m₀) (le_trans hlo (le_runLo (fun m => rayleigh A (x m) -
      resid A (x m) ^ 2 / (b - rayleigh A (x m))) m₀))

end Composition

end BookProof.RitzCertificate

end

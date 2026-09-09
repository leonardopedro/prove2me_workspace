import Mathlib
import BookProof.ChapterFockSecondQuantization
import BookProof.ChapterSirkCertifiedGap
import BookProof.ChapterSirkRitzSpectrum
import BookProof.ChapterSpectralGapStability

/-!
# Chapter FockOneParticleGap — the one-particle edge and its free `dΓ` lift

/-!
Interpretation convention: this module proves facts about the inner one-particle
operator and their lift. The physical final Hamiltonian in QYM, QED, QG, and NS
is the outer creation-left/annihilation-right enclosure of that operator. Hence
inner squeezed states are not full-theory grounds; the outer vacuum is killed by
the rightmost outer annihilator.
-/!

`CONSOLIDATED_PLAN.md`, top work package ("Hashimoto observable to the real-Hamiltonian
gap"), asks for the composition that is genuinely missing between the finite Hashimoto/SIRK
certificate and a *Fock* mass gap:

* the **one-particle** observable, its strict positivity `h₊ ≥ μ I`, and the free
  number-operator shift `dΓ(h₊) = dΓ(h − E₀I) + μ N`;
* the **nested-band** conclusion: certified intervals with vanishing widths that all
  enclose the lowest positive one-particle energy of one *fixed* operator determine that
  energy, and a single interval whose lower end is `≥ μ` already forces `λ₁ ≥ μ`;
* the **free `dΓ` lift**: the vacuum has energy `0`, every non-vacuum finite-particle
  state has energy at least the lowest one-particle energy, and a one-particle creation
  attains it — so the Fock gap *is* the one-particle edge.

Everything is proved in the algebraic Fock space `FockAlg = Conf →₀ ℂ` of
`BookProof.FockSecondQuantization`, for the **free** (number-preserving, diagonal in the
one-particle eigenbasis) one-particle Hamiltonian: `diagCol e` is the one-particle matrix
with eigenvalues `e k`, i.e. the matrix of `h₊` in a basis that diagonalizes it.  That is
exactly the "free outer particles" hypothesis of the plan; it is stated explicitly
everywhere and nothing here applies to pair creation or other interacting terms.

## Deliverables

* `dGamma_diagCol_single`, `dGamma_diagCol_apply` — `dΓ(h₊)` is diagonal on
  configurations, with eigenvalue the configuration energy `Σ_k β_k e_k`;
* `dGamma_diagCol_vac`, `numberOp_vac` — `dΓ(h₊) Ω = 0` and `N Ω = 0`;
* `dGamma_diagCol_one_particle`, `fock_energy_one_particle` — `a†(e_k) Ω` is an
  eigenvector of energy `e k`, so the one-particle energies really are Fock energies;
* `dGamma_diagCol_shift` — the free number-operator shift
  `dΓ(h + μ) = dΓ(h) + μ N`;
* `fock_gap_quadForm`, `fock_gap_of_one_particle_gap` — the **free `dΓ` lift**: with
  `h₊ ≥ μ I ≥ 0`, the vacuum has energy `0` and every vacuum-orthogonal finite-particle
  state has energy at least `μ‖·‖²`;
* `band_endpoints_tendsto`, `le_of_band` — the nested-band conclusion for the
  one-particle edge;
* `fock_mass_gap_of_certified_bands` — the composition of the two, and
  `qcdG2M4_fock_gap_of_one_particle_enclosure` — its instance for the emitted
  `g = 2, m = 4` certificate value `1.932`.

## Honest boundary

No mass gap of the physical Yang–Mills Hamiltonian is claimed.  `1.932` remains a
*certified truncated* number.  What is proved here is the implication

  *(the certified bands enclose the lowest positive one-particle energy of the fixed
  selected operator, and one band has lower end `≥ μ > 0`)*
  ⟹ *(the free second quantization has vacuum energy `0` and every vacuum-orthogonal
  finite-particle state has energy `≥ μ`)*,

together with the exact identification of the Fock gap with the one-particle edge in the
free case.  The enclosure hypothesis itself — that the finite certificate brackets the
one-particle edge of the *infinite* selected operator — is an analytic obligation that
appears here as a hypothesis, never as a conclusion.
-/

noncomputable section

namespace BookProof.FockOneParticleGap

open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

/-! ## 1. The free (diagonal) one-particle Hamiltonian -/

/-- The one-particle matrix of an operator diagonal in the chosen basis, with eigenvalues
`e k`: `⟪e_j, h e_k⟫ = δ_{jk} e_k`.  This is `h₊` written in a basis diagonalizing it. -/
def diagCol (e : ℕ → ℝ) : ℕ → (ℕ →₀ ℂ) := fun k => Finsupp.single k ((e k : ℝ) : ℂ)

/-- The one-particle matrix of the identity, whose second quantization is the number
operator `N`. -/
def numberCol : ℕ → (ℕ →₀ ℂ) := diagCol (fun _ => 1)

/-- The total number of quanta of a configuration. -/
def confNumber (β : Conf) : ℕ := ∑ k ∈ β.support, β k

/-- The energy of a configuration for the diagonal one-particle Hamiltonian:
`E(β) = Σ_k β_k e_k`. -/
def confEnergy (e : ℕ → ℝ) (β : Conf) : ℝ := ∑ k ∈ β.support, (β k : ℝ) * e k

/-- The Fock vacuum, as an element of the algebraic Fock space. -/
def vac : FockAlg := Finsupp.single (0 : Conf) (1 : ℂ)

theorem confNumber_zero : confNumber (0 : Conf) = 0 := by
  simp [confNumber]

theorem confEnergy_zero (e : ℕ → ℝ) : confEnergy e (0 : Conf) = 0 := by
  simp [confEnergy]

theorem confEnergy_one (β : Conf) : confEnergy (fun _ => 1) β = (confNumber β : ℝ) := by
  simp [confEnergy, confNumber]

theorem confNumber_pos {β : Conf} (h : β ≠ 0) : 1 ≤ confNumber β := by
  classical
  obtain ⟨k, hk⟩ : ∃ k, β k ≠ 0 := by
    by_contra hc
    push_neg at hc
    exact h (Finsupp.ext fun k => by simpa using hc k)
  have hmem : k ∈ β.support := Finsupp.mem_support_iff.mpr hk
  have hle : β k ≤ confNumber β :=
    Finset.single_le_sum (f := fun k => β k) (fun _ _ => Nat.zero_le _) hmem
  omega

theorem confEnergy_single (e : ℕ → ℝ) (k : ℕ) :
    confEnergy e (Finsupp.single k 1) = e k := by
  classical
  have hsupp : (Finsupp.single k 1 : Conf).support = {k} :=
    Finsupp.support_single_ne_zero k one_ne_zero
  simp [confEnergy, hsupp]

theorem confEnergy_add_const (e : ℕ → ℝ) (mu : ℝ) (β : Conf) :
    confEnergy (fun k => e k + mu) β = confEnergy e β + mu * (confNumber β : ℝ) := by
  classical
  simp only [confEnergy, confNumber, Nat.cast_sum, Finset.mul_sum, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun k _ => by ring

/-- **Every non-vacuum configuration has energy at least `μ`** when every one-particle
energy is at least `μ ≥ 0`. -/
theorem le_confEnergy {e : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (he : ∀ k, mu ≤ e k)
    {β : Conf} (hβ : β ≠ 0) : mu ≤ confEnergy e β := by
  classical
  have hstep : mu * (confNumber β : ℝ) ≤ confEnergy e β := by
    rw [confEnergy, confNumber, Nat.cast_sum, Finset.mul_sum]
    refine Finset.sum_le_sum fun k _ => ?_
    have hk : (0 : ℝ) ≤ (β k : ℝ) := by positivity
    nlinarith [he k]
  have h1 : (1 : ℝ) ≤ (confNumber β : ℝ) := by exact_mod_cast confNumber_pos hβ
  nlinarith

theorem confEnergy_nonneg {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) (β : Conf) :
    0 ≤ confEnergy e β :=
  Finset.sum_nonneg fun k _ => mul_nonneg (by positivity) (he k)

/-! ## 2. The second quantization of a diagonal one-particle Hamiltonian -/

theorem creVec_diagCol (e : ℕ → ℝ) (k : ℕ) (x : FockAlg) :
    creVec (diagCol e k) x = ((e k : ℝ) : ℂ) • creA k x := by
  classical
  rw [creVec_apply]
  by_cases h : ((e k : ℝ) : ℂ) = 0
  · rw [show (diagCol e k) = 0 by simp [diagCol, h]]
    simp [h]
  · rw [show (diagCol e k).support = {k} from Finsupp.support_single_ne_zero k h]
    simp [diagCol]

theorem creA_annA_single (k : ℕ) (β : Conf) (c : ℂ) :
    creA k (annA k (Finsupp.single β c)) = ((β k : ℝ) : ℂ) • Finsupp.single β c := by
  rw [annA_single]
  by_cases hk : β k = 0
  · simp [hk]
  · have h1 : 1 ≤ β k := Nat.one_le_iff_ne_zero.mpr hk
    rw [map_smul, creA_single, up_dn k h1]
    have hcast : ((dn k β) k : ℝ) + 1 = (β k : ℝ) := by
      rw [dn_self, Nat.cast_sub (R := ℝ) h1]; ring
    rw [hcast, smul_smul, Finsupp.smul_single, Finsupp.smul_single]
    congr 1
    have h2 : (Real.sqrt (β k) : ℂ) * (Real.sqrt (β k) : ℂ) = ((β k : ℝ) : ℂ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
    simp only [smul_eq_mul]
    calc c * (Real.sqrt (β k) : ℂ) * (Real.sqrt (β k) : ℂ)
        = c * ((Real.sqrt (β k) : ℂ) * (Real.sqrt (β k) : ℂ)) := by ring
      _ = ((β k : ℝ) : ℂ) * c := by rw [h2]; ring

/-- **The second quantization of a diagonal one-particle Hamiltonian is diagonal**, with
eigenvalue the configuration energy. -/
theorem dGamma_diagCol_single (e : ℕ → ℝ) (β : Conf) (c : ℂ) :
    dGamma (diagCol e) (Finsupp.single β c)
      = ((confEnergy e β : ℝ) : ℂ) • Finsupp.single β c := by
  classical
  rw [dGamma_single]
  have hterm : ∀ k ∈ β.support,
      creVec (diagCol e k) (annA k (Finsupp.single β (1 : ℂ)))
        = (((β k : ℝ) * e k : ℝ) : ℂ) • Finsupp.single β (1 : ℂ) := by
    intro k _
    rw [creVec_diagCol, creA_annA_single, smul_smul]
    push_cast
    ring_nf
  rw [Finset.sum_congr rfl hterm, ← Finset.sum_smul,
    show (∑ k ∈ β.support, (((β k : ℝ) * e k : ℝ) : ℂ)) = ((confEnergy e β : ℝ) : ℂ) by
      rw [confEnergy]; push_cast; ring,
    smul_smul, Finsupp.smul_single, Finsupp.smul_single]
  congr 1
  simp [mul_comm]

/-- The coordinatewise form of `dGamma_diagCol_single`. -/
theorem dGamma_diagCol_apply (e : ℕ → ℝ) (u : FockAlg) (β : Conf) :
    dGamma (diagCol e) u β = ((confEnergy e β : ℝ) : ℂ) * u β := by
  classical
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
    rw [map_add, Finsupp.add_apply, hf, hg, Finsupp.add_apply]
    ring
  | single γ c =>
    rw [dGamma_diagCol_single]
    by_cases h : β = γ
    · subst h; simp
    · simp [h]

/-- **The vacuum is annihilated**: `dΓ(h₊) Ω = 0`. -/
theorem dGamma_diagCol_vac (e : ℕ → ℝ) : dGamma (diagCol e) vac = 0 := by
  rw [vac, dGamma_diagCol_single, confEnergy_zero]
  simp

/-- **The number operator annihilates the vacuum**: `N Ω = 0`. -/
theorem numberOp_vac : dGamma numberCol vac = 0 := dGamma_diagCol_vac _

/-- **A one-particle state is an eigenvector with the one-particle energy.** -/
theorem dGamma_diagCol_one_particle (e : ℕ → ℝ) (k : ℕ) :
    dGamma (diagCol e) (Finsupp.single (Finsupp.single k 1) (1 : ℂ))
      = ((e k : ℝ) : ℂ) • Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by
  rw [dGamma_diagCol_single, confEnergy_single]

/-- **The free number-operator shift** `dΓ(h₊) = dΓ(h − E₀I) + μ N`: shifting every
one-particle energy by `μ` adds `μ` times the number operator.  The vacuum is unchanged
(`numberOp_vac`), while every non-vacuum state gains at least `μ`. -/
theorem dGamma_diagCol_shift (e : ℕ → ℝ) (mu : ℝ) (u : FockAlg) :
    dGamma (diagCol fun k => e k + mu) u
      = dGamma (diagCol e) u + ((mu : ℝ) : ℂ) • dGamma numberCol u := by
  refine Finsupp.ext fun β => ?_
  rw [Finsupp.add_apply, Finsupp.smul_apply, dGamma_diagCol_apply, dGamma_diagCol_apply,
    numberCol, dGamma_diagCol_apply, confEnergy_add_const, confEnergy_one]
  push_cast
  simp only [smul_eq_mul]
  ring

/-! ## 3. The Fock gap of a free second quantization -/

theorem conj_mul_re (z : ℂ) : ((starRingEnd ℂ) z * z).re = ‖z‖ ^ 2 := by
  have h : (starRingEnd ℂ) z * z = ((Complex.normSq z : ℝ) : ℂ) := by
    rw [mul_comm]; exact Complex.mul_conj z
  rw [h, Complex.ofReal_re, Complex.normSq_eq_norm_sq]

theorem norm_toLp_sq (u : FockAlg) : ‖toLp u‖ ^ 2 = ∑ α ∈ u.support, ‖u α‖ ^ 2 := by
  have h1 : (inner ℂ (toLp u) (toLp u) : ℂ).re = ‖toLp u‖ ^ 2 := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  rw [← h1, inner_toLp u u, Complex.re_sum]
  exact Finset.sum_congr rfl fun α _ => conj_mul_re (u α)

/-- The Fock energy of a finite-particle state is the weighted sum of the configuration
energies. -/
theorem re_inner_dGamma_diagCol (e : ℕ → ℝ) (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re
      = ∑ α ∈ u.support, confEnergy e α * ‖u α‖ ^ 2 := by
  rw [inner_toLp u (dGamma (diagCol e) u), Complex.re_sum]
  refine Finset.sum_congr rfl fun α _ => ?_
  rw [dGamma_diagCol_apply,
    show (starRingEnd ℂ) (u α) * (((confEnergy e α : ℝ) : ℂ) * u α)
        = ((confEnergy e α : ℝ) : ℂ) * ((starRingEnd ℂ) (u α) * u α) by ring,
    Complex.re_ofReal_mul, conj_mul_re]

/-- **The free `dΓ` lift, quadratic-form version.**  If every one-particle energy is at
least `μ ≥ 0`, then every finite-particle state orthogonal to the vacuum has Fock energy
at least `μ‖u‖²`. -/
theorem fock_gap_quadForm {e : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (he : ∀ k, mu ≤ e k)
    {u : FockAlg} (h0 : u 0 = 0) :
    mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by
  rw [re_inner_dGamma_diagCol, norm_toLp_sq, Finset.mul_sum]
  refine Finset.sum_le_sum fun α hα => ?_
  have hα0 : α ≠ 0 := by
    rintro rfl
    exact (Finsupp.mem_support_iff.mp hα) h0
  exact mul_le_mul_of_nonneg_right (le_confEnergy hmu he hα0) (sq_nonneg ‖u α‖)

/-- The vacuum component of a finite-particle state is its inner product with `Ω`. -/
theorem inner_vac (u : FockAlg) : (inner ℂ (toLp vac) (toLp u) : ℂ) = u 0 := by
  classical
  have hs : vac.support = {(0 : Conf)} := Finsupp.support_single_ne_zero _ one_ne_zero
  rw [inner_toLp vac u, hs]
  simp [vac]

/-- **The free `dΓ` lift on the Fock space.**  With `h₊ ≥ μ I ≥ 0` in the diagonalizing
basis: the vacuum has energy `0`, and every vacuum-orthogonal finite-occupation state has
energy at least `μ‖x‖²`. -/
theorem fock_gap_of_one_particle_gap {e : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu)
    (he : ∀ k, mu ≤ e k) :
    dGammaOp (diagCol e) (fockEquiv vac) = 0 ∧
      ∀ x : lpFiniteModes Conf, (inner ℂ (toLp vac) ((x : Fock)) : ℂ) = 0 →
        mu * ‖(x : Fock)‖ ^ 2 ≤ quadForm (dGammaOp (diagCol e)) x := by
  constructor
  · rw [coe_dGammaOp, LinearEquiv.symm_apply_apply, dGamma_diagCol_vac]
    exact map_zero toLpL
  · intro x hx
    rw [quadForm, coe_dGammaOp, coe_fockEquiv_symm x]
    rw [coe_fockEquiv_symm x] at hx
    exact fock_gap_quadForm hmu he (by rwa [inner_vac] at hx)

/-- **Sharpness of the lift.**  The one-particle energies really are Fock energies: the
state `a†(e_k) Ω` has energy exactly `e k`.  With `fock_gap_of_one_particle_gap` this says
that the Fock gap of a free second quantization *is* the lowest one-particle energy. -/
theorem fock_energy_one_particle (e : ℕ → ℝ) (k : ℕ) :
    (inner ℂ (toLp (Finsupp.single (Finsupp.single k 1) (1 : ℂ)))
        (toLp (dGamma (diagCol e) (Finsupp.single (Finsupp.single k 1) (1 : ℂ)))) : ℂ).re
      = e k := by
  classical
  rw [re_inner_dGamma_diagCol,
    show (Finsupp.single (Finsupp.single k 1) (1 : ℂ)).support = {Finsupp.single k 1} from
      Finsupp.support_single_ne_zero _ one_ne_zero]
  simp [confEnergy_single]

/-! ### The Fock gap *is* the one-particle edge -/

/-- The set of energies of the non-vacuum configurations. -/
def nonvacuumEnergies (e : ℕ → ℝ) : Set ℝ :=
  {x | ∃ β : Conf, β ≠ 0 ∧ x = confEnergy e β}

theorem iInf_le_confEnergy {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) {β : Conf} (hβ : β ≠ 0) :
    (⨅ k, e k) ≤ confEnergy e β := by
  classical
  have hbdd : BddBelow (Set.range e) := ⟨0, by rintro x ⟨k, rfl⟩; exact he k⟩
  obtain ⟨k0, hk0⟩ : ∃ k, k ∈ β.support := by
    by_contra hc
    push_neg at hc
    exact hβ (Finsupp.ext fun k => by
      simpa using Finsupp.notMem_support_iff.mp (hc k))
  have hterm : e k0 ≤ (β k0 : ℝ) * e k0 := by
    have h1 : (1 : ℝ) ≤ (β k0 : ℝ) := by
      have h2 : 1 ≤ β k0 := Nat.one_le_iff_ne_zero.mpr (Finsupp.mem_support_iff.mp hk0)
      exact_mod_cast h2
    nlinarith [he k0]
  have hsum : (β k0 : ℝ) * e k0 ≤ confEnergy e β :=
    Finset.single_le_sum (f := fun k => (β k : ℝ) * e k)
      (fun k _ => mul_nonneg (by positivity) (he k)) hk0
  exact le_trans (le_trans (ciInf_le hbdd k0) hterm) hsum

/-- **The Fock gap of a free second quantization is exactly the one-particle edge.**  For a
nonnegative one-particle spectrum, the infimum of the non-vacuum Fock energies is the
infimum of the one-particle energies: the lower bound is `iInf_le_confEnergy`, and it is
attained in the limit by the one-particle states `a†(e_k) Ω`. -/
theorem sInf_nonvacuumEnergies {e : ℕ → ℝ} (he : ∀ k, 0 ≤ e k) :
    sInf (nonvacuumEnergies e) = ⨅ k, e k := by
  classical
  have hbdd : BddBelow (nonvacuumEnergies e) := by
    refine ⟨0, ?_⟩
    rintro x ⟨β, -, rfl⟩
    exact confEnergy_nonneg he _
  have hmem : ∀ k, e k ∈ nonvacuumEnergies e :=
    fun k => ⟨Finsupp.single k 1, by simp, (confEnergy_single e k).symm⟩
  refine le_antisymm (le_ciInf fun k => csInf_le hbdd (hmem k)) ?_
  refine le_csInf ⟨e 0, hmem 0⟩ ?_
  rintro x ⟨β, hβ, rfl⟩
  exact iInf_le_confEnergy he hβ

/-! ## 4. Nested certified bands determine the one-particle edge -/

/-- **The nested-band conclusion.**  If every certified interval `[lo m, hi m]` encloses
the same number `lam` — the lowest positive one-particle energy of the *fixed* selected
operator — and the widths vanish, then the certified endpoints converge to `lam`. -/
theorem band_endpoints_tendsto {lo hi : ℕ → ℝ} {lam : ℝ}
    (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0)) :
    Tendsto lo atTop (𝓝 lam) ∧ Tendsto hi atTop (𝓝 lam) := by
  have hlo : Tendsto lo atTop (𝓝 lam) := by
    have hsq : ∀ m, lam - (hi m - lo m) ≤ lo m := fun m => by
      have := (hmem m).2; linarith
    have hup : ∀ m, lo m ≤ lam := fun m => (hmem m).1
    have h1 : Tendsto (fun m => lam - (hi m - lo m)) atTop (𝓝 (lam - 0)) :=
      tendsto_const_nhds.sub hwidth
    rw [sub_zero] at h1
    exact tendsto_of_tendsto_of_tendsto_of_le_of_le h1 tendsto_const_nhds hsq hup
  refine ⟨hlo, ?_⟩
  have h2 : Tendsto (fun m => (hi m - lo m) + lo m) atTop (𝓝 (0 + lam)) := hwidth.add hlo
  simpa using h2

/-- A single certified band with a positive lower end already forces the enclosed edge to
be at least that lower end. -/
theorem le_of_band {lo hi : ℕ → ℝ} {lam mu : ℝ} (hmem : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    {m : ℕ} (hlo : mu ≤ lo m) : mu ≤ lam :=
  le_trans hlo (hmem m).1

/-! ## 5. The composition: certified bands ⟹ Fock mass gap (free case) -/

/-- **The composition theorem.**  Hypotheses, all explicit:

* `hband` — every certified interval encloses `lam`, the lowest positive one-particle
  energy of the fixed selected operator `h₊` (the analytic enclosure obligation);
* `hwidth` — the certified widths vanish;
* `hlo` — one certified interval has lower end `≥ μ`;
* `hedge` — `lam` really is a lower bound for the one-particle spectrum in the
  diagonalizing basis, i.e. `h₊ ≥ lam I`;
* `hmu` — `0 ≤ μ`.

Conclusions: the certified lower endpoints converge to `lam`, `μ ≤ lam`, the vacuum has
Fock energy `0`, and every vacuum-orthogonal finite-particle state has Fock energy at
least `μ‖u‖²`. -/
theorem fock_mass_gap_of_certified_bands {e : ℕ → ℝ} {lo hi : ℕ → ℝ} {lam mu : ℝ}
    (hmu : 0 ≤ mu) (hband : ∀ m, lam ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) (hedge : ∀ k, lam ≤ e k) :
    Tendsto lo atTop (𝓝 lam) ∧ mu ≤ lam ∧ dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by
  refine ⟨(band_endpoints_tendsto hband hwidth).1, le_of_band hband hlo,
    dGamma_diagCol_vac e, fun u h0 => ?_⟩
  exact fock_gap_quadForm hmu (fun k => le_trans (le_of_band hband hlo) (hedge k)) h0

/-- **The emitted `g = 2, m = 4` certificate, read as a one-particle enclosure.**  The
certificate number `1.932` is a *truncated* certified gap; if — and only if — its band is
known to enclose the lowest positive one-particle energy `lam` of the fixed selected
operator `h₊`, and `h₊ ≥ lam I` in the diagonalizing basis, then the free second
quantization has vacuum energy `0` and a Fock gap of at least `1.932`.  The enclosure is a
hypothesis, not a conclusion. -/
theorem qcdG2M4_fock_gap_of_one_particle_enclosure {e : ℕ → ℝ} {lo hi : ℕ → ℝ} {lam : ℝ}
    (hband : ∀ m, lam ∈ Set.Icc (lo m) (hi m)) {m₀ : ℕ}
    (hlo : (1.932 : ℝ) ≤ lo m₀) (hedge : ∀ k, lam ≤ e k) :
    (1.932 : ℝ) ≤ lam ∧ dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (1.932 : ℝ) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by
  have hlam : (1.932 : ℝ) ≤ lam := le_of_band hband hlo
  refine ⟨hlam, dGamma_diagCol_vac e, fun u h0 => ?_⟩
  exact fock_gap_quadForm (by norm_num) (fun k => le_trans hlam (hedge k)) h0

/-- The number `1.932` above is exactly the lower end of the recorded `g = 2, m = 4`
certificate of `ChapterSirkCertifiedGap`. -/
theorem qcdG2M4_lower_eq : BookProof.SirkCertifiedGap.qcdG2M4.lower = 1.932 :=
  BookProof.SirkCertifiedGap.qcdG2M4_lower

/-! ## 6. Reading a parity-labelled certificate as a one-particle enclosure

The emitted certificate is labelled by parity sectors.  Using it for the `dGamma` theorems
above requires the **representation translation**: that the even sector ground value is the
outer-vacuum energy and the odd sector ground value is the lowest one-particle energy.  That
translation is a property of the concrete truncation, not a generic fact, so it appears
below as two explicit hypotheses; what the theorem adds is that *once they hold*, the
certified parity lower bound is a lower bound for the one-particle edge, and may then be
fed to `fock_mass_gap_of_certified_bands`. -/

section ParityTranslation

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

open BookProof.SirkCertifiedGap

/-- **The parity-to-one-particle translation.**  Hypotheses: the certificate's two numbers
are the sector Ritz difference and the assembled width (`hgap`, `hwidth`), the two sector
enclosures hold (`hEven`, `hOdd`), and the *representation translation* holds — the even
sector ground value is the outer-vacuum energy `0` (`hvac`) and the odd sector ground value is
the one-particle edge `lam` (`hone`).  Conclusion: the certified lower bound is a lower
bound for the one-particle edge.  Nothing here asserts the translation itself. -/
theorem one_particle_edge_ge_of_parity_certificate {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO lam : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hvac : sectorGround T P 1 = 0) (hone : sectorGround T P (-1) = lam) :
    c.lower ≤ lam := by
  have h := gap_ge_of_certificate (T := T) (P := P) c hgap hwidth hEven hOdd
  rw [hvac, hone] at h
  linarith

end ParityTranslation

/-! ## 7. From the spectral edge of an actual one-particle operator to the Fock gap

The sections above take the one-particle data as the sequence of eigenvalues `e`.  This
section starts instead from a *bounded self-adjoint operator* `A` on a Hilbert space with a
Hilbert basis of eigenvectors — the situation the shift-inverted Hashimoto/SIRK route
produces — and reads its eigenvalues off the basis.  The certified bands are then required
to enclose `sInf (spectrum ℝ A)`, the actual spectral edge, and the conclusion is the Fock
gap of the free second quantization. -/

section OperatorEdge

open BookProof.ChapterSirkRitzSpectrum

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- A lower bound for the spectrum of a bounded self-adjoint operator is a lower bound for
its eigenvalues along any Hilbert basis of eigenvectors. -/
theorem le_eigenvalue_of_le_spectrum {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (b k) = ((e k : ℝ) : ℂ) • b k) {mu : ℝ}
    (hspec : ∀ lam ∈ spectrum ℝ A, mu ≤ lam) : ∀ k, mu ≤ e k := by
  intro k
  have hray := (le_rayleigh_iff_le_spectrum A hA mu).mpr hspec (b k)
  have hnorm : ‖b k‖ = 1 := b.orthonormal.1 k
  have hinner : (inner ℂ (b k) (A (b k)) : ℂ) = ((e k : ℝ) : ℂ) := by
    rw [heig k, inner_smul_right, inner_self_eq_norm_sq_to_K, hnorm]
    norm_num
  rw [hinner, hnorm] at hray
  simpa using hray

/-- **The `dGamma` lift from the spectral edge of the one-particle operator.**  If the
spectrum of the bounded self-adjoint one-particle operator `A` is bounded below by `μ ≥ 0`
and `b` is a Hilbert basis of eigenvectors with eigenvalues `e`, then the free second
quantization built from `e` annihilates the vacuum and has Fock gap at least `μ`. -/
theorem fock_gap_of_operator_spectral_edge {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (b k) = ((e k : ℝ) : ℂ) • b k) {mu : ℝ} (hmu : 0 ≤ mu)
    (hspec : ∀ lam ∈ spectrum ℝ A, mu ≤ lam) :
    dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re :=
  ⟨dGamma_diagCol_vac e,
    fun _ h0 => fock_gap_quadForm hmu (le_eigenvalue_of_le_spectrum hA heig hspec) h0⟩

/-- **The continuum-style transfer, for a bounded self-adjoint one-particle operator.**
Certified bands that enclose the actual spectral edge `sInf (spectrum ℝ A)` and shrink to a
point determine it; if one band has lower end `μ ≥ 0`, the edge is at least `μ` and the free
second quantization has vacuum energy `0` and Fock gap at least `μ`.  The enclosure of the
edge by the certified bands is a hypothesis. -/
theorem fock_mass_gap_of_certified_bands_operator {A : F →L[ℂ] F} (hA : IsSelfAdjoint A)
    {b : HilbertBasis ℕ ℂ F} {e : ℕ → ℝ}
    (heig : ∀ k, A (b k) = ((e k : ℝ) : ℂ) • b k) {lo hi : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu)
    (hband : ∀ m, sInf (spectrum ℝ A) ∈ Set.Icc (lo m) (hi m))
    (hwidth : Tendsto (fun m => hi m - lo m) atTop (𝓝 0))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) :
    Tendsto lo atTop (𝓝 (sInf (spectrum ℝ A))) ∧ mu ≤ sInf (spectrum ℝ A) ∧
      dGamma (diagCol e) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by
  have hedge : mu ≤ sInf (spectrum ℝ A) := le_of_band hband hlo
  have hspec : ∀ lam ∈ spectrum ℝ A, mu ≤ lam := fun lam hlam =>
    le_trans hedge (csInf_le (spectrum_real_bddBelow A hA) hlam)
  obtain ⟨hvac, hgap⟩ := fock_gap_of_operator_spectral_edge hA heig hmu hspec
  exact ⟨(band_endpoints_tendsto hband hwidth).1, hedge, hvac, hgap⟩

end OperatorEdge

end BookProof.FockOneParticleGap

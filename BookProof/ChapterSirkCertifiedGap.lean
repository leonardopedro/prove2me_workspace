import Mathlib
import BookProof.ChapterSirkFinitePrecision

/-!
# Chapter SirkCertifiedGap — the certified mass gap of the truncated Hamiltonian (T6, T7)

`CONSOLIDATED_PLAN.md` §13.3 (T6, T7 and the nested-selection lemma),
`MASS_GAP_CERTIFIED.md` §3.3/§3.4.  With the finite-precision layer of
`ChapterSirkFinitePrecision` in place, this chapter proves the certified-gap theorem
for the **truncated** (Krylov/Galerkin) Hamiltonian `H_m` — the object the kernel
diagonalises — together with the stopping rule that makes a computation a proof.

**Object of record (no lattice).**  The Hamiltonian of the mass-gap formalization
is the 3D **gauge-fixed nested-Fock QYM Hamiltonian** `qcd_ym_hamiltonian(g)`
(`H_final = ½π² + ½B²`), all numerics running the SIRK–Hashimoto algorithm.  The
abstract theorem below is stated for *any* symmetric involution commuting with `H`
— on the gauge-fixed Hamiltonian of record that involution is the reflection
`R : (A₀, A₁) → (−A₁, −A₀)`, an exact `Z₂` for all `g` (verified numerically to
`1e-16`); the occupation parity of the lattice-era fixture is not a symmetry at
`g > 0` and is retained only as a historical instance.

**Honesty boundary (fixed in `CONSOLIDATED_PLAN.md` §13.1).**  Every statement here
is about the finite-dimensional operator.  The continuum Millennium claim needs a
gap-preserving norm-resolvent convergence of the truncation family; that leg is *not*
proved here and is not assumed anywhere.

## The structure of the argument

The sector involution `P` is an exact symmetry: it is a symmetric involution commuting
with `H` (for the gauge-fixed QYM Hamiltonian of record: the reflection `R`), so the space
splits into the two sector eigenspaces `paritySector P (±1)`, each
`H`-invariant.  The observable of §3.3 is the difference of the two *sector ground
energies* — the infimum of the Rayleigh quotient over unit vectors of a sector,
`sectorGround`.  The certificate delivers, for each sector, a computed Ritz value `θˢ`
and a width `δˢ`; the theorem `certified_parity_gap` turns the two enclosures into a
lower bound for the gap, and `certified_parity_gap_pos` into a *positive* gap once the
certified intervals separate.

## Deliverables

* `paritySector`, `mem_paritySector`, `paritySector_invariant`, `sectorRestrict`,
  `sectorRestrict_isSymmetric` — **the parity split is exact**: the sectors are
  invariant subspaces and the restricted operators are symmetric.
* `sectorRayleighSet`, `sectorGround` — the sector ground energy, with
  `sectorRayleighSet_bddBelow`, the unconditional Ritz upper bound
  `sectorGround_le_rayleigh`, the lower bound `le_sectorGround`, and the spectral
  identification `sectorGround_eq_inf_eigenvalues`.
* **T6** `certified_parity_gap`: `λᵒ₀ − λᵉ₀ ≥ θᵒ₀ − θᵉ₀ − (δᵒ + δᵉ)`, with
  `certified_parity_gap_pos` (a proof-carrying *positive* gap for the truncated
  operator) and `certified_parity_gap_of_data`, which assembles the bound from the
  raw certificate data (a computed even-sector Ritz vector and a certified
  odd-sector lower bound), and `certified_parity_gap_strong_coupling`, the same bound
  written against the analytic strong-coupling value `g²/2` with the excluded `O(g⁴)`
  magnetic correction kept explicit.
* `sectorGround_ge_temple` — Temple's inequality inside a sector: the honest route to
  the odd-sector lower bound that T6 consumes.
* **The nested-selection lemma** `resolvent_commutes_parity` /
  `resolvent_mapsTo_paritySector`: the resolvent of the operator restricted to a
  sector is the resolvent of the restriction — the block fact behind the two-level
  (nested Fock) selection.
* **T7** the stopping rule: `certifiedGap` and `certifiedGap_tendsto`,
  `certifiedGap_eventually_pos` (completeness: if the true sector gap is positive the
  certificate eventually detects it) and `certifiedGap_sound` (soundness: a positive
  certified value *proves* a positive gap, and nothing is ever claimed that was not
  certified).

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

namespace BookProof.SirkCertifiedGap

open scoped InnerProductSpace
open Finset Filter Topology
open BookProof.SirkFinitePrecision

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

/-! ## 1. The parity sectors: the split is exact -/

/-- The `s`-eigenspace of the sector involution `P` (`s = ±1`; on the gauge-fixed
QYM Hamiltonian of record, `P` is the reflection `R: (A₀,A₁) → (−A₁,−A₀)`). -/
def paritySector (P : E →ₗ[ℂ] E) (s : ℝ) : Submodule ℂ E where
  carrier := {x | P x = (s : ℂ) • x}
  add_mem' := by
    intro a b ha hb
    simp only [Set.mem_setOf_eq] at *
    rw [map_add, ha, hb, smul_add]
  zero_mem' := by simp
  smul_mem' := by
    intro c x hx
    simp only [Set.mem_setOf_eq] at *
    rw [map_smul, hx, smul_comm]

omit [FiniteDimensional ℂ E] in
@[simp]
theorem mem_paritySector {P : E →ₗ[ℂ] E} {s : ℝ} {x : E} :
    x ∈ paritySector P s ↔ P x = (s : ℂ) • x := Iff.rfl

omit [FiniteDimensional ℂ E] in
/-- **The parity split is exact**: a sector is invariant under any operator commuting
with the parity. -/
theorem paritySector_invariant {T P : E →ₗ[ℂ] E} {s : ℝ} (hcomm : ∀ x, T (P x) = P (T x)) :
    ∀ x ∈ paritySector P s, T x ∈ paritySector P s := by
  intro x hx
  rw [mem_paritySector] at hx ⊢
  rw [← hcomm, hx, map_smul]

/-- The restriction of `T` to a parity sector. -/
def sectorRestrict (T P : E →ₗ[ℂ] E) (s : ℝ) (hcomm : ∀ x, T (P x) = P (T x)) :
    paritySector P s →ₗ[ℂ] paritySector P s :=
  T.restrict (paritySector_invariant hcomm)

omit [FiniteDimensional ℂ E] in
@[simp]
theorem sectorRestrict_coe {T P : E →ₗ[ℂ] E} {s : ℝ} (hcomm : ∀ x, T (P x) = P (T x))
    (y : paritySector P s) : ((sectorRestrict T P s hcomm) y : E) = T (y : E) := rfl

omit [FiniteDimensional ℂ E] in
/-- The restriction of a symmetric operator to a parity sector is symmetric. -/
theorem sectorRestrict_isSymmetric {T P : E →ₗ[ℂ] E} {s : ℝ}
    (hcomm : ∀ x, T (P x) = P (T x)) (hT : T.IsSymmetric) :
    (sectorRestrict T P s hcomm).IsSymmetric := by
  intro x y
  simpa [sectorRestrict, Submodule.coe_inner] using hT x.val y.val

omit [FiniteDimensional ℂ E] in
/-- The Rayleigh quotient of the restriction is the ambient Rayleigh quotient. -/
theorem rayleigh_sectorRestrict {T P : E →ₗ[ℂ] E} {s : ℝ} (hcomm : ∀ x, T (P x) = P (T x))
    (y : paritySector P s) : rayleigh (sectorRestrict T P s hcomm) y = rayleigh T (y : E) := by
  simp [rayleigh, Submodule.coe_inner]

/-! ## 2. The sector ground energy -/

/-- The Rayleigh quotients of the unit vectors of the sector `s`. -/
def sectorRayleighSet (T P : E →ₗ[ℂ] E) (s : ℝ) : Set ℝ :=
  {r | ∃ x : E, ‖x‖ = 1 ∧ x ∈ paritySector P s ∧ r = rayleigh T x}

/-- The sector ground energy `λˢ₀`: the infimum of the Rayleigh quotient over the unit
vectors of the sector.  This is the quantity the SIRK sector solve approximates from
above. -/
def sectorGround (T P : E →ₗ[ℂ] E) (s : ℝ) : ℝ := sInf (sectorRayleighSet T P s)

theorem sectorRayleighSet_bddBelow {T : E →ₗ[ℂ] E} (P : E →ₗ[ℂ] E) (s : ℝ)
    (hT : T.IsSymmetric) : BddBelow (sectorRayleighSet T P s) := by
  classical
  rcases Set.eq_empty_or_nonempty (sectorRayleighSet T P s) with h | ⟨r, x, hx, -, -⟩
  · rw [h]; exact bddBelow_empty
  · have hx0 : x ≠ 0 := by
      intro h; rw [h] at hx; simp at hx
    have hne := index_nonempty hT rfl hx0
    refine ⟨univ.inf' hne fun i => hT.eigenvalues (rfl : Module.finrank ℂ E = _) i, ?_⟩
    rintro r ⟨y, hy, -, rfl⟩
    exact ground_le_rayleigh hT rfl hy fun i => Finset.inf'_le _ (mem_univ i)

/-- **The Rayleigh–Ritz upper bound in a sector.**  A computed Ritz value of a unit
vector of the sector is never below the sector ground energy — the unconditionally
sound half of the certified bracket. -/
theorem sectorGround_le_rayleigh {T : E →ₗ[ℂ] E} {P : E →ₗ[ℂ] E} {s : ℝ}
    (hT : T.IsSymmetric) {x : E} (hx : ‖x‖ = 1) (hmem : x ∈ paritySector P s) :
    sectorGround T P s ≤ rayleigh T x :=
  csInf_le (sectorRayleighSet_bddBelow P s hT) ⟨x, hx, hmem, rfl⟩

omit [FiniteDimensional ℂ E] in
/-- A pointwise lower bound on the sector Rayleigh quotients bounds the sector ground
energy from below. -/
theorem le_sectorGround {T P : E →ₗ[ℂ] E} {s c : ℝ}
    (hne : (sectorRayleighSet T P s).Nonempty)
    (hlb : ∀ x : E, ‖x‖ = 1 → x ∈ paritySector P s → c ≤ rayleigh T x) :
    c ≤ sectorGround T P s := by
  refine le_csInf hne ?_
  rintro r ⟨x, hx, hmem, rfl⟩
  exact hlb x hx hmem

/-- The sector ground energy is the lowest eigenvalue of the restricted operator: the
sector infimum is attained, and it is a *spectral* quantity of the block. -/
theorem sectorGround_eq_inf_eigenvalues {T P : E →ₗ[ℂ] E} {s : ℝ}
    (hcomm : ∀ x, T (P x) = P (T x)) (hT : T.IsSymmetric)
    (hne : (univ : Finset (Fin (Module.finrank ℂ (paritySector P s)))).Nonempty) :
    sectorGround T P s
      = univ.inf' hne fun i =>
          (sectorRestrict_isSymmetric (s := s) hcomm hT).eigenvalues (rfl) i := by
  classical
  set S := sectorRestrict T P s hcomm with hS
  set hSym := sectorRestrict_isSymmetric (s := s) hcomm hT with hSymdef
  set b := hSym.eigenvectorBasis (rfl : Module.finrank ℂ (paritySector P s) = _) with hb
  set m := univ.inf' hne fun i => hSym.eigenvalues (rfl) i with hm
  -- the infimum is attained at an eigenvector
  obtain ⟨i0, -, hi0⟩ := Finset.exists_min_image univ (fun i => hSym.eigenvalues (rfl) i) hne
  have hmi0 : m = hSym.eigenvalues (rfl) i0 :=
    le_antisymm (Finset.inf'_le _ (mem_univ i0))
      (Finset.le_inf' hne _ fun i _ => hi0 i (mem_univ i))
  have hunit : ‖((b i0 : paritySector P s) : E)‖ = 1 := b.orthonormal.1 i0
  have hmem : ((b i0 : paritySector P s) : E) ∈ paritySector P s := (b i0).2
  have hray : rayleigh T ((b i0 : paritySector P s) : E) = hSym.eigenvalues (rfl) i0 := by
    have hR : rayleigh S (b i0) = rayleigh T ((b i0 : paritySector P s) : E) :=
      rayleigh_sectorRestrict hcomm (b i0)
    have happ : S (b i0) = (hSym.eigenvalues (rfl) i0 : ℂ) • b i0 :=
      hSym.apply_eigenvectorBasis (rfl) i0
    have : rayleigh S (b i0) = hSym.eigenvalues (rfl) i0 := by
      rw [rayleigh, happ, inner_smul_right]
      have hnb : (inner ℂ (b i0) (b i0) : ℂ) = 1 := by
        have := b.orthonormal.1 i0
        rw [inner_self_eq_norm_sq_to_K]
        simp [this]
      rw [hnb]
      simp
    rw [← hR, this]
  refine le_antisymm ?_ ?_
  · rw [hmi0, ← hray]
    exact sectorGround_le_rayleigh hT hunit hmem
  · refine le_sectorGround ⟨_, _, hunit, hmem, rfl⟩ ?_
    intro x hx hmemx
    have hxS : (⟨x, hmemx⟩ : paritySector P s) ≠ 0 := by
      intro h
      have : x = 0 := congrArg Subtype.val h
      rw [this] at hx; simp at hx
    have hnorm : ‖(⟨x, hmemx⟩ : paritySector P s)‖ = 1 := by simpa using hx
    have := ground_le_rayleigh hSym (rfl) hnorm
      (lam0 := m) (fun i => by rw [hm]; exact Finset.inf'_le _ (mem_univ i))
    rwa [rayleigh_sectorRestrict hcomm ⟨x, hmemx⟩] at this

/-- **Temple's inequality inside a sector.**  The honest route to the *lower* bound
for a sector ground energy that T6 consumes: with an a-priori separation constant `β`
for the restricted (block) operator, a computed unit vector `y` of the sector gives
`λˢ₀ ≥ θ − (‖H y‖² − θ²)/(β − θ)`. -/
theorem sectorGround_ge_temple {T P : E →ₗ[ℂ] E} {s : ℝ}
    (hcomm : ∀ x, T (P x) = P (T x)) (hT : T.IsSymmetric)
    {y : paritySector P s} (hy : ‖y‖ = 1)
    (hne : (univ : Finset (Fin (Module.finrank ℂ (paritySector P s)))).Nonempty)
    {β : ℝ}
    (hsep : ∀ i, (sectorRestrict_isSymmetric (s := s) hcomm hT).eigenvalues (rfl) i
        = sectorGround T P s
      ∨ β ≤ (sectorRestrict_isSymmetric (s := s) hcomm hT).eigenvalues (rfl) i)
    (hβ : rayleigh T (y : E) < β) :
    rayleigh T (y : E)
        - (‖T (y : E)‖ ^ 2 - rayleigh T (y : E) ^ 2) / (β - rayleigh T (y : E))
      ≤ sectorGround T P s := by
  classical
  set hSym := sectorRestrict_isSymmetric (s := s) hcomm hT with hSymdef
  have hground := sectorGround_eq_inf_eigenvalues hcomm hT hne
  have hlow : ∀ i, sectorGround T P s ≤ hSym.eigenvalues (rfl) i := by
    intro i
    rw [hground]
    exact Finset.inf'_le _ (mem_univ i)
  have hray : rayleigh (sectorRestrict T P s hcomm) y = rayleigh T (y : E) :=
    rayleigh_sectorRestrict hcomm y
  have hnorm : ‖(sectorRestrict T P s hcomm) y‖ = ‖T (y : E)‖ := by
    simp
  have := temple_lower_bound hSym (rfl) hy (lam0 := sectorGround T P s) (β := β)
    hsep hlow (by rwa [hray])
  rwa [hray, hnorm] at this

/-! ## 3. T6 — the certified-gap theorem -/

omit [FiniteDimensional ℂ E] in
/-- **T6, the certified-gap theorem (`MASS_GAP_CERTIFIED.md` §3.4).**  With `θᵉ₀, θᵒ₀`
the computed lowest Ritz values of the even/odd parity sectors and `δᵉ, δᵒ` the
certified widths of §4.4, the *sector gap* of the truncated Hamiltonian satisfies
`λᵒ₀ − λᵉ₀ ≥ θᵒ₀ − θᵉ₀ − (δᵒ + δᵉ)`.

The two hypotheses are exactly the two certified enclosures: the even-sector ground
energy is not above `θᵉ₀ + δᵉ` (the Rayleigh–Ritz upper bound, unconditional — see
`certified_parity_gap_of_data`) and the odd-sector ground energy is not below
`θᵒ₀ − δᵒ` (Temple, `sectorGround_ge_temple`, or the a-posteriori route). -/
theorem certified_parity_gap {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    thetaO - thetaE - (deltaO + deltaE) ≤ sectorGround T P (-1) - sectorGround T P 1 := by
  linarith

omit [FiniteDimensional ℂ E] in
/-- **A proof-carrying positive mass gap for the truncated operator.**  Once the two
certified intervals separate, the sector gap is positive. -/
theorem certified_parity_gap_pos {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hsep : 0 < thetaO - thetaE - (deltaO + deltaE)) :
    sectorGround T P 1 < sectorGround T P (-1) := by
  have := certified_parity_gap (T := T) (P := P) hEven hOdd
  linarith

/-- T6 assembled from the raw certificate data: a computed even-sector unit vector
with Rayleigh value `θᵉ` (which certifies the even-sector *upper* bound with no
further hypothesis) and a certified odd-sector lower bound. -/
theorem certified_parity_gap_of_data {T P : E →ₗ[ℂ] E} (hT : T.IsSymmetric)
    {vE : E} (hvE : ‖vE‖ = 1) (hvEmem : vE ∈ paritySector P 1)
    {thetaE thetaO deltaE deltaO : ℝ} (hthetaE : rayleigh T vE = thetaE) (hdE : 0 ≤ deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    thetaO - thetaE - (deltaO + deltaE) ≤ sectorGround T P (-1) - sectorGround T P 1 := by
  refine certified_parity_gap ?_ hOdd
  have := sectorGround_le_rayleigh (P := P) (s := 1) hT hvE hvEmem
  rw [hthetaE] at this
  linarith

omit [FiniteDimensional ℂ E] in
/-- **The strong-coupling form of T6.**  Writing the measured sector Ritz difference as
the analytic strong-coupling value `g²/2` plus a correction `corr` (the excluded `O(g⁴)`
magnetic term), the certified bound reads `gap ≥ g²/2 + corr − (δᵒ + δᵉ)`, with the
correction kept explicit rather than absorbed. -/
theorem certified_parity_gap_strong_coupling {T P : E →ₗ[ℂ] E}
    {thetaE thetaO deltaE deltaO g corr : ℝ}
    (hform : thetaO - thetaE = g ^ 2 / 2 + corr)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    g ^ 2 / 2 + corr - (deltaO + deltaE)
      ≤ sectorGround T P (-1) - sectorGround T P 1 := by
  have h := certified_parity_gap (T := T) (P := P) hEven hOdd
  rw [hform] at h
  linarith

/-- Every unit state of the odd sector has energy at least the certified gap above the
even-sector ground energy: the physical reading of T6. -/
theorem rayleigh_odd_ge_of_certified {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hT : T.IsSymmetric)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    {x : E} (hx : ‖x‖ = 1) (hmem : x ∈ paritySector P (-1)) :
    sectorGround T P 1 + (thetaO - thetaE - (deltaO + deltaE)) ≤ rayleigh T x := by
  have h1 : sectorGround T P (-1) ≤ rayleigh T x :=
    sectorGround_le_rayleigh (P := P) (s := -1) hT hx hmem
  have h2 := certified_parity_gap (T := T) (P := P) hEven hOdd
  linarith

/-! ## 4. The nested-selection lemma: resolvents respect the sectors -/

omit [FiniteDimensional ℂ E] in
/-- **The nested-selection (block) lemma.**  A two-sided inverse of `T − z` commutes
with any operator commuting with `T` — in particular with the sector involution
(the reflection `R` on the gauge-fixed QYM Hamiltonian of record).  This is
the finite-dimensional block fact behind the two-level (nested Fock) Friedrichs
selection: the resolvent of the outer operator restricted to a sector *is* the
resolvent of the restriction. -/
theorem resolvent_commutes_parity {T P R : E →ₗ[ℂ] E} {z : ℂ}
    (hcomm : ∀ x, T (P x) = P (T x))
    (hR1 : ∀ x, R (T x - z • x) = x) (hR2 : ∀ x, T (R x) - z • R x = x) (x : E) :
    R (P x) = P (R x) := by
  have hx : P x = T (P (R x)) - z • P (R x) := by
    have h1 : P (T (R x) - z • R x) = P x := by rw [hR2]
    rw [map_sub, map_smul, ← hcomm] at h1
    exact h1.symm
  rw [hx, hR1]

omit [FiniteDimensional ℂ E] in
/-- Consequently the resolvent maps each parity sector into itself. -/
theorem resolvent_mapsTo_paritySector {T P R : E →ₗ[ℂ] E} {z : ℂ} {s : ℝ}
    (hcomm : ∀ x, T (P x) = P (T x))
    (hR1 : ∀ x, R (T x - z • x) = x) (hR2 : ∀ x, T (R x) - z • R x = x)
    {x : E} (hx : x ∈ paritySector P s) : R x ∈ paritySector P s := by
  rw [mem_paritySector] at hx ⊢
  rw [← resolvent_commutes_parity hcomm hR1 hR2 x, hx, map_smul]

/-! ## 5. T7 — the observable and the stopping rule -/

/-- The certified lower bound delivered at Krylov dimension `m`:
`g(m) = θᵒ₀(m) − θᵉ₀(m) − (δᵒ(m) + δᵉ(m))`. -/
def certifiedGap (thetaE thetaO deltaE deltaO : ℕ → ℝ) (m : ℕ) : ℝ :=
  thetaO m - thetaE m - (deltaO m + deltaE m)

/-- **T7, convergence.**  If the sector Ritz values converge to the sector ground
energies and the certified widths vanish, the certified lower bound converges to the
true sector gap `μ = λᵒ₀ − λᵉ₀`. -/
theorem certifiedGap_tendsto {thetaE thetaO deltaE deltaO : ℕ → ℝ} {lamE lamO : ℝ}
    (hE : Tendsto thetaE atTop (𝓝 lamE)) (hO : Tendsto thetaO atTop (𝓝 lamO))
    (hdE : Tendsto deltaE atTop (𝓝 0)) (hdO : Tendsto deltaO atTop (𝓝 0)) :
    Tendsto (certifiedGap thetaE thetaO deltaE deltaO) atTop (𝓝 (lamO - lamE)) := by
  have h := ((hO.sub hE).sub (hdO.add hdE))
  simpa [certifiedGap] using h

/-- **T7, completeness.**  If the true sector gap is positive, the certificate detects
it: there is a finite threshold `m₀` beyond which the certified lower bound is
positive.  (The threshold is found algorithmically — the stopping rule is the
a-posteriori certificate itself, no a-priori spectral knowledge is used.) -/
theorem certifiedGap_eventually_pos {thetaE thetaO deltaE deltaO : ℕ → ℝ} {lamE lamO : ℝ}
    (hE : Tendsto thetaE atTop (𝓝 lamE)) (hO : Tendsto thetaO atTop (𝓝 lamO))
    (hdE : Tendsto deltaE atTop (𝓝 0)) (hdO : Tendsto deltaO atTop (𝓝 0))
    (hmu : 0 < lamO - lamE) :
    ∃ m0 : ℕ, ∀ m ≥ m0, 0 < certifiedGap thetaE thetaO deltaE deltaO m := by
  have h := certifiedGap_tendsto hE hO hdE hdO
  have hev := h.eventually (eventually_gt_nhds hmu)
  rcases (eventually_atTop.mp hev) with ⟨m0, hm0⟩
  exact ⟨m0, hm0⟩

omit [FiniteDimensional ℂ E] in
/-- **T7, soundness.**  A positive certified value at a single `m` is a *proof* that
the sector gap of the truncated Hamiltonian is positive — and is never larger than the
true gap.  Nothing is claimed that was not certified: when the certified value fails to
be positive the theorem says nothing about the gap. -/
theorem certifiedGap_sound {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℕ → ℝ} {m : ℕ}
    (hEven : sectorGround T P 1 ≤ thetaE m + deltaE m)
    (hOdd : thetaO m - deltaO m ≤ sectorGround T P (-1))
    (hpos : 0 < certifiedGap thetaE thetaO deltaE deltaO m) :
    certifiedGap thetaE thetaO deltaE deltaO m
        ≤ sectorGround T P (-1) - sectorGround T P 1
      ∧ sectorGround T P 1 < sectorGround T P (-1) := by
  refine ⟨certified_parity_gap hEven hOdd, ?_⟩
  exact certified_parity_gap_pos hEven hOdd hpos

/-! ## 6. Instantiating T6 from an emitted certificate

The kernel's certificate emitter delivers, per parity sector, a value `θ` and a width
`δ = residual + roundoff + enclosure`.  What the Lean side consumes is only the pair
(sector Ritz difference, assembled width) — no floating-point value is trusted, and no
numerical claim is *verified* here: the numbers below are the emitted data, and the
theorems are conditional on the enclosures the certificate asserts. -/

/-- The two numbers a gap certificate delivers: the measured sector ground-Ritz
difference `θᵒ₀ − θᵉ₀` and the assembled width `δᵒ + δᵉ` of `MASS_GAP_CERTIFIED.md`
§4.4. -/
structure GapCertificate where
  /-- The measured sector ground-Ritz difference `θᵒ₀ − θᵉ₀`. -/
  gap : ℝ
  /-- The assembled certified width `δᵒ + δᵉ`. -/
  width : ℝ
  /-- Widths are nonnegative. -/
  width_nonneg : 0 ≤ width

/-- The certified lower bound carried by a certificate. -/
def GapCertificate.lower (c : GapCertificate) : ℝ := c.gap - c.width

omit [FiniteDimensional ℂ E] in
/-- **T6 in certificate form.**  A certificate whose two numbers are the sector Ritz
difference and the assembled width proves that the sector gap of the truncated
Hamiltonian is at least its `lower` value. -/
theorem gap_ge_of_certificate {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    c.lower ≤ sectorGround T P (-1) - sectorGround T P 1 := by
  have h := certified_parity_gap (T := T) (P := P) hEven hOdd
  rw [GapCertificate.lower, hgap, hwidth]
  linarith

omit [FiniteDimensional ℂ E] in
/-- A certificate with a positive `lower` value proves a positive gap. -/
theorem gap_pos_of_certificate {T P : E →ₗ[ℂ] E} (c : GapCertificate)
    {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : c.gap = thetaO - thetaE) (hwidth : c.width = deltaO + deltaE)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1))
    (hpos : 0 < c.lower) :
    sectorGround T P 1 < sectorGround T P (-1) := by
  have h := gap_ge_of_certificate (T := T) (P := P) c hgap hwidth hEven hOdd
  linarith

/-- The certificate emitted by the kernel for the `g = 2`, `m = 4` run of the
lattice-era cross-benchmark (`yang_mills_lattice`) — retained as a historical
fixture; the object of record for the mass gap is the gauge-fixed QYM
Hamiltonian's reflection-sector certificate (`docs/MASS_GAP_SPEC.md`).
run (`MASS_GAP_CERTIFIED.md`, `CONSOLIDATED_PLAN.md` §13.2): measured sector gap
`1.9875`, assembled width `δᵒ + δᵉ = 0.0555`.  These two numbers are *data* transcribed
from the emitted NDJSON; Lean checks only what follows from them. -/
def qcdG2M4 : GapCertificate where
  gap := 1.9875
  width := 0.0555
  width_nonneg := by norm_num

/-- The certified lower bound of the `g = 2`, `m = 4` certificate is `1.932`. -/
theorem qcdG2M4_lower : qcdG2M4.lower = 1.932 := by
  norm_num [GapCertificate.lower, qcdG2M4]

/-- …and it is positive: the certificate carries a *positive* gap. -/
theorem qcdG2M4_lower_pos : 0 < qcdG2M4.lower := by
  rw [qcdG2M4_lower]; norm_num

omit [FiniteDimensional ℂ E] in
/-- **The instantiated certified mass gap for the truncated operator.**  Given the two
enclosures the `g = 2`, `m = 4` certificate asserts, the truncated Hamiltonian
has a strictly positive parity gap, of size at least `1.932`. -/
theorem qcdG2M4_certified_gap {T P : E →ₗ[ℂ] E} {thetaE thetaO deltaE deltaO : ℝ}
    (hgap : thetaO - thetaE = 1.9875) (hwidth : deltaO + deltaE = 0.0555)
    (hEven : sectorGround T P 1 ≤ thetaE + deltaE)
    (hOdd : thetaO - deltaO ≤ sectorGround T P (-1)) :
    (1.932 : ℝ) ≤ sectorGround T P (-1) - sectorGround T P 1
      ∧ sectorGround T P 1 < sectorGround T P (-1) := by
  have hg : qcdG2M4.gap = thetaO - thetaE := by rw [hgap]; rfl
  have hw : qcdG2M4.width = deltaO + deltaE := by rw [hwidth]; rfl
  have h := gap_ge_of_certificate (T := T) (P := P) qcdG2M4 hg hw hEven hOdd
  rw [qcdG2M4_lower] at h
  exact ⟨h, by linarith⟩

end BookProof.SirkCertifiedGap

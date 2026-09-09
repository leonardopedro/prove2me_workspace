import Mathlib
import BookProof.ChapterFockOneParticleGap

/-!
# Chapter FockNumberPreservingGap — the `dΓ` lift beyond the diagonal case

/-!
The final Hamiltonian convention is uniform across QYM, QED, QG, and NS:
the one-particle Hamiltonian is enclosed by outer creation on the left and
outer annihilation on the right. Inner pair terms are retained in the
one-particle operator; the outer annihilator, not an inner normal-ordering
rewrite, proves that the outer vacuum is an exact zero-energy eigenstate.
-/!

`CONSOLIDATED_PLAN.md` (top work package, status update 2026-08-28) lists two remaining
inputs.  The per-order finite certificate is discharged in `ChapterRitzCertificate`; this
chapter weakens the second one as far as it honestly can be weakened.

`ChapterFockOneParticleGap` proves the free `dΓ` lift for a one-particle Hamiltonian
`diagCol e` that is **diagonal** in the chosen occupation-number basis.  That is stronger
than the plan's free/number-preserving hypothesis needs: the lift only requires the
one-particle matrix to be *number preserving* (`dΓ` of a one-particle matrix, i.e. built
from `a†_j a_k`), Hermitian, and to have a **one-particle gap**.  Here the gap is expressed
exactly as it is checked numerically, as positive semidefiniteness of the shifted matrix

  `h − μ ≥ 0`   (`IsPosCol (shiftCol col mu)`),

with no diagonalization and no eigenbasis anywhere.

## Deliverables

* `shiftCol` — the shifted one-particle matrix `h − μ`, and `shiftCol_diagCol` /
  `isPosCol_shiftCol_diagCol`, which show the diagonal case of
  `ChapterFockOneParticleGap` is an instance;
* `creVec_sub`, `dGamma_shiftCol` — `dΓ` is linear in the one-particle matrix:
  `dΓ(h − μ) = dΓ(h) − μN`, the general form of `dGamma_diagCol_shift`;
* `dGamma_vac` — the vacuum is annihilated by `dΓ(h)` for **every** one-particle matrix;
* `number_quadForm_ge` — `⟪u, N u⟫ ≥ ‖u‖²` on vacuum-orthogonal states;
* **`fock_gap_of_number_preserving`** — the lift: if `h − μ ≥ 0` as a one-particle matrix
  and `μ ≥ 0`, then every vacuum-orthogonal finite-particle state has Fock energy at least
  `μ‖u‖²`;
* **`fock_gap_of_number_preserving_op`** — the same statement on the Fock space, with the
  vacuum energy `0`, in the form the Friedrichs machinery consumes.

## Honest boundary

Number preservation is still assumed: everything here is `dΓ` of a one-particle matrix, so
pair creation and other particle-number-changing interactions are **excluded**, exactly as
the plan states.  What is removed is only the diagonal/eigenbasis restriction.  No mass gap
of the physical Yang–Mills Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockNumberPreservingGap

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

/-! ## 1. The shifted one-particle matrix -/

/-- The one-particle matrix `h − μ`, whose positivity is the numerically checked form of
the one-particle gap `h ≥ μ`. -/
def shiftCol (col : ℕ → (ℕ →₀ ℂ)) (mu : ℝ) : ℕ → (ℕ →₀ ℂ) :=
  fun k => col k - ((mu : ℝ) : ℂ) • Finsupp.single k 1

theorem numberCol_eq (k : ℕ) : numberCol k = Finsupp.single k (1 : ℂ) := by
  simp [numberCol, diagCol]

theorem shiftCol_apply (col : ℕ → (ℕ →₀ ℂ)) (mu : ℝ) (k : ℕ) :
    shiftCol col mu k = col k - ((mu : ℝ) : ℂ) • numberCol k := by
  rw [shiftCol, numberCol_eq]

/-- The diagonal one-particle matrix shifts diagonally. -/
theorem shiftCol_diagCol (e : ℕ → ℝ) (mu : ℝ) :
    shiftCol (diagCol e) mu = diagCol fun k => e k - mu := by
  funext k
  refine Finsupp.ext fun j => ?_
  simp only [shiftCol, diagCol, Finsupp.sub_apply, Finsupp.smul_apply, Finsupp.single_apply,
    smul_eq_mul]
  split_ifs with h
  · push_cast; ring
  · ring

/-! ## 2. `dΓ` is linear in the one-particle matrix -/

theorem creVec_eq_sum_of_subset (v : ℕ →₀ ℂ) (x : FockAlg) {s : Finset ℕ}
    (h : v.support ⊆ s) : creVec v x = ∑ j ∈ s, v j • creA j x := by
  rw [creVec_apply]
  exact Finset.sum_subset h fun j _ hj => by
    rw [Finsupp.notMem_support_iff.mp hj, zero_smul]

theorem creVec_sub (v w : ℕ →₀ ℂ) (x : FockAlg) :
    creVec (v - w) x = creVec v x - creVec w x := by
  classical
  set s : Finset ℕ := (v - w).support ∪ (v.support ∪ w.support) with hs
  have h1 : (v - w).support ⊆ s := Finset.subset_union_left
  have h2 : v.support ⊆ s := fun j hj =>
    Finset.mem_union_right _ (Finset.mem_union_left _ hj)
  have h3 : w.support ⊆ s := fun j hj =>
    Finset.mem_union_right _ (Finset.mem_union_right _ hj)
  have hterm : ∀ j : ℕ, ((v - w) j) • creA j x = v j • creA j x - w j • creA j x := by
    intro j
    rw [Finsupp.sub_apply, sub_smul]
  rw [creVec_eq_sum_of_subset _ _ h1, creVec_eq_sum_of_subset _ _ h2,
    creVec_eq_sum_of_subset _ _ h3]
  simp only [hterm]
  rw [Finset.sum_sub_distrib]

theorem creVec_smul (c : ℂ) (v : ℕ →₀ ℂ) (x : FockAlg) :
    creVec (c • v) x = c • creVec v x := by
  classical
  have h1 : (c • v).support ⊆ v.support := Finsupp.support_smul
  rw [creVec_eq_sum_of_subset _ _ h1, creVec_apply, Finset.smul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finsupp.smul_apply, smul_eq_mul, mul_smul]

/-- **`dΓ` is linear in the one-particle matrix**: `dΓ(h − μ) = dΓ(h) − μ N`.  This is the
general (non-diagonal) form of `FockOneParticleGap.dGamma_diagCol_shift`. -/
theorem dGamma_shiftCol (col : ℕ → (ℕ →₀ ℂ)) (mu : ℝ) (u : FockAlg) :
    dGamma (shiftCol col mu) u
      = dGamma col u - ((mu : ℝ) : ℂ) • dGamma numberCol u := by
  classical
  have hmod : modes u ⊆ modes u := subset_rfl
  have hterm : ∀ k : ℕ, creVec (shiftCol col mu k) (annA k u)
      = creVec (col k) (annA k u) - ((mu : ℝ) : ℂ) • creVec (numberCol k) (annA k u) := by
    intro k
    rw [shiftCol_apply, creVec_sub, creVec_smul]
  rw [dGamma_eq_sum (shiftCol col mu) hmod, dGamma_eq_sum col hmod,
    dGamma_eq_sum numberCol hmod, Finset.smul_sum]
  simp only [hterm]
  rw [Finset.sum_sub_distrib]

/-! ## 3. The vacuum, and the number operator -/

/-- **The vacuum is annihilated by every number-preserving second quantization.** -/
theorem dGamma_vac (col : ℕ → (ℕ →₀ ℂ)) : dGamma col vac = 0 := by
  simp [vac, dGamma_single]

/-- **The number operator bounds the norm on vacuum-orthogonal states**: `⟪u, N u⟫ ≥ ‖u‖²`,
since every non-vacuum configuration carries at least one quantum. -/
theorem number_quadForm_ge {u : FockAlg} (h0 : u 0 = 0) :
    ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma numberCol u)) : ℂ).re := by
  have h := fock_gap_quadForm (e := fun _ => (1 : ℝ)) (mu := 1) zero_le_one
    (fun _ => le_rfl) h0
  rw [one_mul] at h
  exact h

/-! ## 4. The lift -/

/-- **The `dΓ` lift for an arbitrary number-preserving one-particle Hamiltonian.**  If the
one-particle matrix satisfies the gap condition `h − μ ≥ 0` (positive semidefinite on every
finite set of modes) with `μ ≥ 0`, then every vacuum-orthogonal finite-particle state has
Fock energy at least `μ‖u‖²`.

No diagonalization, no eigenbasis and no boundedness are used; only number preservation,
which is built into `dΓ`. -/
theorem fock_gap_of_number_preserving {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 ≤ mu)
    (hgap : IsPosCol (shiftCol col mu)) {u : FockAlg} (h0 : u 0 = 0) :
    mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by
  have hsplit : (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ)
      = inner ℂ (toLp u) (toLp (dGamma (shiftCol col mu) u))
        + ((mu : ℝ) : ℂ) * inner ℂ (toLp u) (toLp (dGamma numberCol u)) := by
    have hcol : dGamma col u
        = dGamma (shiftCol col mu) u + ((mu : ℝ) : ℂ) • dGamma numberCol u := by
      rw [dGamma_shiftCol, sub_add_cancel]
    have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b =>
      map_add toLpL a b
    have hsmul : ∀ (c : ℂ) (a : FockAlg), toLp (c • a) = c • toLp a := fun c a =>
      map_smul toLpL c a
    rw [hcol, hadd, hsmul, inner_add_right, inner_smul_right]
  rw [hsplit, Complex.add_re, Complex.re_ofReal_mul]
  have h1 : 0 ≤ (inner ℂ (toLp u) (toLp (dGamma (shiftCol col mu) u)) : ℂ).re :=
    inner_dGamma_nonneg hgap u
  have h2 := mul_le_mul_of_nonneg_left (number_quadForm_ge h0) hmu
  linarith

/-- **The lift on the Fock space.**  With the one-particle gap `h − μ ≥ 0`, `μ ≥ 0`: the
vacuum has energy `0`, and every vacuum-orthogonal finite-occupation state has energy at
least `μ‖x‖²` — the hypotheses the Friedrichs machinery of
`ChapterFockSecondQuantization` consumes. -/
theorem fock_gap_of_number_preserving_op {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 ≤ mu)
    (hgap : IsPosCol (shiftCol col mu)) :
    dGammaOp col (fockEquiv vac) = 0 ∧
      ∀ x : lpFiniteModes Conf, (inner ℂ (toLp vac) ((x : Fock)) : ℂ) = 0 →
        mu * ‖(x : Fock)‖ ^ 2 ≤ quadForm (dGammaOp col) x := by
  constructor
  · rw [coe_dGammaOp, LinearEquiv.symm_apply_apply, dGamma_vac]
    exact map_zero toLpL
  · intro x hx
    rw [quadForm, coe_dGammaOp, coe_fockEquiv_symm x]
    rw [coe_fockEquiv_symm x] at hx
    exact fock_gap_of_number_preserving hmu hgap (by rwa [inner_vac] at hx)

/-! ## 5. The diagonal case is an instance -/

/-- A diagonal one-particle matrix with all energies at least `μ` satisfies the gap
condition, so `ChapterFockOneParticleGap.fock_gap_quadForm` is the diagonal instance of
`fock_gap_of_number_preserving`. -/
theorem isPosCol_shiftCol_diagCol {e : ℕ → ℝ} {mu : ℝ} (he : ∀ k, mu ≤ e k) :
    IsPosCol (shiftCol (diagCol e) mu) := by
  classical
  intro S c
  rw [shiftCol_diagCol]
  have hcol : ∀ j k : ℕ, (diagCol (fun k => e k - mu) k) j
      = if j = k then (((e k - mu : ℝ)) : ℂ) else 0 := by
    intro j k
    rw [diagCol, Finsupp.single_apply]
    by_cases h : j = k
    · subst h; simp
    · rw [if_neg h, if_neg (fun hkj : k = j => h hkj.symm)]
  have hsum : (∑ j ∈ S, ∑ k ∈ S,
      (starRingEnd ℂ) (c j) * (diagCol (fun k => e k - mu) k) j * c k)
      = ∑ j ∈ S, (((e j - mu : ℝ)) : ℂ) * ((starRingEnd ℂ) (c j) * c j) := by
    refine Finset.sum_congr rfl fun j hj => ?_
    rw [Finset.sum_eq_single j]
    · rw [hcol j j, if_pos rfl]; ring
    · intro k _ hkj
      rw [hcol j k, if_neg (fun h : j = k => hkj (h ▸ rfl))]
      ring
    · intro hj'; exact absurd hj hj'
  rw [hsum, Complex.re_sum]
  refine Finset.sum_nonneg fun j _ => ?_
  rw [Complex.re_ofReal_mul, conj_mul_re]
  exact mul_nonneg (by linarith [he j]) (sq_nonneg _)

/-! ## 6. From a one-particle *form* gap to the Fock gap

The certificate chain (`ChapterRitzCertificate`, `ChapterBandEnclosure`) delivers a bound of
exactly the shape `⟪x, h x⟫ ≥ μ‖x‖²` on the finite-mode core.  This section consumes it
directly: no eigenbasis, no diagonalization, no boundedness. -/

section FormGap

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

open BookProof.HermiteGalerkin

/-- The matrix of the identity in an orthonormal basis is the identity matrix. -/
theorem opCol_id (b : HilbertBasis ℕ ℂ F) (k j : ℕ) :
    opCol b (LinearMap.id) k j = if j = k then (1 : ℂ) else 0 := by
  rw [opCol_apply]
  simpa using orthonormal_iff_ite.mp b.orthonormal j k

/-- Shifting the one-particle operator by `μ` shifts its matrix by `μ` times the identity
matrix. -/
theorem shiftCol_opCol (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b) (mu : ℝ) :
    shiftCol (opCol b A) mu = opCol b (A - ((mu : ℝ) : ℂ) • LinearMap.id) := by
  funext k
  refine Finsupp.ext fun j => ?_
  have hid : opCol b (((mu : ℝ) : ℂ) • LinearMap.id) k j
      = ((mu : ℝ) : ℂ) * (if j = k then (1 : ℂ) else 0) := by
    rw [opCol_apply]
    simp only [LinearMap.smul_apply, Submodule.coe_smul, inner_smul_right, LinearMap.id_apply]
    simpa using congrArg (fun z : ℂ => ((mu : ℝ) : ℂ) * z)
      (orthonormal_iff_ite.mp b.orthonormal j k)
  have hsub : opCol b (A - ((mu : ℝ) : ℂ) • LinearMap.id) k j
      = opCol b A k j - opCol b (((mu : ℝ) : ℂ) • LinearMap.id) k j := by
    rw [opCol_apply, opCol_apply, opCol_apply]
    simp only [LinearMap.sub_apply, Submodule.coe_sub, inner_sub_right]
  rw [hsub, hid, shiftCol]
  simp [Finsupp.single_apply, eq_comm]

/-- **From a one-particle form gap to the Fock gap.**  If the one-particle Hamiltonian on
the finite-mode core satisfies `⟪x, h x⟫ ≥ μ‖x‖²` with `μ ≥ 0`, then its second
quantization has vacuum energy `0` and Fock energy at least `μ‖u‖²` on every
vacuum-orthogonal finite-particle state.  This is the shape of bound the certificate chain
produces, consumed without any diagonalization. -/
theorem fock_gap_of_one_particle_form_gap (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b) {mu : ℝ} (hmu : 0 ≤ mu)
    (hgap : ∀ x : finiteModeDomain b,
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    dGamma (opCol b A) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b A) u)) : ℂ).re := by
  have hpos : ∀ x : finiteModeDomain b,
      0 ≤ quadForm ((finiteModeDomain b).subtype.comp
        (A - ((mu : ℝ) : ℂ) • LinearMap.id)) x := by
    intro x
    have hval : quadForm ((finiteModeDomain b).subtype.comp
        (A - ((mu : ℝ) : ℂ) • LinearMap.id)) x
        = quadForm ((finiteModeDomain b).subtype.comp A) x - mu * ‖(x : F)‖ ^ 2 := by
      simp only [quadForm, LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply,
        LinearMap.sub_apply, LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_sub,
        Submodule.coe_smul, inner_sub_right, inner_smul_right, Complex.sub_re,
        Complex.re_ofReal_mul, inner_self_eq_norm_sq_to_K]
      norm_cast
    rw [hval]
    linarith [hgap x]
  have hgapCol : IsPosCol (shiftCol (opCol b A) mu) := by
    rw [shiftCol_opCol]
    exact isPosCol_opCol hpos
  exact ⟨dGamma_vac _, fun u h0 => fock_gap_of_number_preserving hmu hgapCol h0⟩

end FormGap

end BookProof.FockNumberPreservingGap

end

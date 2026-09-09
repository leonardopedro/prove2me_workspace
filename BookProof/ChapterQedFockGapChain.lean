import Mathlib
import BookProof.ChapterFockDiagonalGapChain

/-!
# Chapter QedFockGapChain — the gap chain for QED, and what masslessness costs

`CONSOLIDATED_PLAN.md`, next-steps item **2** of the 2026-08-28j block: *instantiate the
chain for QED — and say what the masslessness means.*

The free photon's one-particle energy is diagonal in the mode basis with the massless
dispersion `ω_k = |k|`, so the diagonal chain of `ChapterFockDiagonalGapChain` applies
directly — but only at `m = 0`.  This module records exactly that, and, so that the
statement cannot be misread as a photon mass gap, it also *proves the obstruction*: if the
momentum assignment accumulates at zero (the physical infrared situation), then for every
`m > 0` the one-particle form gap `⟪x, D x⟫ ≥ m‖x‖²` is **false** on the core.

## What is proved

* `diagOnePart_quadForm_basis` — the diagonal form on a single mode is that mode's energy.
* `diagOnePart_no_form_gap` — *no* form gap above any mode energy: if `ω_k < m` for some
  mode `k`, there is a unit core vector on which the diagonal form is `< m‖x‖²`.
* `photonDispersion`, `photonDispersion_nonneg` — the massless dispersion `ω_k = |p_k|`.
* **`photon_fock_positivity`** — the honest unconditional QED statement: the second
  quantization of the photon energy annihilates the outer vacuum and is non-negative on
  every finite-particle state.  This is `diag_fock_gap` at `m = 0`; the gap is `0`.
* **`photon_no_one_particle_gap`** — the obstruction: for an infrared-accumulating momentum
  assignment (`∀ ε > 0, ∃ k, |p_k| < ε`) and *every* `m > 0`, the one-particle form gap
  fails.  So no instantiation of the chain can produce a positive photon mass gap.
* **`irPhoton_fock_mass_gap`** — with an infrared regulator `μ > 0` imposed on the mode
  energies (`ω_k = max μ |p_k|`), the diagonal chain gives the nested-Fock mass gap `μ`.
* **`proca_fock_mass_gap`** — with a massive (Proca-type) one-particle energy
  `ω_k = √(p_k² + m²)`, `m > 0`, the chain gives the nested-Fock mass gap `m`.

## Honest boundary

The free-photon instantiation yields positivity and **no gap**; that is a feature of
massless dispersion, not a deficiency of the chain, and `photon_no_one_particle_gap` proves
that no positive gap is available at the one-particle level in the infrared-accumulating
case.  The gapped statements above are statements about the *regulated* (`μ > 0`) and
*massive* (Proca) one-particle energies, which are modelling replacements for the photon
energy, not theorems about physical QED.  No photon mass is claimed anywhere.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.QedFockGapChain

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FarisLavine
open BookProof.HermiteGalerkin BookProof.HermiteCore
open BookProof.FockDiagonalGapChain BookProof.YangMillsFriedrichs
open MeasureTheory

section General

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The diagonal form on a single mode is that mode's energy**: the basis vector
`b k` is a unit vector and an eigenvector of `diagOnePart b w` with eigenvalue `w k`. -/
theorem diagOnePart_quadForm_basis (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (k : ℕ) :
    quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) (modeBasis b k) = w k := by
  have hnorm : ‖b k‖ = 1 := b.orthonormal.1 k
  have hq : quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) (modeBasis b k)
      = (inner ℂ ((modeBasis b k : finiteModeDomain b) : F)
          ((diagOnePart b w (modeBasis b k) : finiteModeDomain b) : F) : ℂ).re := rfl
  rw [hq, diagOnePart_basis, Submodule.coe_smul, modeBasis_coe, inner_smul_right,
    inner_self_ofReal, hnorm]
  simp

/-- **No form gap above a mode energy.**  If some mode energy is `< m`, then the one-particle
form gap at level `m` fails on the core: the corresponding basis vector is a unit vector on
which the diagonal form equals that mode energy. -/
theorem diagOnePart_no_form_gap (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ} {k : ℕ}
    (hk : w k < m) :
    ∃ x : finiteModeDomain b, (x : F) ≠ 0 ∧
      quadForm ((finiteModeDomain b).subtype.comp (diagOnePart b w)) x
        < m * ‖(x : F)‖ ^ 2 := by
  have hnorm : ‖((modeBasis b k : finiteModeDomain b) : F)‖ = 1 := by
    rw [modeBasis_coe]; exact b.orthonormal.1 k
  refine ⟨modeBasis b k, ?_, ?_⟩
  · intro hc
    rw [hc] at hnorm
    simp at hnorm
  · rw [diagOnePart_quadForm_basis, hnorm]
    simpa using hk

end General

/-! ## 1. The free photon: positivity, and no gap -/

/-- **The massless photon dispersion** `ω_k = |p_k|` of the mode `k`. -/
def photonDispersion (p : ℕ → ℝ) (k : ℕ) : ℝ := |p k|

theorem photonDispersion_nonneg (p : ℕ → ℝ) (k : ℕ) : 0 ≤ photonDispersion p k :=
  abs_nonneg _

/-- **The QED instantiation of the diagonal chain**: the second quantization of the free
photon energy annihilates the outer vacuum and is non-negative on every finite-particle
state.  The gap is `0`: this is `diag_fock_gap` at `m = 0`, and no more is available — see
`photon_no_one_particle_gap`. -/
theorem photon_fock_positivity (p : ℕ → ℝ) :
    dGamma (opCol hermiteBasis (diagOnePart hermiteBasis (photonDispersion p))) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        (0 : ℝ) * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma
              (opCol hermiteBasis (diagOnePart hermiteBasis (photonDispersion p))) u)) : ℂ).re :=
  diag_fock_gap hermiteBasis (photonDispersion p) le_rfl (fun k => photonDispersion_nonneg p k)

/-- **Masslessness costs the gap.**  If the momentum assignment accumulates at zero — the
physical infrared situation for the photon — then for *every* `m > 0` the one-particle form
gap fails on the core: there is a unit vector whose photon energy is `< m‖x‖²`.  Hence no
instantiation of the gap chain can give the photon a mass gap; a gapped statement needs an
infrared regulator (`irPhoton_fock_mass_gap`) or a massive one-particle energy
(`proca_fock_mass_gap`). -/
theorem photon_no_one_particle_gap {p : ℕ → ℝ} (hIR : ∀ ε : ℝ, 0 < ε → ∃ k, |p k| < ε)
    {m : ℝ} (hm : 0 < m) :
    ∃ x : finiteModeDomain hermiteBasis, (x : Lp ℂ 2 (volume : Measure ℝ)) ≠ 0 ∧
      quadForm ((finiteModeDomain hermiteBasis).subtype.comp
          (diagOnePart hermiteBasis (photonDispersion p))) x
        < m * ‖(x : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2 := by
  obtain ⟨k, hk⟩ := hIR m hm
  exact diagOnePart_no_form_gap hermiteBasis (photonDispersion p) (k := k) hk

/-! ## 2. What restores a gap: an infrared regulator, or a mass -/

/-- **The infrared-regulated photon energy** `ω_k = max μ |p_k|`: every mode energy is at
least the regulator `μ`. -/
def irPhotonDispersion (mu : ℝ) (p : ℕ → ℝ) (k : ℕ) : ℝ := max mu |p k|

theorem irPhotonDispersion_ge (mu : ℝ) (p : ℕ → ℝ) (k : ℕ) :
    mu ≤ irPhotonDispersion mu p k := le_max_left _ _

/-- **The infrared-regulated photon sector has the nested-Fock mass gap `μ`.**  This is a
statement about the regulated one-particle energy, not about physical QED. -/
theorem irPhoton_fock_mass_gap {mu : ℝ} (hmu : 0 < mu) (p : ℕ → ℝ) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension
          (dGammaOp (opCol hermiteBasis
            (diagOnePart hermiteBasis (irPhotonDispersion mu p)))) A) ∧
      dGamma (opCol hermiteBasis (diagOnePart hermiteBasis (irPhotonDispersion mu p))) vac
          = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma
              (opCol hermiteBasis
                (diagOnePart hermiteBasis (irPhotonDispersion mu p))) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma
            (opCol hermiteBasis
              (diagOnePart hermiteBasis (irPhotonDispersion mu p))) u)) : ℂ).re :=
  diag_fock_mass_gap hermiteBasis (irPhotonDispersion mu p) hmu (irPhotonDispersion_ge mu p)

/-- **The massive (Proca-type) vector sector has the nested-Fock mass gap `m`.**  Its
one-particle energy is the relativistic dispersion `√(p² + m²)`, so this is the free massive
instance of the diagonal chain; the photon is the `m = 0` limit, where the gap disappears. -/
theorem proca_fock_mass_gap {m : ℝ} (hm : 0 < m) (p : ℕ → ℝ) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension
          (dGammaOp (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p)))) A) ∧
      dGamma (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) vac = 0 ∧
      (∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma
              (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) u)) : ℂ).re) ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma
            (opCol hermiteBasis (diagOnePart hermiteBasis (freeDispersion m p))) u)) : ℂ).re :=
  freeField_fock_mass_gap hm p

end BookProof.QedFockGapChain

end

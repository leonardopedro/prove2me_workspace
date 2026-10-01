import Definitions.Def_ChapterScalaronFockGapChain
import Mathlib


/-!
# Chapter FockDiagonalGapChain — the gap chain for a diagonal one-particle energy

`CONSOLIDATED_PLAN.md`, next step 3 of the top work package, asks for the abstract gap chain
to be run for the free sectors of the enclosure doctrine, whose one-particle operator is
*diagonal in the mode basis*: the one-particle energy of the mode `k` is a number `ω_k`.
`ChapterScalaronFockGapChain` did the constant case `ω_k = m`; this chapter does the general
diagonal case, which covers a genuine dispersion relation such as `ω_k = √(p_k² + m²)`.

## Deliverables

* `modeBasis b` — the finite-mode core `finiteModeDomain b` viewed as a free module with
  basis the (orthonormal) family `b`, and `modeBasis_coe`;
* `diagOnePart b w` — the diagonal one-particle operator `e_k ↦ ω_k e_k`, and the coordinate
  formula `diagOnePart_inner` for its sesquilinear form;
* `diagOnePart_symmetricOn`, `diagOnePart_quadForm_ge` — symmetry, and the one-particle form
  gap `⟪x, D x⟫ ≥ m‖x‖²` whenever every mode energy satisfies `ω_k ≥ m`: for a diagonal
  operator the form gap is *proved*, not assumed;
* **`diag_fock_gap`, `diag_fock_mass_gap`** — the resulting unconditional nested-Fock gap and
  mass gap of `dΓ(D)`;
* **`diag_fock_gap_of_field_perturbation`**, **`diag_fock_cubic_quartic_bounded_below`** — the
  gap under the unbounded, number-changing coupling `Φ(f)` with `2‖f‖ < m`, and
  semiboundedness with the single-mode cubic couplings and their normal-ordered quartic
  partners added;
* `freeDispersion m p k = √(p_k² + m²)` with `freeDispersion_ge`, and the free massive
  sector instance **`freeField_fock_mass_gap`** on the Hermite basis of `L²(ℝ)`: for any
  assignment of momenta to modes, the relativistic one-particle energy gives the outer Fock
  space the mass gap `m`.

## Honest boundary

The gap here is an honest theorem *about the model*: once the sector's one-particle energy
is diagonal with all mode energies at least `m`, the nested-Fock gap `m` and its stability
under the listed perturbations follow with no certificate and no Ritz data.  That a physical
sector reduces to such a diagonal energy is the modelling input of the enclosure doctrine
and is not proved here.  Massless dispersion gives `m = 0`, i.e. positivity and no gap.  The
cubic/quartic statement is semiboundedness with a negative constant, on single-mode terms.
The gauge-fixed Yang–Mills chain stays conditional on its one-particle form gap, and no mass
gap of the physical Yang–Mills Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockDiagonalGapChain

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore BookProof.ScalaronFockGapChain
open Module

section General

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-! ## 0. Two small coercion helpers -/





/-! ## 1. The finite-mode core as a free module -/

/-- The finite-mode core `finiteModeDomain b = span ℂ (range b)` of an orthonormal basis,
with the basis `b` itself as an algebraic basis. -/
def modeBasis (b : HilbertBasis ℕ ℂ F) : Basis ℕ ℂ (finiteModeDomain b) :=
  Basis.span b.orthonormal.linearIndependent

 _coe]

/-! ## 2. The diagonal one-particle operator -/

/-- **The diagonal one-particle operator** `e_k ↦ ω_k e_k` on the finite-mode core: the
one-particle energy of a free sector with mode energies `ω`. -/
def diagOnePart (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) :
    finiteModeDomain b →ₗ[ℂ] finiteModeDomain b :=
  (modeBasis b).constr ℂ fun i => ((w i : ℝ) : ℂ) • modeBasis b _import Mathlib

/-!
# Chapter FockDiagonalGapChain — the gap chain for a diagonal one-particle energy

`CONSOLIDATED_PLAN.md`, next step 3 of the top work package, asks for the abstract gap chain
to be run for the free sectors of the enclosure doctrine, whose one-particle operator is
*diagonal in the mode basis*: the one-particle energy of the mode `k` is a number `ω_k`.
`ChapterScalaronFockGapChain` did the constant case `ω_k = m`; this chapter does the general
diagonal case, which covers a genuine dispersion relation such as `ω_k = √(p_k² + m²)`.

## Deliverables

* `modeBasis b` — the finite-mode core `finiteModeDomain b` viewed as a free module with
  basis the (orthonormal) family `b`, and `modeBasis_coe`;
* `diagOnePart b w` — the diagonal one-particle operator `e_k ↦ ω_k e_k`, and the coordinate
  formula `diagOnePart_inner` for its sesquilinear form;
* `diagOnePart_symmetricOn`, `diagOnePart_quadForm_ge` — symmetry, and the one-particle form
  gap `⟪x, D x⟫ ≥ m‖x‖²` whenever every mode energy satisfies `ω_k ≥ m`: for a diagonal
  operator the form gap is *proved*, not assumed;
* **`diag_fock_gap`, `diag_fock_mass_gap`** — the resulting unconditional nested-Fock gap and
  mass gap of `dΓ(D)`;
* **`diag_fock_gap_of_field_perturbation`**, **`diag_fock_cubic_quartic_bounded_below`** — the
  gap under the unbounded, number-changing coupling `Φ(f)` with `2‖f‖ < m`, and
  semiboundedness with the single-mode cubic couplings and their normal-ordered quartic
  partners added;
* `freeDispersion m p k = √(p_k² + m²)` with `freeDispersion_ge`, and the free massive
  sector instance **`freeField_fock_mass_gap`** on the Hermite basis of `L²(ℝ)`: for any
  assignment of momenta to modes, the relativistic one-particle energy gives the outer Fock
  space the mass gap `m`.

## Honest boundary

The gap here is an honest theorem *about the model*: once the sector's one-particle energy
is diagonal with all mode energies at least `m`, the nested-Fock gap `m` and its stability
under the listed perturbations follow with no certificate and no Ritz data.  That a physical
sector reduces to such a diagonal energy is the modelling input of the enclosure doctrine
and is not proved here.  Massless dispersion gives `m = 0`, i.e. positivity and no gap.  The
cubic/quartic statement is semiboundedness with a negative constant, on single-mode terms.
The gauge-fixed Yang–Mills chain stays conditional on its one-particle form gap, and no mass
gap of the physical Yang–Mills Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockDiagonalGapChain

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore BookProof.ScalaronFockGapChain
open Module

section General

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-! ## 0. Two small coercion helpers -/

theorem conj_mul_ofReal (z : ℂ) : (starRingEnd ℂ) z * z = ((‖z‖ ^ 2 : ℝ) : ℂ) := by
  simpa using RCLike.conj_mul z

theorem inner_self_ofReal (v : F) : (inner ℂ v v : ℂ) = ((‖v‖ ^ 2 : ℝ) : ℂ) := by
  simp [inner_self_eq_norm_sq_to_K]

/-! ## 1. The finite-mode core as a free module -/

/-- The finite-mode core `finiteModeDomain b = span ℂ (range b)` of an orthonormal basis,
with the basis `b` itself as an algebraic basis. -/
def modeBasis (b : HilbertBasis ℕ ℂ F) : Basis ℕ ℂ (finiteModeDomain b) :=
  Basis.span b.orthonormal.linearIndependent

@[simp] theorem modeBasis_coe (b : HilbertBasis ℕ ℂ F) (i : ℕ) :
    ((modeBasis b i : finiteModeDomain b) : F) = b i :=
  Basis.coe_span_apply _ i

/-- A core vector is the linear combination of the basis with its coordinates. -/
theorem coe_eq_linearCombination (b : HilbertBasis ℕ ℂ F) (x : finiteModeDomain b) :
    (x : F) = Finsupp.linearCombination ℂ (⇑b) ((modeBasis b).repr x) := by
  calc (x : F)
      = ((Finsupp.linearCombination ℂ (⇑(modeBasis b)) ((modeBasis b).repr x) :
          finiteModeDomain b) : F) := by
        rw [(modeBasis b).linearCombination_repr x]
    _ = Finsupp.linearCombination ℂ (⇑b) ((modeBasis b).repr x) := by
        simp only [Finsupp.linearCombination_apply, Finsupp.sum,
          AddSubmonoidClass.coe_finset_sum, Submodule.coe_smul, modeBasis_coe]

/-! ## 2. The diagonal one-particle operator -/

/-- **The diagonal one-particle operator** `e_k ↦ ω_k e_k` on the finite-mode core: the
one-particle energy of a free sector with mode energies `ω`. -/
def diagOnePart (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) :
    finiteModeDomain b →ₗ[ℂ] finiteModeDomain b :=
  (modeBasis b).constr ℂ fun i => ((w i : ℝ) : ℂ) • modeBasis b i

@[simp] theorem diagOnePart_basis (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (i : ℕ) :
    diagOnePart b w (modeBasis b i) = ((w i : ℝ) : ℂ) • modeBasis b i :=
  (modeBasis b).constr_basis ℂ _ i

/-- The image of a core vector, in coordinates. -/
theorem diagOnePart_coe (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) (x : finiteModeDomain b) :
    ((diagOnePart b w x : finiteModeDomain b) : F)
      = ∑ i ∈ ((modeBasis b).repr x).support,
          (((w i : ℝ) : ℂ) * ((modeBasis b).repr x i)) • b i := by
  rw [diagOnePart, Basis.constr_apply, Finsupp.sum, AddSubmonoidClass.coe_finset_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Submodule.coe_smul, Submodule.coe_smul, modeBasis_coe, smul_smul,
    mul_comm ((modeBasis b).repr x i) (((w i : ℝ) : ℂ)rist hg _)

/-! ## 3. The chain  hhprif w) u

end General

/-! ## 4. The free massive sector -/

/-- **The relativistic one-particle energy** `ω_k = √(p_k² + m²)` of a free sector of mass
`m` whose mode `k` carries momentum `p k`. -/
def freeDispersion (m : ℝ) (p : ℕ → ℝ) (k : ℕ) : ℝ := Real.sqrt ((p k) ^ 2 + m ^ rte p)

/-! ## 5. Axiom audit -/

section Audit

#print axioms diagOnePart_inner
#print axioms diagOnePart_symmetricOn
#print axioms diagOnePart_quadForm_ge
#print axioms diag_fock_gap
#print axioms diag_fock_mass_gap
#print axioms diag_fock_gap_of_field_perturbation
#print axioms diag_fock_cubic_quartic_bounded_below
#print axioms freeField_fock_mass_gap

end Audit

end BookProof.FockDiagonalGapChain

end

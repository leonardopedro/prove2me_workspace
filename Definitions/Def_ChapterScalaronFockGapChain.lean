import Definitions.Def_ChapterHermiteFunctions
import Mathlib


/-!
# Chapter ScalaronFockGapChain — the gap chain for the R² (scalaron) sector

`CONSOLIDATED_PLAN.md`, next step 3 of the top work package, asks for the abstract gap
chain to be run "for the other sectors under the enclosure doctrine", and singles out the
`R²`-vielbein quantum-gravity case: for the scalaron sector the one-particle operator may
be taken to be the *positive constant* `m = 1/√(12α)`, in which case the outer Fock gap
`m·N` is **unconditional** — no certificate, no Ritz data, no form-gap hypothesis.  This
chapter carries that out.

The gauge-fixed Yang–Mills instantiation `ChapterYangMillsFockGapChain` had to leave its
one-particle form gap as a hypothesis.  Here the form gap is an identity, so every
conclusion of the chain becomes a theorem.

## Deliverables

* `constOnePart b m` — the constant one-particle operator `m·1` on the finite-mode core of
  a one-particle Hilbert space with basis `b`, and `constOnePart_quadForm`, its quadratic
  form `m‖x‖²`;
* **`const_fock_gap`** — for `m ≥ 0`: `dΓ(m·1)` annihilates the outer vacuum and has energy
  at least `m‖u‖²` on every vacuum-orthogonal finite-particle state, *unconditionally*;
* **`const_fock_mass_gap`** — for `m > 0`: the same together with the positive self-adjoint
  (Friedrichs) extension of `dΓ(m·1)` and the strict positivity of the non-vacuum energy;
* **`const_fock_gap_of_field_perturbation`** — the gap survives the unbounded,
  number-changing linear field coupling `Φ(f)` of `ChapterFockFieldPerturbation` whenever
  `2‖f‖ < m`, with the surviving gap `(m − 2‖f‖)‖u‖²`;
* **`const_fock_cubic_quartic_bounded_below`** — with the cubic mode couplings and their
  normal-ordered quartic partners of `ChapterFockCubicQuarticStability` added, the energy is
  still bounded below, by `-|S|(2lam² + (2lam² + ½ − m)²/2)‖u‖²`;
* `scalaronMass α = 1/√(12α)` and the instantiation of all of the above at the scalaron mass
  on the Hermite basis of `L²(ℝ)`: **`scalaron_fock_mass_gap`**,
  `scalaron_fock_gap_of_field_perturbation`, `scalaron_fock_cubic_quartic_bounded_below`.

## Honest boundary

What is unconditional here is the *lift*: given that the scalaron sector's one-particle
operator is the constant `m = 1/√(12α)` — the mass of the Starobinsky scalaron, i.e. the
model in which the sector's one-particle energy is that constant — the outer nested-Fock
Hamiltonian has the gap `m` and keeps it under the perturbations listed above.  That the
full one-particle operator of the `R²` theory reduces to this constant is a modelling
statement of the plan's enclosure doctrine, not something proved here; the TEGR kinetic
sector is not covered, and neither is any claim about the Yang–Mills mass gap.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.ScalaronFockGapChain

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

/-! ## 1. The constant one-particle operator -/

section General

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The constant one-particle operator** `m·1` on the finite-mode core: the one-particle
energy of a free sector of mass `m`. -/
def constOnePart (b : HilbertBasis ℕ ℂ F) (m : ℝ) :
    finiteModeDomain b →ₗ[ℂ] finiteModeDomain b :=
  ((m : ℝ) : ℂ) • LinearMap.id















end General

/-! ## 2. The scalaron sector -/

/-- **The Starobinsky scalaron mass** `m = 1/√(12α)` of the `R + αR²` theory. -/
def scalaronMass (alpha : ℝ) : ℝ := 1 / Real.sqrt (12 * alpha)



/-- The scalaron one-particle operator of the enclosure doctrine: the constant
`m = 1/√(12α)` on the finite-mode core of `L²(ℝ)` in the Hermite basis. -/
def scalaronOnePart (alpha : ℝ) :
    finiteModeDomain hermiteBasis →ₗ[ℂ] finiteModeDomain hermiteBasis :=
  constOnePart hermiteBasis (scalaronMass alpha)







/-! ## 3. Axiom audit -/

section Audit

#print axioms constOnePart_quadForm
#print axioms const_fock_gap
#print axioms const_fock_mass_gap
#print axioms const_fock_gap_of_field_perturbation
#print axioms const_fock_cubic_quartic_bounded_below
#print axioms scalaron_fock_mass_gap
#print axioms scalaron_fock_gap_of_field_perturbation
#print axioms scalaron_fock_cubic_quartic_bounded_below

end Audit

end BookProof.ScalaronFockGapChain

end

import Mathlib
import BookProof.ChapterNsOuterFockFarisLavine
import BookProof.ChapterSqSumOuterSingleTime

/-!
# The gauge-fixed Navier–Stokes outer-Fock Hamiltonian is time-independent, and one finite
# time suffices

`BookProof.ChapterNsOuterFockFarisLavine` exhibits the gauge-fixed Navier–Stokes
Hamiltonian — advection with a background velocity, viscosity, the derivative and Laplacian
gauge-fixing forms that couple neighbouring parcels, and the `y`-gauge — as a uniform
kinetic-plus-squares family `nsFamily` on the sectors of the outer Fock space
`⊕ₙ L²(ℝ^{18n})`, and proves it essentially self-adjoint both on the finite-particle core
(`nsOuterHam_esa_core`) and, by Faris–Lavine, on the domain of the lifted Friedrichs
comparison operator (`nsOuterFock_esa_farisLavine`).  What it stops short of — the item
recorded in `CONSOLIDATED_PLAN.md` (2026-09-04f) as **NS next step 1** — is the
*single-time* package: the propagator of the selected generator together with truncations
converging to it.

This module supplies it, by instantiating the general outer-Fock package
`BookProof.SqSumOuterFamily.SqFamily.outerFamily_timeIndependent_singleTime` at `nsFamily`.
It is the Navier–Stokes counterpart of `qgOuterFock_timeIndependent_singleTime` (quantum
gravity) and of `ymFock_timeIndependent_singleTime_of_esa` (Yang–Mills) — and, unlike the
latter, it is **unconditional**: the essential self-adjointness it needs is already proved.

## What is proved

* **`nsOuterFock_timeIndependent_singleTime`** — the package: a self-adjoint realization `T`
  of the outer-Fock Navier–Stokes Hamiltonian and self-adjoint realizations `S N` of its
  particle-number truncations, with
  * `U(t,s) = e^{−i(t−s)H}` unitary, Chapman–Kolmogorov, **invariant under a common shift of
    both times**, and the *unique* solution operator of the Schrödinger equation of the one
    fixed generator — no time ordering, no Dyson series;
  * strong convergence of the Hashimoto shift-invert operators of the truncations at **every**
    nonzero shift;
  * hence convergence of the truncated propagators at **every single finite time**.
* **`nsOuterFock_farisLavine_timeIndependent_singleTime`** — the same, together with the
  Faris–Lavine realization on the comparison domain, so that the Hamiltonian whose flow is
  computed is the one the interaction terms are proved self-adjoint for.

## Honest boundary

Unchanged from `ChapterNsOuterFockFarisLavine`: the advection is the Oseen linearisation
with a background velocity field, so the Hamiltonian is quadratic; no global regularity of
the classical Navier–Stokes PDE is claimed anywhere.  The truncation is the
particle-number cutoff of `SqFamily.trunc`: above the cutoff the constraint and
gauge-fixing forms are switched off and only the free kinetic term remains.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NsOuterFock

open Filter Topology
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.SqSumOuterFamily BookProof.QgOuterFockFL
open BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.HashimotoShiftInvert
open BookProof.QgTimeIndependent

noncomputable section

variable {bv : Fin 3 → ℝ} {nu lam mu gg : ℝ}
variable {B : ℝ} (hB : 0 ≤ B) (hbv : ∀ j, |bv j| ≤ B) (hnu : |nu| ≤ B) (hlam : |lam| ≤ B)
  (hmu : |mu| ≤ B) (hgg : |gg| ≤ B)

include hB hbv hnu hlam hmu hgg in
/-- **The outer-Fock Navier–Stokes evolution is autonomous, and one finite time suffices.**

For the gauge-fixed Navier–Stokes Hamiltonian on the finite-particle core of
`⊕ₙ L²(ℝ^{18n})` — including the inter-parcel derivative and Laplacian gauge-fixing
couplings — and its particle-number truncations:

* the Hamiltonian has a self-adjoint realization `T` (it is essentially self-adjoint on the
  core, so `T` is *the* realization), and each truncation has a self-adjoint realization
  `S N`;
* the propagator `U(t,s)` of `T` is unitary, obeys Chapman–Kolmogorov, is invariant under a
  common shift of both times and uniquely solves the Schrödinger equation of the one fixed
  generator;
* at every nonzero shift the bounded Hashimoto shift-invert operators of the truncations
  converge strongly to that of `T`;
* hence at **every single finite time** the truncated propagators converge to the exact one.
  No step size, number of steps or time splitting appears anywhere. -/
theorem nsOuterFock_timeIndependent_singleTime :
    ∃ (T : UnboundedSelfAdjoint (outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim))
      (S : ℕ → UnboundedSelfAdjoint (outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim)),
      IsSelfAdjointExtension (nsFamily hB hbv hnu hlam hmu hgg).outerHam T.op ∧
        (∀ N, IsSelfAdjointExtension
          (SqFamily.truncHam (nsFamily hB hbv hnu hlam hmu hgg) N) (S N).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim),
          ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim),
          prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim,
          IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ N, IsShiftInvertC (S N).op (((l : ℝ) : ℂ) * Complex.I) (-((S N).resCLM l))) ∧
            ∀ u : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim,
              Tendsto (fun N => -((S N).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim) (t : ℝ),
          Tendsto (fun N => (S N).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  SqFamily.outerFamily_timeIndependent_singleTime (nsFamily hB hbv hnu hlam hmu hgg)

include hB hbv hnu hlam hmu hgg in
/-- **The single-time package together with the Faris–Lavine realization.**  The first
conjunct is `nsOuterFock_esa_farisLavine`: the full gauge-fixed Hamiltonian, interaction
terms included, is essentially self-adjoint on the domain of the lifted Friedrichs
comparison operator and extends the finite-particle-core Hamiltonian there.  The second is
the evolution package: the generator carries no time dependence and the truncated
propagators converge at every single finite time. -/
theorem nsOuterFock_farisLavine_timeIndependent_singleTime :
    (EssentiallySelfAdjointOn
        (outerFriedDom (nsFamily hB hbv hnu hlam hmu hgg).dim)
        (dsFibOp (fun n : ℕ => harmFried ((nsFamily hB hbv hnu hlam hmu hgg).dim n))
          (nsFamily hB hbv hnu hlam hmu hgg).secExt
          (nsFamily hB hbv hnu hlam hmu hgg).flK
          (nsFamily hB hbv hnu hlam hmu hgg).secExt_rel) ∧
      ∀ x : outerCore (nsFamily hB hbv hnu hlam hmu hgg).dim,
        ∃ h : (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim)
            ∈ outerFriedDom (nsFamily hB hbv hnu hlam hmu hgg).dim,
          dsFibOp (fun n : ℕ => harmFried ((nsFamily hB hbv hnu hlam hmu hgg).dim n))
              (nsFamily hB hbv hnu hlam hmu hgg).secExt
              (nsFamily hB hbv hnu hlam hmu hgg).flK
              (nsFamily hB hbv hnu hlam hmu hgg).secExt_rel
              ⟨(x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim), h⟩
            = (nsFamily hB hbv hnu hlam hmu hgg).outerHam x) ∧
    ∃ (T : UnboundedSelfAdjoint (outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim))
      (S : ℕ → UnboundedSelfAdjoint (outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim)),
      IsSelfAdjointExtension (nsFamily hB hbv hnu hlam hmu hgg).outerHam T.op ∧
        (∀ N, IsSelfAdjointExtension
          (SqFamily.truncHam (nsFamily hB hbv hnu hlam hmu hgg) N) (S N).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim),
          ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim),
          prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim,
          IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ N, IsShiftInvertC (S N).op (((l : ℝ) : ℂ) * Complex.I) (-((S N).resCLM l))) ∧
            ∀ u : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim,
              Tendsto (fun N => -((S N).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim) (t : ℝ),
          Tendsto (fun N => (S N).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  ⟨nsOuterFock_esa_farisLavine hB hbv hnu hlam hmu hgg,
    nsOuterFock_timeIndependent_singleTime hB hbv hnu hlam hmu hgg⟩

end

end BookProof.NsOuterFock

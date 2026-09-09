import Mathlib
import BookProof.ChapterFiniteSectionSingleTime
import BookProof.ChapterFockSecondQuantization
import BookProof.ChapterQgCouplingDGammaSum

/-!
# The Weyl-gauge quantum Yang–Mills Hamiltonian is time-independent, and one finite time
# suffices

This is the quantum Yang–Mills counterpart of `BookProof.ChapterQgTimeIndependentFlow`
(quantum gravity) and `BookProof.ChapterNsTimeIndependentFlow` (Navier–Stokes).

In the **Weyl gauge** `A₀ = 0` the gauge-fixed Yang–Mills Hamiltonian is the sum of squares
of the *spatial* electric and magnetic field operators,

`H₁ = ½ Σ_m (π_m)² + ½ Σ_m (B_m)²`

(`BookProof.YangMillsHermite.ymHamiltonian`, with the sum-of-squares form
`ymHamiltonian_quadForm`).  The gauge condition removes the time component of the connection
outright: no time derivative and no time parameter enters, so the quantized Hamiltonian —
and its second quantization `dΓ(H₁)` on the Fock space over the Gauss–polynomial core of
`L²(ℝ⁹⁹)` — is a single fixed self-adjoint operator, an **autonomous** generator.  Combined
with `BookProof.ChapterSirkSingleTimeShift` (the SIRK/Hashimoto algorithm evaluates the
propagator at *one* finite time through the bounded shift-invert resolvent) this removes any
need for a discretization of time.

## What is proved

* **`ymFock_weylGauge_timeIndependent`** — unconditionally, for the physical second-quantized
  Yang–Mills Hamiltonian `dΓ(H₁)`: the Weyl-gauge sum-of-squares identity (first conjunct,
  the gauge-fixing content: only spatial fields occur), and the positive self-adjoint
  (Friedrichs) realization `T`, whose propagator `U(t,s) = e^{−i(t−s)H}` is unitary,
  satisfies Chapman–Kolmogorov, is **time-translation invariant** and **uniquely** solves the
  Schrödinger equation of the one fixed generator.  No time ordering and no Dyson series
  occurs.
* **`ymFock_timeIndependent_singleTime_of_esa`** — the full package, including the
  approximation half: given essential self-adjointness of `dΓ(H₁)` on the finite-occupation
  core, the finite sections (Galerkin truncations in the occupation basis) have self-adjoint
  realizations whose Hashimoto shift-invert operators converge at **every** nonzero shift,
  and whose propagators converge to the exact one at **every single finite time**.
* **`ymFock_diagonalBasis_timeIndependent_singleTime`** — the same *unconditionally* whenever
  the working basis diagonalizes the one-particle Yang–Mills Hamiltonian with non-negative
  eigenvalues (`ymFockCol e fabc = diagCol lam`), since then `dΓ(H₁)` is essentially
  self-adjoint on the finite-occupation core
  (`BookProof.QgCouplingDGammaSum.dGammaOp_diagCol_essentiallySelfAdjoint`).
* `exists_confEnum` — the enumeration of the occupation configurations used to build the
  windows exists, so the statements are not vacuous.

## Honest boundary

Unchanged from the rest of the Yang–Mills thread: **no mass gap** and no spectral information
is claimed, the cubic and quartic self-interaction of the one-particle operator is the one
recorded in `BookProof.YangMillsHermite`, and the essential self-adjointness of `dΓ(H₁)` on
the finite-occupation core is a hypothesis (only the Friedrichs extension is unconditional) —
it is discharged exactly when the working basis diagonalizes the one-particle operator.  What
is proved is the evolution statement: the generator carries no time dependence, and the
algorithm evaluates its propagator at a single finite time through a bounded shift-invert
resolvent.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QymTimeIndependent

open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization BookProof.QgCouplingDGammaSum
open BookProof.YangMillsHermite BookProof.HermiteGalerkin BookProof.HermiteProductCore
open BookProof.NavierStokesFlow

noncomputable section

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

/-- The matrix of the one-particle Yang–Mills Hamiltonian in the product Hermite basis is
Hermitian. -/
theorem isHermCol_ymFockCol : IsHermCol (ymFockCol e fabc) :=
  isHermCol_opCol (ymHamiltonian_symmetricOn (coreRepBasis e) fabc)

theorem dGammaOp_ymFockCol_symmetricOn :
    SymmetricOn (lpFiniteModes Conf) (dGammaOp (ymFockCol e fabc)) :=
  dGammaOp_symmetricOn (isHermCol_ymFockCol e fabc)

/-! ## 1. The Weyl gauge: an autonomous generator -/

/-- **The Weyl-gauge Yang–Mills Hamiltonian is time-independent.**

The first conjunct is the gauge-fixing content itself: in the Weyl gauge `A₀ = 0` the
one-particle Hamiltonian is the sum of squares of the *spatial* electric and magnetic field
operators, `⟪x, H₁ x⟫ = ½ Σ ‖π_m x‖² + ½ Σ ‖B_m x‖²`; no time component of the connection and
no time derivative occurs.  Consequently its second quantization `dΓ(H₁)` is one fixed
positive self-adjoint (Friedrichs) operator `T`, and the remaining conjuncts say that its
propagator `U(t,s) = e^{−i(t−s)H}` is unitary, obeys Chapman–Kolmogorov, is invariant under a
common shift of both times and uniquely solves the Schrödinger equation — so the evolution
problem is the evaluation of one unitary group at one finite time, with no time ordering and
no Dyson series. -/
theorem ymFock_weylGauge_timeIndependent :
    (∀ x : finiteModeDomain (coreBasis e),
        quadForm (ymHamiltonian (coreRepBasis e) fabc) x
          = 1 / 2 * (∑ m, ‖((piOps (coreRepBasis e) m x : finiteModeDomain (coreBasis e)) :
              L2d 99)‖ ^ 2)
            + 1 / 2 * ∑ m, ‖((magOps (coreRepBasis e) fabc m x :
                finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2) ∧
      ∃ T : UnboundedSelfAdjoint Fock,
        IsSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) T.op ∧
          (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
          (∀ (t s : ℝ) (x : Fock), ‖prop T t s x‖ = ‖x‖) ∧
          (∀ (t s r : ℝ) (x : Fock), prop T t s (prop T s r x) = prop T t r x) ∧
          (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
          (∀ y : ℝ → Fock, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) := by
  refine ⟨fun x => ymHamiltonian_quadForm (coreRepBasis e) fabc x, ?_⟩
  obtain ⟨Dom, A, hA⟩ := ym_fock_friedrichs_extension e fabc
  exact timeIndependent_of_selfAdjointExtension finiteOccupation_dense
    (isSelfAdjointExtension_of_positive hA)

/-! ## 2. The finite sections: one shift, one finite time -/

/-- **The Yang–Mills finite-section scheme needs no discretization of time.**  Given essential
self-adjointness of `dΓ(H₁)` on the finite-occupation core — the hypothesis that selects the
generator without appealing to the Friedrichs construction — the exact Hamiltonian and its
finite sections in the occupation basis have self-adjoint realizations, the propagator of the
exact one is time-translation invariant and uniquely solves the Schrödinger equation, the
Hashimoto shift-invert operators of the finite sections converge at **every** nonzero shift,
and their propagators converge to the exact one at **every single finite time**. -/
theorem ymFock_timeIndependent_singleTime_of_esa (en : ℕ ≃ Conf)
    (hesa : EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (ymFockCol e fabc))) :
    ∃ (T : UnboundedSelfAdjoint Fock) (S : ℕ → UnboundedSelfAdjoint Fock),
      IsSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp (dGammaOp (ymFockCol e fabc)) (windowOfEquiv en n) :
              Fock →ₗ[ℂ] Fock)).comp (lpFiniteModes Conf).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Fock), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Fock), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
        (∀ y : ℝ → Fock, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Fock, Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Fock) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  finiteSection_singleTime (dGammaOp (ymFockCol e fabc))
    (dGammaOp_ymFockCol_symmetricOn e fabc) hesa (windowOfEquiv_exhausts en)

/-- **The unconditional instance: a basis diagonalizing the one-particle Hamiltonian.**  If
the product Hermite basis diagonalizes the gauge-fixed one-particle Yang–Mills Hamiltonian
with non-negative eigenvalues `lam`, then `dΓ(H₁)` is essentially self-adjoint on the
finite-occupation core, and the whole package of
`ymFock_timeIndependent_singleTime_of_esa` holds with no further hypothesis. -/
theorem ymFock_diagonalBasis_timeIndependent_singleTime (en : ℕ ≃ Conf) (lam : ℕ → ℝ)
    (hlam : ∀ k, 0 ≤ lam k) (hdiag : ymFockCol e fabc = diagCol lam) :
    ∃ (T : UnboundedSelfAdjoint Fock) (S : ℕ → UnboundedSelfAdjoint Fock),
      IsSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp (dGammaOp (ymFockCol e fabc)) (windowOfEquiv en n) :
              Fock →ₗ[ℂ] Fock)).comp (lpFiniteModes Conf).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Fock), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Fock), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
        (∀ y : ℝ → Fock, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Fock, Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Fock) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by
  refine ymFock_timeIndependent_singleTime_of_esa e fabc en ?_
  rw [hdiag]
  exact dGammaOp_diagCol_essentiallySelfAdjoint hlam

/-- The configurations are enumerable, so the window family used above exists: the statements
are not vacuous. -/
theorem exists_confEnum : Nonempty (ℕ ≃ Conf) := nonempty_equiv_of_countable

end

end BookProof.QymTimeIndependent

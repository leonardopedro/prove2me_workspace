-- Generated from ChapterQymTimeIndependentFlow.lean — solution of BookProof.QymTimeIndependent.ymFock_weylGauge_timeIndependent
import Mathlib
import Definitions.Def_ChapterQymTimeIndependentFlow
import Theorems.Thm_BookProof_EsaClosure_isSelfAdjointExtension_of_positive
import Theorems.Thm_BookProof_FiniteSectionSingleTime_timeIndependent_of_selfAdjointExtension
import Theorems.Thm_BookProof_FockSecondQuantization_ym_fock_friedrichs_extension
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_quadForm
open BookProof.QymTimeIndependent




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

set_option maxHeartbeats 1000000 in
product Hermite basis is
Hermitian. -/
theorem solution : IsHermCol (ymFockCol e fabc) :=
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
        IsSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) T.op ∧ :=
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
            (∀ (t s : ℝ) (x : Fock), ‖prop T t s x‖ = ‖x‖) ∧
            (∀ (t s r : ℝ) (x : Fock), prop T t s (prop T s r x) = prop T t r x) ∧
            (∀ t s u : ℝ, prop T (t + u)
